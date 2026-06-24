package com.plango.controller;

import com.plango.dto.auth.LoginRequest;
import com.plango.dto.auth.LoginResponse;
import com.plango.dto.auth.RegisterRequest;
import com.plango.service.AuthService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PageAuthController {

    private final AuthService authService;

    public PageAuthController(AuthService authService) {
        this.authService = authService;
    }

    @GetMapping("/")
    public String homePage() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String loginProcess(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            Model model
    ) {
        LoginRequest request = new LoginRequest();
        request.setEmail(email);
        request.setPassword(password);

        LoginResponse response = authService.login(request);

        if (!response.isSuccess()) {
            model.addAttribute("error", response.getMessage());
            return "login";
        }

        saveUserToSession(session, response);

        String role = response.getData().getRole();

        if ("ADMIN".equalsIgnoreCase(role)) {
            return "redirect:/admin/dashboard";
        }

        return "redirect:/explore";
    }

    @PostMapping("/register")
    public String registerProcess(
            @RequestParam String username,
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            Model model
    ) {
        RegisterRequest request = new RegisterRequest();
        request.setUsername(username);
        request.setEmail(email);
        request.setPassword(password);

        LoginResponse response = authService.register(request);

        if (!response.isSuccess()) {
            model.addAttribute("error", response.getMessage());
            model.addAttribute("registerMode", true);
            return "login";
        }

        saveUserToSession(session, response);

        return "redirect:/explore";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    private void saveUserToSession(HttpSession session, LoginResponse response) {
        session.setAttribute("userId", response.getData().getId());
        session.setAttribute("username", response.getData().getUsername());
        session.setAttribute("email", response.getData().getEmail());
        session.setAttribute("role", response.getData().getRole());

        session.setMaxInactiveInterval(30 * 60);
    }
}