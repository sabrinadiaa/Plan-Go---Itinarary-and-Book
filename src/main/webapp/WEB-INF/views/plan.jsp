<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking - Plan & Go</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="page">
    <header class="topbar">
        <a class="logo" href="/explore">Plan & Go</a>
        <a class="btn btn-outline btn-small" href="/logout">Logout</a>
    </header>

    <main class="container">
        <section class="hero">
            <div>
                <p class="brand">Buat itinarary perjalanan, tambah destinasi pilihanmu!!!</p>
            </div>
        </section>

        <div class="grid-2">
            <section class="card">
                <h2>Buat Itinerary Baru</h2>
                <form method="post" action="/plan/create">
                    <input class="input" type="text" name="title" placeholder="Contoh: Liburan Bali" required>
                    <input class="input" type="number" name="totalPeople" placeholder="Jumlah orang" value="1" min="1" required>
                    <button class="btn full" type="submit">Buat Plan</button>
                </form>
            </section>
        </div>

        <section style="margin-top:24px;">
            <h2>Daftar Itinerary</h2>
            <div class="grid">
                <c:forEach var="itinerary" items="${itineraries}">
                    <article class="card">
                        <span class="badge">${itinerary.totalPeople} orang</span>
                        <h3 style="margin-top:12px;">${itinerary.title}</h3>
                        <p class="subtitle">Dibuat: ${itinerary.createdAt}</p>
                        <p class="subtitle">Jumlah destinasi: ${fn:length(itinerary.items)}</p>
                        <a class="btn full" href="/plan/${itinerary.id}">Buka Detail</a>
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