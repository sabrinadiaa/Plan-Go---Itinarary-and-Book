package com.plango.controller;

import com.plango.entity.Booking;
import com.plango.entity.Destination;
import com.plango.service.BookingService;
import com.plango.repository.DestinationRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ExploreController {

    private final DestinationRepository destinationRepository;
    private final BookingService bookingService;

    public ExploreController(
            DestinationRepository destinationRepository,
            BookingService bookingService
    ) {
        this.destinationRepository = destinationRepository;
        this.bookingService = bookingService;
    }

    @GetMapping("/explore")
    public String explorePage(HttpSession session, Model model) {
        if (!isCustomer(session)) {
            return "redirect:/login";
        }

        Long userId = currentUserId(session);

        List<Destination> destinations = destinationRepository.findAll();
        List<Booking> bookings = bookingService.findByUserId(userId);

        Booking activeJourney = bookings.isEmpty() ? null : bookings.get(0);
        Booking historyJourney = bookings.size() > 1 ? bookings.get(1) : null;

        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("destinations", destinations);
        model.addAttribute("recommendedDestinations", destinations.stream().limit(4).toList());

        model.addAttribute("activeJourney", activeJourney);
        model.addAttribute("historyJourney", historyJourney);

        model.addAttribute("defaultJourneyImage",
                "https://images.unsplash.com/photo-1537996194471-e657df975ab4?q=80&w=1200&auto=format&fit=crop"
        );

        return "explore";
    }

    @GetMapping("/explore/all")
    public String exploreAllPage(
            @RequestParam(defaultValue = "ALL") String category,
            @RequestParam(required = false) Long itineraryId,
            HttpSession session,
            Model model
    ) {
        if (!isCustomer(session)) {
            return "redirect:/login";
        }

        List<Destination> destinations = destinationRepository.findAll();

        List<Destination> filteredDestinations = destinations.stream()
                .filter(destination -> matchesCategory(destination, category))
                .toList();

        model.addAttribute("category", category);
        model.addAttribute("itineraryId", itineraryId);
        model.addAttribute("destinations", filteredDestinations);

        return "exploreAll";
    }

    private boolean matchesCategory(Destination destination, String selectedCategory) {
        if (selectedCategory == null || selectedCategory.equalsIgnoreCase("ALL")) {
            return true;
        }

        String destinationCategory = destination.getCategory() == null
                ? ""
                : destination.getCategory().toUpperCase();

        return destinationCategory.equals(selectedCategory.toUpperCase());
    }

    private boolean isCustomer(HttpSession session) {
        Object userId = session.getAttribute("userId");
        Object role = session.getAttribute("role");

        if (userId == null) {
            return false;
        }

        return !"ADMIN".equalsIgnoreCase(String.valueOf(role));
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
}