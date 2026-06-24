package com.plango.controller;

import com.plango.repository.EmergencyReportRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class EmergencyController {

    private final EmergencyReportRepository emergencyReportRepository;

    public EmergencyController(EmergencyReportRepository emergencyReportRepository) {
        this.emergencyReportRepository = emergencyReportRepository;
    }

    @PostMapping("/emergency")
    public String sendEmergency(HttpSession session) {
        Object userIdObj = session.getAttribute("userId");

        if (userIdObj == null) {
            return "redirect:/login";
        }

        Long userId = Long.valueOf(String.valueOf(userIdObj));
        String username = String.valueOf(session.getAttribute("username"));
        String email = String.valueOf(session.getAttribute("email"));

        emergencyReportRepository.save(
                userId,
                username,
                email,
                "User menekan tombol emergency dari halaman Explore."
        );

        return "redirect:/explore?emergencySent=true";
    }

    @PostMapping("/admin/emergency/{id}/done")
    public String markEmergencyDone(@PathVariable Long id, HttpSession session) {
        Object role = session.getAttribute("role");

        if (!"ADMIN".equalsIgnoreCase(String.valueOf(role))) {
            return "redirect:/login";
        }

        emergencyReportRepository.updateStatus(id, "DONE");

        return "redirect:/admin/track-record";
    }
}