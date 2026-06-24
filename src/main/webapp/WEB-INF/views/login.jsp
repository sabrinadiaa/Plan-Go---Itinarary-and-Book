<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login - Plan & Go</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: Arial, sans-serif;
            background: #f8f6f0;
            color: #2e2e2e;
        }

        .auth-page {
            min-height: 100vh;
            display: grid;
            grid-template-columns: 1.15fr 0.85fr;
        }

        /* LEFT SIDE */
        .auth-visual {
            position: relative;
            padding: 34px;
            overflow: hidden;
            background: #1f3227;
            color: white;
        }

        .auth-visual::before {
            content: "";
            position: absolute;
            inset: 0;
            background:
                linear-gradient(120deg, rgba(31,50,39,0.95), rgba(31,50,39,0.45)),
                url("https://images.unsplash.com/photo-1537996194471-e657df975ab4?q=80&w=1400&auto=format&fit=crop");
            background-size: cover;
            background-position: center;
            z-index: 0;
        }

        .visual-content {
            position: relative;
            z-index: 2;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .brand {
            font-size: 28px;
            font-weight: 900;
            letter-spacing: 1px;
        }

        .visual-title {
            max-width: 520px;
        }

        .visual-title h1 {
            margin: 0 0 14px;
            font-size: 56px;
            line-height: 1.05;
        }

        .visual-title p {
            margin: 0;
            font-size: 17px;
            line-height: 1.6;
            color: rgba(255,255,255,0.82);
        }

        .destination-collage {
            position: absolute;
            right: 34px;
            bottom: 34px;
            width: 410px;
            height: 340px;
            z-index: 1;
        }

        .photo-card {
            position: absolute;
            overflow: hidden;
            border-radius: 24px;
            box-shadow: 0 18px 40px rgba(0,0,0,0.35);
            border: 4px solid rgba(255,255,255,0.18);
        }

        .photo-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .photo-card.one {
            width: 210px;
            height: 260px;
            left: 0;
            top: 50px;
            transform: rotate(-5deg);
        }

        .photo-card.two {
            width: 190px;
            height: 210px;
            right: 10px;
            top: 0;
            transform: rotate(6deg);
        }

        .photo-card.three {
            width: 190px;
            height: 160px;
            right: 20px;
            bottom: 0;
            transform: rotate(-3deg);
        }

        .photo-card.four {
            width: 150px;
            height: 130px;
            left: 140px;
            bottom: 20px;
            transform: rotate(7deg);
        }

        .visual-badge {
            width: fit-content;
            margin-top: 22px;
            background: rgba(255,255,255,0.16);
            border: 1px solid rgba(255,255,255,0.25);
            color: white;
            padding: 10px 16px;
            border-radius: 999px;
            font-weight: 800;
            font-size: 13px;
        }

        /* RIGHT SIDE */
        .auth-panel {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 36px;
            background:
                radial-gradient(circle at top right, rgba(79,127,95,0.16), transparent 35%),
                #f8f6f0;
        }

        .auth-card {
            width: 100%;
            max-width: 430px;
            background: rgba(255,255,255,0.94);
            border-radius: 30px;
            padding: 34px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.12);
        }

        .auth-card h2 {
            margin: 0 0 8px;
            font-size: 34px;
            color: #2e2e2e;
        }

        .auth-card .subtitle {
            margin: 0 0 26px;
            color: #777;
            line-height: 1.5;
        }

        .auth-tabs {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            background: #eee9df;
            padding: 6px;
            border-radius: 20px;
            margin-bottom: 22px;
        }

        .auth-tabs button {
            border: none;
            background: transparent;
            padding: 12px;
            border-radius: 16px;
            font-weight: 900;
            cursor: pointer;
            color: #777;
        }

        .auth-tabs button.active {
            background: #4f7f5f;
            color: white;
        }

        .auth-form {
            display: none;
        }

        .auth-form.active {
            display: block;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 13px;
            font-weight: 900;
            color: #4f7f5f;
        }

        .form-group input {
            width: 100%;
            border: 1px solid #ded7cc;
            background: #fbfaf7;
            padding: 14px 15px;
            border-radius: 16px;
            outline: none;
            font-size: 14px;
        }

        .form-group input:focus {
            border-color: #4f7f5f;
            box-shadow: 0 0 0 4px rgba(79,127,95,0.12);
        }

        .auth-btn {
            width: 100%;
            border: none;
            background: #4f7f5f;
            color: white;
            padding: 15px;
            border-radius: 18px;
            font-size: 15px;
            font-weight: 900;
            cursor: pointer;
            margin-top: 6px;
        }

        .auth-btn:hover {
            background: #3f6c4d;
        }

        .error-box {
            background: #ffe4e4;
            color: #b91c1c;
            padding: 12px 14px;
            border-radius: 14px;
            font-size: 13px;
            margin-bottom: 18px;
            font-weight: 700;
        }

        .helper-text {
            margin: 18px 0 0;
            text-align: center;
            color: #777;
            font-size: 13px;
        }

        .helper-text span {
            color: #4f7f5f;
            font-weight: 900;
        }

        @media (max-width: 900px) {
            .auth-page {
                grid-template-columns: 1fr;
            }

            .auth-visual {
                min-height: 300px;
            }

            .visual-title h1 {
                font-size: 38px;
            }

            .destination-collage {
                display: none;
            }

            .auth-panel {
                padding: 24px;
            }
        }
    </style>
