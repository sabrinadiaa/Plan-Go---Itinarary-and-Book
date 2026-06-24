<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>${destination.name} - Plan & Go</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body>
<div class="page">
    <header class="topbar">
        <a class="logo" href="/explore">Plan & Go</a>

        <div class="action-row">
            <a class="btn btn-outline btn-small" href="/explore">Kembali</a>
            <a class="btn btn-outline btn-small" href="/logout">Logout</a>
        </div>
    </header>

    <main class="container">
        <div class="grid-2">
            <div>
                <c:choose>
                    <c:when test="${not empty destination.imageUrl}">
                        <img class="detail-img" src="${destination.imageUrl}" alt="${destination.name}">
                    </c:when>

                    <c:otherwise>
                        <div class="detail-img"></div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="card">
                <span class="badge">${destination.category}</span>

                <h1 style="margin-top:12px;">${destination.name}</h1>

                <p class="subtitle">📍 ${destination.location}</p>

                <p>${destination.description}</p>

                <h2 class="price">
                    Rp <fmt:formatNumber value="${destination.price}" type="number" groupingUsed="true"/>
                </h2>

                <form method="post" action="/destination/${destination.id}/quick-plan" style="margin-top:16px;">
                    <button class="btn btn-outline full" type="submit">
                        Buat Booking Baru dari Destinasi Ini
                    </button>
                </form>

                <form method="post" action="/review/${destination.id}" style="margin-top:14px;">
                    <select class="select" name="rating" required>
                        <option value="5">⭐⭐⭐⭐⭐ - 5</option>
                        <option value="4">⭐⭐⭐⭐ - 4</option>
                        <option value="3">⭐⭐⭐ - 3</option>
                        <option value="2">⭐⭐ - 2</option>
                        <option value="1">⭐ - 1</option>
                    </select>

                    <textarea name="comment" placeholder="Tulis review..." required></textarea>

                    <button class="btn full" type="submit">Kirim Review</button>
                </form>
            </div>
        </div>

        <section style="margin-top:22px;">
            <h2>Review Pengunjung</h2>

            <div class="grid">
                <c:forEach var="review" items="${reviews}">
                    <div class="card">
                        <strong>${review.user.username}</strong>
                        <p style="margin:8px 0;">Rating: ${review.rating}/5</p>
                        <p class="subtitle">${review.comment}</p>
                    </div>
                </c:forEach>
            </div>
        </section>
    </main>

    <nav class="bottom-nav">
        <a class="nav-item active" href="/explore">🧭<br>Explore</a>
        <a class="nav-item" href="/plan">🗺️<br>Booking</a>
        <a class="nav-item" href="/profile">👤<br>Profile</a>
    </nav>
</div>
</body>
</html>