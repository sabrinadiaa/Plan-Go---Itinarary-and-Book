package com.plango.controller;

import com.plango.entity.Destination;
import com.plango.entity.EmergencyReport;
import com.plango.repository.DestinationRepository;
import com.plango.repository.EmergencyReportRepository;
import com.plango.service.BookingService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class AdminPageController {

    private final DestinationRepository destinationRepository; /* contoh alur: akses dest repo*/
    private final BookingService bookingService;
    private final EmergencyReportRepository emergencyReportRepository;

    public AdminPageController( /*repo dimasukkan lewat constructor */
            DestinationRepository destinationRepository,
            BookingService bookingService,
            EmergencyReportRepository emergencyReportRepository
    ) {
        this.destinationRepository = destinationRepository;
        this.bookingService = bookingService;
        this.emergencyReportRepository = emergencyReportRepository;
    }

    @GetMapping("/admin/dashboard") 
    public String dashboard(HttpSession session, Model model) {
        String guard = requireAdmin(session);
        if (guard != null) return guard;

        model.addAttribute("destinations", destinationRepository.findAll()); /*memanggil repository */

        return "admin-dashboard";
    }

    @PostMapping("/admin/destination/create")
    public String createDestination(
            @RequestParam String name,
            @RequestParam String location,
            @RequestParam String category,
            @RequestParam String description,
            @RequestParam Double price,
            @RequestParam(required = false) String imageUrl,
            @RequestParam(required = false) Double latitude,
            @RequestParam(required = false) Double longitude,
            HttpSession session
    ) {
        String guard = requireAdmin(session);
        if (guard != null) return guard;

        Destination destination = new Destination();

        destination.setName(name);
        destination.setLocation(location);
        destination.setCategory(category);
        destination.setDescription(description);
        destination.setPrice(price);
        destination.setImageUrl(imageUrl);
        destination.setLatitude(latitude);
        destination.setLongitude(longitude);

        destinationRepository.createFromAdmin(destination);

        return "redirect:/admin/dashboard";
    }

    @PostMapping("/admin/destination/{id}/update")
    public String updateDestination(
            @PathVariable Long id,
            @RequestParam String name,
            @RequestParam String location,
            @RequestParam String category,
            @RequestParam String description,
            @RequestParam Double price,
            @RequestParam(required = false) String imageUrl,
            @RequestParam(required = false) Double latitude,
            @RequestParam(required = false) Double longitude,
            HttpSession session
    ) {
        String guard = requireAdmin(session);
        if (guard != null) return guard;

        Destination destination = new Destination();

        destination.setId(id);
        destination.setName(name);
        destination.setLocation(location);
        destination.setCategory(category);
        destination.setDescription(description);
        destination.setPrice(price);
        destination.setImageUrl(imageUrl);
        destination.setLatitude(latitude);
        destination.setLongitude(longitude);

        destinationRepository.updateFromAdmin(destination);

        return "redirect:/admin/dashboard";
    }

    @PostMapping("/admin/destination/{id}/delete")
    public String deleteDestination(
            @PathVariable Long id,
            HttpSession session
    ) {
        String guard = requireAdmin(session);
        if (guard != null) return guard;

        destinationRepository.deleteFromAdmin(id);

        return "redirect:/admin/dashboard";
    }

    @GetMapping("/admin/booking")
    public String adminBooking(HttpSession session, Model model) {
        String guard = requireAdmin(session);
        if (guard != null) return guard;

        model.addAttribute("bookings", bookingService.findAll()); /* memanggil service */

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
    public String trackRecord(HttpSession session, Model model) {
        String guard = requireAdmin(session);
        if (guard != null) return guard;

        List<EmergencyReport> emergencyReports = emergencyReportRepository.findAll(); /*repo */

        long urgentCount = emergencyReports.stream()
                .filter(report -> "PENDING".equalsIgnoreCase(String.valueOf(report.getStatus())))
                .count();

        long safeCount = emergencyReports.stream()
                .filter(report -> "DONE".equalsIgnoreCase(String.valueOf(report.getStatus())))
                .count();

        model.addAttribute("emergencyReports", emergencyReports);
        model.addAttribute("activeTravelers", emergencyReports.size());
        model.addAttribute("safeCount", safeCount);
        model.addAttribute("urgentCount", urgentCount);

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