package com.plango.controller;

import com.plango.entity.Booking;
import com.plango.entity.Destination;
import com.plango.entity.Review;
import com.plango.entity.User;
import com.plango.repository.DestinationRepository;
import com.plango.repository.ReviewRepository;
import com.plango.repository.UserRepository;
import com.plango.service.BookingService;
import com.plango.service.ItineraryService;
import com.plango.service.PaymentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Controller
public class CustomerPageController {

    private final DestinationRepository destinationRepository;
    private final ReviewRepository reviewRepository;
    private final UserRepository userRepository;
    private final ItineraryService itineraryService;
    private final BookingService bookingService;
    private final PaymentService paymentService;

    public CustomerPageController(
            DestinationRepository destinationRepository,
            ReviewRepository reviewRepository,
            UserRepository userRepository,
            ItineraryService itineraryService,
            BookingService bookingService,
            PaymentService paymentService
    ) {
        this.destinationRepository = destinationRepository;
        this.reviewRepository = reviewRepository;
        this.userRepository = userRepository;
        this.itineraryService = itineraryService;
        this.bookingService = bookingService;
        this.paymentService = paymentService;
    }

    @GetMapping("/destination/{id}")
    public String destinationDetail(
            @PathVariable Long id,
            HttpSession session,
            Model model
    ) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        Destination destination = destinationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Destination tidak ditemukan"));

        model.addAttribute("destination", destination);
        model.addAttribute("reviews", reviewRepository.findByDestinationId(id));
        model.addAttribute("itineraries", itineraryService.findByUserId(currentUserId(session)));

