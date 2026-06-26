<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>${itinerary.title} - Plan & Go</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body>
<div class="page">
    <header class="topbar">
        <a class="logo" href="/explore">Plan & Go</a>

        <div class="action-row">
            <a class="btn btn-outline btn-small" href="/logout">Logout</a>
        </div>
    </header>

    <main class="container">
        <section class="hero">
            <div>
                <p class="brand">BOOKING DETAIL</p>
                <h1>${itinerary.title}</h1>
                <p class="subtitle">Total orang: ${itinerary.totalPeople}</p>
            </div>

            <c:choose>
    <c:when test="${alreadyPaid}">
        <a class="btn btn-outline" href="/payment-success?bookingId=${existingBooking.id}">
            Sudah Dibooking
        </a>
    </c:when>

    <c:when test="${hasPendingBooking}">
        <a class="btn" href="/payment/${existingBooking.id}">
            Lanjut Pembayaran
        </a>
    </c:when>

    <c:otherwise>
        <form method="post" action="/plan/${itinerary.id}/booking">
            <button class="btn" type="submit">
                Lanjut Booking
            </button>
        </form>
    </c:otherwise>
</c:choose>
        </section>

        <div class="grid-2">
            <section class="card">
                <h2>Tambah Destinasi</h2>

                <p class="subtitle">
                    Cari destinasi dari halaman Explore All, lalu tambahkan ke itinerary ini.
                </p>

                <a class="btn full" href="/explore/all?itineraryId=${itinerary.id}">
                    Cari Destinasi
                </a>
            </section>

        </div>

        <section style="margin-top:24px;">
            <h2>Destinasi dalam Itinerary</h2>

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

                            <p class="price">
                                Rp <fmt:formatNumber value="${item.destination.price}" type="number" groupingUsed="true"/>
                            </p>

                            <p class="subtitle">
                                Jadwal sekarang: ${item.visitTime}
                            </p>

                            <form method="post" action="/plan/item/${item.id}/update-time" class="schedule-form">
                                <input type="hidden" name="itineraryId" value="${itinerary.id}">

                                <label>Tanggal Kunjungan</label>
                                <input
                                    class="input"
                                    type="date"
                                    name="visitDate"
                                    value="${fn:substring(item.visitTime, 0, 10)}"
                                    required
                                >

                                <label>Jam Kunjungan</label>
                                <input
                                    class="input"
                                    type="time"
                                    name="visitTime"
                                    value="${fn:substring(item.visitTime, 11, 16)}"
                                    required
                                >

                                <button class="btn full" type="submit">
                                    Simpan Jadwal
                                </button>
                            </form>

                            <c:choose>
                                <c:when test="${alreadyPaid or hasPendingBooking}">
                                </c:when>

                                <c:otherwise>
                                    <form method="post" action="/plan/item/${item.id}/delete" style="margin-top:10px;">
                                        <input type="hidden" name="itineraryId" value="${itinerary.id}">
                                        <button class="btn btn-danger btn-small" type="submit">Hapus</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </article>
                </c:forEach>
            </div>
        </section>
    </main>

    <nav class="bottom-nav">
        <a href="/explore">
        <span><i class="fa-solid fa-compass"></i></span>
        <small>Explore</small>
    </a>

    <a href="/plan" class="active">
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