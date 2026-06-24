package com.plango.controller;

import com.plango.service.BookingService;
import com.plango.repository.DestinationRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminPageController {

    private final DestinationRepository destinationRepository;
    private final BookingService bookingService;

    public AdminPageController(DestinationRepository destinationRepository, BookingService bookingService) {
        this.destinationRepository = destinationRepository;
        this.bookingService = bookingService;
    }

    @GetMapping("/admin/dashboard")
    public String dashboard(HttpSession session, Model model) {
        String guard = requireAdmin(session);
        if (guard != null) return guard;

        model.addAttribute("destinations", destinationRepository.findAll());
        return "admin-dashboard";
    }

    @GetMapping("/admin/booking")
    public String adminBooking(HttpSession session, Model model) {
        String guard = requireAdmin(session);
        if (guard != null) return guard;

        model.addAttribute("bookings", bookingService.findAll());
        return "admin-booking";
    }

    @PostMapping("/admin/booking/{id}/status")
    public String updateBookingStatus(
            @PathVariable Long id,
            @RequestParam String status,
            HttpSession session
    ) {
        String guard = requireAdmin(session);
        if (guard != null) return guard;

        bookingService.updateStatus(id, status);
        return "redirect:/admin/booking";
    }

    @GetMapping("/admin/track-record")
    public String trackRecord(HttpSession session) {
        String guard = requireAdmin(session);
        if (guard != null) return guard;

        return "admin-track-record";
    }

    private String requireAdmin(HttpSession session) {
        Object userId = session.getAttribute("userId");
        Object role = session.getAttribute("role");

        if (userId == null) {
            return "redirect:/login";
        }

        if (!"ADMIN".equalsIgnoreCase(String.valueOf(role))) {
            return "redirect:/explore";
        }

        return null;
    }
}
