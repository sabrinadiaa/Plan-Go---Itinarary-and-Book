<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Successful - Plan & Go</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body class="payment-success-body">
   
<header class="topbar">
    <a class="logo" href="/explore">Plan & Go</a>

    <div class="action-row">
        <a class="btn btn-outline btn-small" href="/logout">Logout</a>
    </div>
</header>

<div class="checkout-page">
<div class="payment-success-page">

    <div class="success-icon">
        ✓
    </div>

    <h1 class="success-title">
        Payment<br>
        Successful
    </h1>

    <p class="success-subtitle">
        Your adventure is officially booked.<br>
        We've sent a confirmation email to
    </p>

    <p class="success-email">
        <c:choose>
            <c:when test="${not empty email}">
                ${email}
            </c:when>
            <c:otherwise>
                user@plango.com
            </c:otherwise>
        </c:choose>
    </p>

    <div class="success-total-card">
        <p>Total Amount</p>

        <h2>
            Rp
            <c:choose>
                <c:when test="${not empty booking}">
                    <fmt:formatNumber value="${booking.totalPrice}" type="number" groupingUsed="true"/>
                </c:when>
                <c:otherwise>
                    0
                </c:otherwise>
            </c:choose>
        </h2>
    </div>

    <div class="success-info-grid">

        <div class="success-info-card">
            <small>Method</small>

            <strong>
                <c:choose>
                    <c:when test="${not empty paymentMethod}">
                        ${paymentMethod}
                    </c:when>
                    <c:otherwise>
                        E-Wallet
                    </c:otherwise>
                </c:choose>
            </strong>
        </div>
    </div>

    <div class="success-destination-card">
        <c:choose>
            <c:when test="${not empty booking and not empty booking.snapshotImageUrl}">
                <img src="${booking.snapshotImageUrl}" alt="Trip Destination">
            </c:when>
            <c:otherwise>
                <div class="success-destination-placeholder"></div>
            </c:otherwise>
        </c:choose>

        <div>
            <small>Trip Destination</small>

            <strong>
                <c:choose>
                    <c:when test="${not empty booking and not empty booking.snapshotTitle}">
                        ${booking.snapshotTitle}
                    </c:when>
                    <c:when test="${not empty booking and not empty booking.snapshotDestinations}">
                        ${booking.snapshotDestinations}
                    </c:when>
                    <c:otherwise>
                        Plan & Go Trip
                    </c:otherwise>
                </c:choose>
            </strong>
        </div>
    </div>

    <a href="/plan" class="success-main-button">
        View Itinerary
    </a>

</div>

</body>
</html>