<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login - Plan & Go</title>

    <style>
        /* Digunakan agar ukuran elemen lebih konsisten dan tidak ada margin bawaan browser*/
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

        /*
            Halaman dibagi menjadi 2 bagian:
            kiri untuk visual/branding, kanan untuk form login dan register.
        */
        .auth-page {
            min-height: 100vh;
            display: grid;
            grid-template-columns: 1.15fr 0.85fr;
        }

        /* 
            Menampilkan gambar background dan nama web yaitu Plan & Go
        */
        .auth-visual {
            position: relative;
            padding: 34px;
            overflow: hidden;
            background: #1f3227;
            color: white;
        }

        /* 
            Background gambar login.
            Gambar diambil dari folder: src/main/resources/static/assets/images/login-bg.jpg
        */
        .auth-visual::before {
            content: "";
            position: absolute;
            inset: 0;
            background:
                linear-gradient(120deg, rgba(31,50,39,0.95), rgba(31,50,39,0.45)),
                url("/assets/bedugul.webp");
            background-size: cover;
            background-position: center;
            z-index: 0;
        }

        /* 
            Konten di atas background.
        */
        .visual-content {
            position: relative;
            z-index: 2; /* z-index digunakan supaya teks tidak tertutup oleh gambar background */
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
            margin: 0;
            font-size: 56px;
            line-height: 1.05;
        }

        /* Area untuk menampilkan card login dan register */
        .auth-panel {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 36px;
            background:
                radial-gradient(circle at top right, rgba(79,127,95,0.16), transparent 35%),
                #f8f6f0;
        }

        /* Card utama form */
        .auth-card {
            width: 100%;
            max-width: 430px;
            background: rgba(255,255,255,0.94);
            border-radius: 30px;
            padding: 34px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.12);
        }

        .auth-card h2 {
            margin: 0 0 22px;
            font-size: 34px;
            color: #2e2e2e;
        }

        /* Pesan error. Muncul jika login/register gagal dari controller*/
        .error-box {
            background: #ffe4e4;
            color: #b91c1c;
            padding: 12px 14px;
            border-radius: 14px;
            font-size: 13px;
            margin-bottom: 18px;
            font-weight: 700;
        }

        /* 
            TAB LOGIN DAN REGISTER
            Digunakan untuk berpindah form tanpa pindah halaman.
        */
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

        /* 
            FORM LOGIN DAN REGISTER
            Default disembunyikan, lalu yang aktif akan ditampilkan.
        */
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

        /* Tombol submit untuk login dan register */
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

        /* RESPONSIVE(Jika layar kecil, layout 2 kolom berubah menjadi 1 kolom) */
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

            .auth-panel {
                padding: 24px;
            }
        }
    </style>
</head>

<body>

<div class="auth-page">

    <!-- 
        SECTION KIRI (tampilan visual dan branding aplikasi)
    -->
    <section class="auth-visual">
        <div class="visual-content">
            <div class="brand">Plan & Go</div>

            <div class="visual-title">
                <h1>Explore beautiful places with one simple plan.</h1>
            </div>
        </div>
    </section>

    <!-- 
        SECTION KANAN
        (Bagian ini berisi form login dan register untuk user)
    -->
    <section class="auth-panel">
        <div class="auth-card">
            <h2>Welcome Back</h2>

            <!-- 
                Menampilkan pesan error dari controller.
                Contoh: email/password salah atau register gagal.
            -->
            <c:if test="${not empty error}">
                <div class="error-box">
                    ${error}
                </div>
            </c:if>

            <!-- 
                Tombol tab untuk memilih form Login atau Register.
            -->
            <div class="auth-tabs">
                <button type="button" id="loginTab" class="active" onclick="showLogin()">
                    Login
                </button>

                <button type="button" id="registerTab" onclick="showRegister()">
                    Register
                </button>
            </div>

            <!-- 
                FORM LOGIN
                Data dikirim ke endpoint POST /login.
            -->
            <form id="loginForm" class="auth-form active" method="post" action="/login">
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" placeholder="Enter your email" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Enter your password" required>
                </div>

                <button class="auth-btn" type="submit">Login</button>
            </form>

            <!-- 
                FORM REGISTER
                Data dikirim ke endpoint POST /register.
            -->
            <form id="registerForm" class="auth-form" method="post" action="/register">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" placeholder="Create your username" required>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" placeholder="Enter your email" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Enter your password" required>
                </div>

                <button class="auth-btn" type="submit">Register</button>
            </form>
        </div>
    </section>

</div>

<script>
    /*
        Fungsi showLogin()
        Digunakan untuk menampilkan form login dan menyembunyikan form register.
    */
    function showLogin() {
        document.getElementById("loginForm").classList.add("active");
        document.getElementById("registerForm").classList.remove("active");

        document.getElementById("loginTab").classList.add("active");
        document.getElementById("registerTab").classList.remove("active");
    }

    /*
        Fungsi showRegister()
        Digunakan untuk menampilkan form register dan menyembunyikan form login.
    */
    function showRegister() {
        document.getElementById("registerForm").classList.add("active");
        document.getElementById("loginForm").classList.remove("active");

        document.getElementById("registerTab").classList.add("active");
        document.getElementById("loginTab").classList.remove("active");
    }

    /*
        Jika controller mengirim registerMode = true,
        maka halaman otomatis membuka tab Register.
    */
    <c:if test="${registerMode}">
        showRegister();
    </c:if>
</script>

</body>
</html>