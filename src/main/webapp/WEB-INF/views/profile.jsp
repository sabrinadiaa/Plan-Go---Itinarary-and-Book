<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Profile - Plan & Go</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body class="profile-body">

<header class="profile-full-header">
    <a class="profile-logo" href="/explore">Plan & Go</a>
    <a class="profile-logout" href="/logout">Logout</a>
</header>

<main class="profile-page">

    <section class="profile-hero-card">
        <div class="profile-avatar">
            ${fn:substring(user.username, 0, 1)}
        </div>

        <div>
            <p class="profile-label">ACCOUNT INFORMATION</p>
            <h1>${user.username}</h1>
            <p>${user.email}</p>
        </div>
    </section>

    <section class="profile-info-grid">

        <c:set var="latestPayment" value="${null}" />

        <c:forEach var="payment" items="${payments}" varStatus="loop">
            <c:if test="${loop.first}">
                <c:set var="latestPayment" value="${payment}" />
            </c:if>
        </c:forEach>

        <div class="profile-info-card account-summary-wrapper">
    <div class="card-title-row">
        <div>
            <h2>Account Summary</h2>
        </div>
    </div>

    <c:set var="latestPayment" value="${null}" />

    <c:forEach var="payment" items="${payments}" varStatus="loop">
        <c:if test="${loop.first}">
            <c:set var="latestPayment" value="${payment}" />
        </c:if>
    </c:forEach>

    <div class="account-summary-grid">

        <div class="summary-box">
            <img class="summary-box-img" src="/assets/totalTrip.png" alt="Total Trip">
            <div>
                <small>Total Trip</small>
                <strong>${fn:length(payments)}</strong>
            </div>
        </div>

        <div class="summary-box">
            <img class="summary-box-img" src="/assets/pay.png" alt="Total Payment">
            <div>
                <small>Total Payment</small>
                <strong>${fn:length(payments)}</strong>
            </div>
        </div>

        <div class="summary-box">
            <img class="summary-box-img" src="/assets/review.png" alt="Rated Destinations">
            <div>
                <small>Rated Destinations</small>
                <strong>${ratedCount}</strong>
            </div>
        </div>

        <div class="summary-box">
            <img class="summary-box-img" src="/assets/lastDestination.png" alt="Last destination visited">
            <div>
                <small>Last Destination Visited</small>
                <strong>
                    <c:choose>
                        <c:when test="${not empty latestPayment and not empty latestPayment.booking.snapshotTitle}">
                            ${latestPayment.booking.snapshotTitle}
                        </c:when>
                        <c:when test="${not empty latestPayment and not empty latestPayment.booking.snapshotDestinations}">
                            ${latestPayment.booking.snapshotDestinations}
                        </c:when>
                        <c:otherwise>
                            No history yet
                        </c:otherwise>
                    </c:choose>
                </strong>
            </div>
        </div>

    </div>
</div>

        <div class="profile-info-card emergency-card-new">
            <div class="card-title-row">
                <i class="fa-solid fa-triangle-exclamation"></i>
                <div>
                    <h2>Emergency Contact</h2>
                </div>
            </div>

            <div class="emergency-number-grid">

                <a href="tel:112" class="emergency-number-card">
                    <img class="emergency-card-img" src="/assets/sos.png" alt="General Emergency">
                    <div>
                        <strong>112</strong>
                        <span>General Emergency</span>
                    </div>
                </a>

                <a href="tel:110" class="emergency-number-card">
                    <img class="emergency-card-img" src="/assets/polisi.png" alt="Police">
                    <div>
                        <strong>110</strong>
                        <span>Police</span>
                    </div>
                </a>

                <a href="tel:119" class="emergency-number-card">
                    <img class="emergency-card-img" src="/assets/ambulance.png" alt="Ambulance">
                    <div>
                        <strong>119</strong>
                        <span>Ambulance</span>
                    </div>
                </a>

                <a href="tel:113" class="emergency-number-card">
                    <img class="emergency-card-img" src="/assets/damkar.png" alt="Firefighter">
                    <div>
                        <strong>113</strong>
                        <span>Firefighter</span>
                    </div>
                </a>

                <a href="tel:115" class="emergency-number-card">
                    <img class="emergency-card-img" src="/assets/sar.png" alt="SAR Basarnas">
                    <div>
                        <strong>115</strong>
                        <span>SAR / Basarnas</span>
                    </div>
                </a>

            </div>
        </div>

    </section>

    <section class="profile-payment-section">
        <div class="payment-history-header">
            <div>
                <p class="profile-label">TRIP HISTORY</p>
            </div>
        </div>

        <div class="payment-history-grid">
            <c:forEach var="payment" items="${payments}">
                <article class="payment-history-card">

                    <c:choose>
                        <c:when test="${not empty payment.booking.snapshotImageUrl}">
                            <img class="payment-trip-img"
                                 src="${payment.booking.snapshotImageUrl}"
                                 alt="${payment.booking.snapshotTitle}">
                        </c:when>

                        <c:otherwise>
                            <div class="payment-trip-img payment-placeholder"></div>
                        </c:otherwise>
                    </c:choose>

                    <div class="payment-trip-content">
                        <div class="payment-trip-top">
                            <div>
                                <h3>
                                    <c:choose>
                                        <c:when test="${not empty payment.booking.snapshotTitle}">
                                            ${payment.booking.snapshotTitle}
                                        </c:when>
                                        <c:when test="${not empty payment.booking.snapshotDestinations}">
                                            ${payment.booking.snapshotDestinations}
                                        </c:when>
                                        <c:otherwise>
                                            Plan & Go Trip
                                        </c:otherwise>
                                    </c:choose>
                                </h3>

                                <p>
                                    <c:choose>
                                        <c:when test="${not empty payment.booking.snapshotLocation}">
                                            ${payment.booking.snapshotLocation}
                                        </c:when>
                                        <c:otherwise>
                                            Indonesia
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>

                            <span class="payment-status">
                                ${payment.status}
                            </span>
                        </div>

                        <div class="payment-trip-bottom">
                            <div>
                                <small>Method</small>
                                <strong>${payment.method}</strong>
                            </div>

                            <div>
                                <small>Amount</small>
                                <strong>
                                    Rp <fmt:formatNumber value="${payment.amount}" type="number" groupingUsed="true"/>
                                </strong>
                            </div>

                            <div>
                                <small>Date</small>
                                <strong>${payment.paymentDate}</strong>
                            </div>
                        </div>
                    </div>

                </article>
            </c:forEach>
        </div>

        <c:if test="${empty payments}">
            <div class="profile-empty-state">
                <h3>There is no history yet</h3>
                <p>History will appear after you make a booking.</p>
            </div>
        </c:if>
    </section>

</main>

<nav class="bottom-nav">
    <a href="/explore">
        <small>Explore</small>
    </a>

    <a href="/plan">
        <small>Booking</small>
    </a>

    <a href="/profile" class="active">
        <small>Profile</small>
    </a>
</nav>

</body>
</html>