</head>

<body>

<div class="auth-page">

    <section class="auth-visual">
        <div class="visual-content">
            <div class="brand">Plan & Go</div>

            <div class="visual-title">
                <h1>Explore beautiful places with one simple plan.</h1>
            </div>
        </div>

        <div class="destination-collage">
            <div class="photo-card one">
                <img src="https://images.unsplash.com/photo-1537953773345-d172ccf13cf1?q=80&w=900&auto=format&fit=crop" alt="Bali">
            </div>

            <div class="photo-card two">
                <img src="https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=900&auto=format&fit=crop" alt="Beach">
            </div>

            <div class="photo-card three">
                <img src="https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?q=80&w=900&auto=format&fit=crop" alt="Nature">
            </div>

            <div class="photo-card four">
                <img src="https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?q=80&w=900&auto=format&fit=crop" alt="Temple">
            </div>
        </div>
    </section>

    <section class="auth-panel">
        <div class="auth-card">
            <h2>Welcome Back</h2>
            <p class="subtitle">Masuk ke akunmu untuk lanjut membuat perjalanan baru.</p>

            <c:if test="${not empty error}">
                <div class="error-box">
                    ${error}
                </div>
            </c:if>

            <div class="auth-tabs">
                <button type="button" id="loginTab" class="active" onclick="showLogin()">Login</button>
                <button type="button" id="registerTab" onclick="showRegister()">Register</button>
            </div>

            <form id="loginForm" class="auth-form active" method="post" action="/login">
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" placeholder="Masukkan email" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Masukkan password" required>
                </div>

                <button class="auth-btn" type="submit">Login</button>

                <p class="helper-text">
                    Belum punya akun? <span onclick="showRegister()" style="cursor:pointer;">Daftar sekarang</span>
                </p>
            </form>

            <form id="registerForm" class="auth-form" method="post" action="/register">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" placeholder="Masukkan username" required>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" placeholder="Masukkan email" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Buat password" required>
                </div>

                <button class="auth-btn" type="submit">Register</button>

                <p class="helper-text">
                    Sudah punya akun? <span onclick="showLogin()" style="cursor:pointer;">Login di sini</span>
                </p>
            </form>
        </div>
    </section>

</div>

<script>
    function showLogin() {
        document.getElementById("loginForm").classList.add("active");
        document.getElementById("registerForm").classList.remove("active");

        document.getElementById("loginTab").classList.add("active");
        document.getElementById("registerTab").classList.remove("active");
    }

    function showRegister() {
        document.getElementById("registerForm").classList.add("active");
        document.getElementById("loginForm").classList.remove("active");

        document.getElementById("registerTab").classList.add("active");
        document.getElementById("loginTab").classList.remove("active");
    }

    <c:if test="${registerMode}">
        showRegister();
    </c:if>
</script>

</body>
</html>