        return "destination-detail";
    }

    @PostMapping("/destination/{id}/quick-plan")
    public String quickPlanFromDestination(
            @PathVariable Long id,
            HttpSession session
    ) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        Destination destination = destinationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Destination tidak ditemukan"));

        var itinerary = itineraryService.create(
                currentUserId(session),
                "Trip ke " + destination.getName(),
                1
        );

        itineraryService.addDestination(itinerary.getId(), id);

        return "redirect:/plan/" + itinerary.getId();
    }

    @GetMapping("/plan")
    public String plan(HttpSession session, Model model) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        model.addAttribute("itineraries", itineraryService.findByUserId(currentUserId(session)));

        return "plan";
    }

    @PostMapping("/plan/create")
    public String createPlan(
            @RequestParam String title,
            @RequestParam Integer totalPeople,
            HttpSession session
    ) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        itineraryService.create(currentUserId(session), title, totalPeople);

        return "redirect:/plan";
    }

    @GetMapping("/plan/{id}")
    public String planDetail(
            @PathVariable Long id,
            HttpSession session,
            Model model
    ) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        Long userId = currentUserId(session);

        Booking existingBooking = bookingService
                .findExistingBooking(userId, id)
                .orElse(null);

        boolean alreadyPaid = existingBooking != null
                && "SUCCESS".equalsIgnoreCase(String.valueOf(existingBooking.getStatus()));

        boolean hasPendingBooking = existingBooking != null
                && !"SUCCESS".equalsIgnoreCase(String.valueOf(existingBooking.getStatus()));

        model.addAttribute("itinerary", itineraryService.findById(id));
        model.addAttribute("destinations", destinationRepository.findAll());

        model.addAttribute("existingBooking", existingBooking);
        model.addAttribute("alreadyPaid", alreadyPaid);
        model.addAttribute("hasPendingBooking", hasPendingBooking);

        return "plan-detail";
    }

    @PostMapping("/plan/{id}/add-destination")
    public String addDestinationToPlan(
            @PathVariable Long id,
            @RequestParam Long destinationId,
            HttpSession session
    ) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        itineraryService.addDestination(id, destinationId);

        return "redirect:/plan/" + id;
    }

    @PostMapping("/plan/item/{itemId}/update-time")
    public String updatePlanItemTime(
            @PathVariable Long itemId,
            @RequestParam Long itineraryId,
            @RequestParam String visitDate,
            @RequestParam String visitTime,
            HttpSession session
    ) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        LocalDate date = LocalDate.parse(visitDate);
        LocalTime time = LocalTime.parse(visitTime);
        LocalDateTime visitDateTime = LocalDateTime.of(date, time);

        itineraryService.updateVisitTime(itemId, visitDateTime);

        return "redirect:/plan/" + itineraryId;
    }

    @PostMapping("/plan/item/{itemId}/delete")
    public String deletePlanItem(
            @PathVariable Long itemId,
            @RequestParam Long itineraryId,
            HttpSession session
    ) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        itineraryService.deleteItem(itemId);

        return "redirect:/plan/" + itineraryId;
    }

    @PostMapping("/plan/{id}/booking")
    public String createBooking(
            @PathVariable Long id,
            HttpSession session
    ) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        Booking booking = bookingService.createBooking(currentUserId(session), id);

        if ("SUCCESS".equalsIgnoreCase(String.valueOf(booking.getStatus()))) {
            return "redirect:/payment-success?bookingId=" + booking.getId();
        }

        return "redirect:/payment/" + booking.getId();
    }

    @GetMapping("/booking")
    public String booking(HttpSession session, Model model) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        model.addAttribute("bookings", bookingService.findByUserId(currentUserId(session)));

        return "booking";
    }

    @PostMapping("/booking/{id}/delete")
    public String deleteBooking(
            @PathVariable Long id,
            HttpSession session
    ) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        bookingService.deleteById(id);

        return "redirect:/plan";
    }

    @GetMapping("/payment/{bookingId}")
    public String paymentPage(
            @PathVariable Long bookingId,
            HttpSession session,
            Model model
    ) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        Booking booking = bookingService.findById(bookingId);

        if ("SUCCESS".equalsIgnoreCase(String.valueOf(booking.getStatus()))) {
            return "redirect:/payment-success?bookingId=" + bookingId;
        }

        model.addAttribute("booking", booking);

        return "payment";
    }

    @PostMapping("/payment/{bookingId}")
    public String pay(
            @PathVariable Long bookingId,
            @RequestParam String method,
            HttpSession session
    ) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        try {
            paymentService.createPayment(bookingId, method);
        } catch (Exception error) {
            System.out.println("Payment gagal disimpan: " + error.getMessage());
        }

        bookingService.updateStatus(bookingId, "SUCCESS");

        session.setAttribute("lastPaymentMethod", method);

        return "redirect:/payment-success?bookingId=" + bookingId;
    }

    @GetMapping("/payment-success")
    public String paymentSuccess(
            @RequestParam(required = false) Long bookingId,
            HttpSession session,
            Model model
    ) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        if (bookingId != null) {
            Booking booking = bookingService.findById(bookingId);
            model.addAttribute("booking", booking);
        }

        model.addAttribute("email", session.getAttribute("email"));
        model.addAttribute("paymentMethod", session.getAttribute("lastPaymentMethod"));

        return "payment-success";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        Long userId = currentUserId(session);
        User user = userRepository.findById(userId).orElse(null);

        model.addAttribute("user", user);
        model.addAttribute("payments", paymentService.findByUserId(userId));

        return "profile";
    }

    @GetMapping("/review/{destinationId}")
    public String reviewPage(
            @PathVariable Long destinationId,
            HttpSession session,
            Model model
    ) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        model.addAttribute("destination", destinationRepository.findById(destinationId).orElse(null));

        return "review";
    }

    @PostMapping("/review/{destinationId}")
    public String createReview(
            @PathVariable Long destinationId,
            @RequestParam Integer rating,
            @RequestParam String comment,
            HttpSession session
    ) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        User user = userRepository.findById(currentUserId(session)).orElse(null);
        Destination destination = destinationRepository.findById(destinationId).orElse(null);

        if (user != null && destination != null) {
            Review review = new Review();

            review.setUser(user);
            review.setDestination(destination);
            review.setRating(rating);
            review.setComment(comment);
            review.setReviewDate(LocalDateTime.now());

            reviewRepository.save(review);
        }

        return "redirect:/destination/" + destinationId;
    }

    @GetMapping("/emergency")
    public String emergency(HttpSession session) {
        String guard = requireCustomer(session);
        if (guard != null) return guard;

        return "emergency";
    }

    private Long currentUserId(HttpSession session) {
        Object userId = session.getAttribute("userId");

        if (userId instanceof Long) {
            return (Long) userId;
        }

        if (userId instanceof Integer) {
            return ((Integer) userId).longValue();
        }

        return Long.valueOf(String.valueOf(userId));
    }

    private String requireCustomer(HttpSession session) {
        Object userId = session.getAttribute("userId");
        Object role = session.getAttribute("role");

        if (userId == null) {
            return "redirect:/login";
        }

        if ("ADMIN".equalsIgnoreCase(String.valueOf(role))) {
            return "redirect:/admin/dashboard";
        }

        return null;
    }
}