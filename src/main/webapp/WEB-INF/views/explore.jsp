<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Explore - Plan & Go</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body class="app-body">

<fmt:setLocale value="id_ID"/>

<header class="app-header">
    <h2>Plan & Go</h2>

    <div class="action-row">
        <form method="post" action="/emergency" class="emergency-form">
            <button type="submit" class="emergency-button"
                    onclick="return confirm('Kirim laporan emergency ke admin?')">
                🚨
            </button>
        </form>

        <a class="btn btn-outline btn-small" href="/logout">Logout</a>
    </div>
</header>

<main class="page-content">

    <section class="welcome-section">
        <h1>Welcome back, ${username}</h1>
        <p>Ready for your next adventure?</p>
    </section>

    <c:if test="${param.emergencySent == 'true'}">
        <div class="emergency-alert-success">
            🚨 Laporan emergency berhasil dikirim ke admin.
        </div>
    </c:if>

    <section class="journey-grid">

        <!-- ACTIVE JOURNEY -->
        <div class="journey-card">
            <div class="journey-image-wrapper">
                <c:choose>
                    <c:when test="${not empty activeJourney and not empty activeJourney.snapshotImageUrl}">
                        <img src="${activeJourney.snapshotImageUrl}" alt="Active Journey">
                    </c:when>

                    <c:otherwise>
                        <img src="${defaultJourneyImage}" alt="Active Journey">
                    </c:otherwise>
                </c:choose>

                <span class="journey-badge active">ACTIVE JOURNEY</span>
            </div>

            <h2>
                <c:choose>
                    <c:when test="${not empty activeJourney and not empty activeJourney.snapshotTitle}">
                        ${activeJourney.snapshotTitle}
                    </c:when>

                    <c:otherwise>
                        Autumn in Kyoto
                    </c:otherwise>
                </c:choose>
            </h2>

            <p class="journey-date">${activeJourneyDate}</p>

            <p class="journey-desc">
                <c:choose>
                    <c:when test="${not empty activeJourney and not empty activeJourney.snapshotLocation}">
                        ${activeJourney.snapshotLocation}
                    </c:when>

                    <c:otherwise>
                        Exploring the hidden temples and beautiful culture of your next journey.
                    </c:otherwise>
                </c:choose>
            </p>

            <a href="/plan" class="journey-button">View Itinerary →</a>
        </div>

        <!-- HISTORY JOURNEY -->
        <div class="journey-card">
            <div class="journey-image-wrapper">
                <c:choose>
                    <c:when test="${not empty historyJourney and not empty historyJourney.snapshotImageUrl}">
                        <img src="${historyJourney.snapshotImageUrl}" alt="History Journey">
                    </c:when>

                    <c:otherwise>
                        <img src="${defaultJourneyImage}" alt="History Journey">
                    </c:otherwise>
                </c:choose>

                <span class="journey-badge history">HISTORY JOURNEY</span>
            </div>

            <h2>
                <c:choose>
                    <c:when test="${not empty historyJourney and not empty historyJourney.snapshotTitle}">
                        ${historyJourney.snapshotTitle}
                    </c:when>

                    <c:otherwise>
                        Autumn in Kyoto
                    </c:otherwise>
                </c:choose>
            </h2>

            <p class="journey-date">${historyJourneyDate}</p>

            <p class="journey-desc">
                <c:choose>
                    <c:when test="${not empty historyJourney and not empty historyJourney.snapshotLocation}">
                        ${historyJourney.snapshotLocation}
                    </c:when>

                    <c:otherwise>
                        Exploring the hidden temples and beautiful culture of your previous journey.
                    </c:otherwise>
                </c:choose>
            </p>

            <a href="/booking" class="journey-button">View Itinerary →</a>
        </div>

    </section>

    <section class="section-header">
        <h2>Recommended for You</h2>
        <a href="/explore/all">Explore all</a>
    </section>

    <section class="destination-grid">
        <c:forEach var="destination" items="${recommendedDestinations}">

            <a href="/destination/${destination.id}" class="destination-card">

                <div class="destination-image-wrapper">
                    <img src="${destination.imageUrl}" alt="${destination.name}">
                    <span class="rating-badge">⭐ 4.7</span>
                </div>

                <div class="destination-info">
                    <div class="destination-row">
                        <h3>${destination.name}</h3>

                        <strong>
                            Rp <fmt:formatNumber value="${destination.price}" type="number" maxFractionDigits="0"/>
                        </strong>
                    </div>

                    <p>📍 ${destination.location}</p>
                </div>

            </a>

        </c:forEach>
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

</body>
</html>