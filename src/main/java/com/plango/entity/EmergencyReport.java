package com.plango.entity;

import java.time.LocalDateTime;

public class EmergencyReport {

    private Long id;
    private Long userId;
    private String username;
    private String email;
    private String message;
    private String status;
    private LocalDateTime createdAt;

    public EmergencyReport() {
    }

    public EmergencyReport(Long id, Long userId, String username, String email, String message, String status, LocalDateTime createdAt) {
        this.id = id;
        this.userId = userId;
        this.username = username;
        this.email = email;
        this.message = message;
        this.status = status;
        this.createdAt = createdAt;
    }

    public Long getId() {
        return id;
    }

    public Long getUserId() {
        return userId;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getMessage() {
        return message;
    }

    public String getStatus() {
        return status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}