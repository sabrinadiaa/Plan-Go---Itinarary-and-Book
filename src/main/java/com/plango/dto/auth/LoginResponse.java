package com.plango.dto.auth;

public class LoginResponse {

    private boolean success;
    private String message;
    private UserData data;

    public LoginResponse() {
    }

    public LoginResponse(boolean success, String message, UserData data) {
        this.success = success;
        this.message = message;
        this.data = data;
    }

    public static LoginResponse success(UserData data) {
        return new LoginResponse(true, "Berhasil", data);
    }

    public static LoginResponse failed(String message) {
        return new LoginResponse(false, message, null);
    }

    public boolean isSuccess() {
        return success;
    }

    public String getMessage() {
        return message;
    }

    public UserData getData() {
        return data;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setData(UserData data) {
        this.data = data;
    }

    public static class UserData {

        private Long id;
        private String username;
        private String email;
        private String role;

        public UserData() {
        }

        public UserData(Long id, String username, String email, String role) {
            this.id = id;
            this.username = username;
            this.email = email;
            this.role = role;
        }

        public Long getId() {
            return id;
        }

        public String getUsername() {
            return username;
        }

        public String getEmail() {
            return email;
        }

        public String getRole() {
            return role;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public void setRole(String role) {
            this.role = role;
        }
    }
}