<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Plan & Go</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body>
<div class="page">

    <header class="topbar">
        <a class="logo" href="/admin/dashboard">Plan & Go Admin</a>
        <a class="btn btn-outline btn-small" href="/logout">Logout</a>
    </header>

    <main class="container">

        <section class="hero">
            <div>
                <p class="brand">MANAGE DESTINATION</p>
            </div>
        </section>

        <!-- CREATE DESTINATION -->
        <section class="card admin-form-card">
            <h2>Tambah Destinasi Baru</h2>

            <form method="post" action="/admin/destination/create" class="admin-destination-form">

                <div class="form-grid">
                    <div>
                        <label>Nama Destinasi</label>
                        <input class="input" type="text" name="name" placeholder="Contoh: Tanah Lot" required>
                    </div>

                    <div>
                        <label>Lokasi</label>
                        <input class="input" type="text" name="location" placeholder="Contoh: Bali, Indonesia" required>
                    </div>

                    <div>
                        <label>Kategori</label>
                        <select class="select" name="category" required>
                            <option value="NATURE">Nature</option>
                            <option value="CAFE">Cafe</option>
                            <option value="SHOPPING">Shopping</option>
                            <option value="HOTEL">Hotel</option>
                            <option value="CLUB">Club</option>
                        </select>
                    </div>

                    <div>
                        <label>Harga</label>
                        <input class="input" type="number" name="price" placeholder="Contoh: 75000" required>
                    </div>

                    <div>
                        <label>Latitude</label>
                        <input class="input" type="number" step="any" name="latitude" placeholder="Contoh: -8.6212">
                    </div>

                    <div>
                        <label>Longitude</label>
                        <input class="input" type="number" step="any" name="longitude" placeholder="Contoh: 115.0868">
                    </div>
                </div>

                <label>URL Gambar</label>
                <input class="input" type="text" name="imageUrl" placeholder="https://...">

                <label>Deskripsi</label>
                <textarea name="description" placeholder="Tulis deskripsi destinasi..." required></textarea>

                <button class="btn full" type="submit">Tambah Destinasi</button>
            </form>
        </section>

        <!-- LIST DESTINATION -->
        <section style="margin-top:28px;">
            <h2>Daftar Destinasi</h2>

            <div class="admin-destination-grid">
                <c:forEach var="destination" items="${destinations}">

                    <article class="card admin-destination-card">

                        <c:choose>
                            <c:when test="${not empty destination.imageUrl}">
                                <img class="admin-destination-img"
                                     src="${destination.imageUrl}"
                                     alt="${destination.name}">
                            </c:when>

                            <c:otherwise>
                                <div class="admin-destination-img admin-img-placeholder"></div>
                            </c:otherwise>
                        </c:choose>

                        <form method="post" action="/admin/destination/${destination.id}/update"
                              class="admin-destination-form">

                            <input class="input" type="text" name="name" value="${destination.name}" required>

                            <input class="input" type="text" name="location" value="${destination.location}" required>

                            <select class="select" name="category" required>
                                <option value="NATURE" ${destination.category == 'NATURE' ? 'selected' : ''}>Nature</option>
                                <option value="CAFE" ${destination.category == 'CAFE' ? 'selected' : ''}>Cafe</option>
                                <option value="SHOPPING" ${destination.category == 'SHOPPING' ? 'selected' : ''}>Shopping</option>
                                <option value="HOTEL" ${destination.category == 'HOTEL' ? 'selected' : ''}>Hotel</option>
                                <option value="CLUB" ${destination.category == 'CLUB' ? 'selected' : ''}>Club</option>
                            </select>

                            <input class="input" type="number" name="price" value="${destination.price}" required>

                            <input class="input" type="text" name="imageUrl" value="${destination.imageUrl}" placeholder="URL gambar">

                            <textarea name="description" required>${destination.description}</textarea>

                            <div class="form-grid">
                                <input class="input" type="number" step="any" name="latitude" value="${destination.latitude}" placeholder="Latitude">

                                <input class="input" type="number" step="any" name="longitude" value="${destination.longitude}" placeholder="Longitude">
                            </div>

                            <button class="btn full" type="submit">
                                Update
                            </button>
                        </form>

                        <form method="post"
                              action="/admin/destination/${destination.id}/delete"
                              onsubmit="return confirm('Yakin mau hapus destinasi ini?')"
                              style="margin-top:10px;">
                            <button class="btn btn-danger full" type="submit">
                                Delete
                            </button>
                        </form>

                    </article>

                </c:forEach>
            </div>
        </section>

    </main>

    <nav class="bottom-nav admin-nav">
    <a class="nav-item href="/admin/dashboard">
        <i class="fa-solid fa-house"></i><br>Home
    </a>

    <a class="nav-item active" href="/admin/booking">
        <i class="fa-solid fa-clipboard-list"></i><br>Booking
    </a>

    <a class="nav-item" href="/admin/track-record">
        <i class="fa-solid fa-chart-line"></i><br>Track
    </a>
</nav>

</div>
</body>
</html>