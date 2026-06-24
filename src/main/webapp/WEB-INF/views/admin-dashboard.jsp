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
                <p class="brand">ADMIN HOME</p>
                <h1>Manage Destinations</h1>
                <p class="subtitle">Halaman admin versi JSP untuk melihat data destination dari MySQL.</p>
            </div>
        </section>

        <section class="grid">
            <c:forEach var="destination" items="${destinations}">
                <article class="card dest-card">
                    <c:if test="${not empty destination.imageUrl}">
                        <img class="dest-img" src="${destination.imageUrl}" alt="${destination.name}">
                    </c:if>
                    <div class="dest-content">
                        <span class="badge">${destination.category}</span>
                        <h3 style="margin-top:12px;">${destination.name}</h3>
                        <p class="subtitle">📍 ${destination.location}</p>
                        <p class="price">Rp ${destination.price}</p>
                    </div>
                </article>
            </c:forEach>
        </section>
    </main>

    <nav class="bottom-nav admin-nav">
        <a class="nav-item active" href="/admin/dashboard"><br>Home</a>
        <a class="nav-item" href="/admin/booking"><br>Booking</a>
        <a class="nav-item" href="/admin/track-record"><br>Track</a>
    </nav>
</div>
</body>
</html>
