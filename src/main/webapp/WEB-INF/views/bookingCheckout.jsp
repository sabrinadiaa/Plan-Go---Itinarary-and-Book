<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Konfirmasi Booking - Plan & Go</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body>
<div class="page">
    <header class="topbar">
        <a class="logo" href="/explore">Plan & Go</a>

        <div class="action-row">
            <a class="btn btn-outline btn-small" href="/plan/${itinerary.id}">Kembali</a>
            <a class="btn btn-outline btn-small" href="/logout">Logout</a>
        </div>
    </header>

    <main class="container">
        <section class="hero">
            <div>
                <p class="brand">KONFIRMASI BOOKING</p>
                <h1>${itinerary.title}</h1>
                <p class="subtitle">Periksa detail perjalanan sebelum lanjut ke pembayaran.</p>
            </div>
        </section>

        <div class="grid-2">
            <section class="card">
                <h2>Detail Booking</h2>

                <p><strong>Judul:</strong> ${itinerary.title}</p>
                <p><strong>Jumlah orang:</strong> ${totalPeople}</p>

                <p>
                    <strong>Subtotal:</strong>
                    Rp <fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true"/>
                </p>

                <h2 class="price">
                    Total:
                    Rp <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true"/>
                </h2>

                <form method="post" action="/plan/${itinerary.id}/booking">
                    <button class="btn full" type="submit">
                        Konfirmasi Booking & Lanjut Bayar
                    </button>
                </form>
            </section>

            <section class="card">
                <h2>Catatan</h2>
                <p class="subtitle">
                    Setelah booking dikonfirmasi, data perjalanan akan disimpan sebagai snapshot agar history booking tidak berubah.
                </p>
            </section>
        </div>

        <section style="margin-top:24px;">
            <h2>Destinasi yang Dibooking</h2>

            <div class="grid">
                <c:forEach var="item" items="${itinerary.items}">
                    <article class="card dest-card">
                        <c:if test="${not empty item.destination.imageUrl}">
                            <img class="dest-img" src="${item.destination.imageUrl}" alt="${item.destination.name}">
                        </c:if>

                        <div class="dest-content">
                            <span class="badge">${item.destination.category}</span>

                            <h3 style="margin-top:12px;">${item.destination.name}</h3>

                            <p class="subtitle"> ${item.destination.location}</p>

                            <p class="subtitle">
                                 Jadwal: ${item.visitTime}
                            </p>

                            <p class="price">
                                Rp <fmt:formatNumber value="${item.destination.price}" type="number" groupingUsed="true"/>
                            </p>
                        </div>
                    </article>
                </c:forEach>
            </div>
        </section>
    </main>

    <nav class="bottom-nav">
    <a href="/explore" class="active">
        <span><i class="fa-solid fa-compass"></i></span>
        <small>Explore</small>
    </a>

    <a href="/plan">
        <span><i class="fa-solid fa-calendar-check"></i></span>
        <small>Booking</small>
    </a>

    <a href="/profile">
        <span><i class="fa-solid fa-user"></i></span>
        <small>Profile</small>
    </a>
</nav>
</div>
</body>
</html>