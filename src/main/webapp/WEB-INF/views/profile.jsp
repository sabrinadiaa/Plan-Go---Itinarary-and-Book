<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Profile - Plan & Go</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body class="profile-body">

<header class="profile-full-header">
    <a class="profile-logo" href="/explore">Plan & Go</a>
    <a class="profile-logout" href="/logout">Logout</a>
</header>

<main class="profile-page">

    <section class="profile-hero-card">
        <div class="profile-avatar">
            ${user.username.substring(0,1)}
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
        <div class="card-icon">📊</div>

        <div>
            <h2>Account Summary</h2>
            <p class="mini-subtitle">Ringkasan aktivitas perjalananmu</p>
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
            <span>✈️</span>
            <small>Total Trip</small>
            <strong>${fn:length(payments)}</strong>
        </div>

        <div class="summary-box">
            <span>🧾</span>
            <small>Total Payment</small>
            <strong>${fn:length(payments)}</strong>
        </div>

        <div class="summary-box">
            <span>⭐</span>
            <small>Destinasi Dirating</small>
            <strong>${ratedCount}</strong>
        </div>

        <div class="summary-box">
            <span>📍</span>
            <small>Destinasi Terakhir</small>
            <strong>
                <c:choose>
                    <c:when test="${not empty latestPayment and not empty latestPayment.booking.snapshotTitle}">
                        ${latestPayment.booking.snapshotTitle}
                    </c:when>
                    <c:when test="${not empty latestPayment and not empty latestPayment.booking.snapshotDestinations}">
                        ${latestPayment.booking.snapshotDestinations}
                    </c:when>
                    <c:otherwise>
                        Belum ada
                    </c:otherwise>
                </c:choose>
            </strong>
        </div>

    </div>

</div>

        <div class="profile-info-card emergency-card-new">
            <div class="card-title-row">
                <div class="card-icon emergency">🚨</div>
                <div>
                    <h2>Kontak Darurat</h2>
                    <p class="mini-subtitle">Nomor penting saat perjalanan</p>
                </div>
            </div>

            <div class="emergency-number-grid">
                <a href="tel:112" class="emergency-number-card">
                    <div class="emergency-emoji">🆘</div>
                    <div>
                        <strong>112</strong>
                        <span>Darurat Umum</span>
                    </div>
                </a>

                <a href="tel:110" class="emergency-number-card">
                    <div class="emergency-emoji">👮</div>
                    <div>
                        <strong>110</strong>
                        <span>Polisi</span>
                    </div>
                </a>

                <a href="tel:119" class="emergency-number-card">
                    <div class="emergency-emoji">🚑</div>
                    <div>
                        <strong>119</strong>
                        <span>Ambulans</span>
                    </div>
                </a>

                <a href="tel:113" class="emergency-number-card">
                    <div class="emergency-emoji">🚒</div>
                    <div>
                        <strong>113</strong>
                        <span>Pemadam</span>
                    </div>
                </a>

                <a href="tel:115" class="emergency-number-card wide">
                    <div class="emergency-emoji">🚁</div>
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
                <h2>Payment History</h2>
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
                                    📍
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
        <span>🏝️</span>
        <small>Explore</small>
    </a>

    <a href="/plan">
        <span>🗺️</span>
        <small>Booking</small>
    </a>

    <a href="/profile" class="active">
        <span>👤</span>
        <small>Profile</small>
    </a>
</nav>

</body>
</html>