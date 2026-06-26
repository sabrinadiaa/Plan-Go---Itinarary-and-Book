<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Secure Checkout - Plan & Go</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body class="checkout-body">

<header class="topbar">
    <a class="logo" href="/explore">Plan & Go</a>

    <div class="action-row">
        <a class="btn btn-outline btn-small" href="/logout">Logout</a>
    </div>
</header>

<div class="checkout-page">

<div class="checkout-page">
<div class="checkout-page">
    <section class="checkout-trip-card">
        <c:choose>
            <c:when test="${not empty booking.snapshotImageUrl}">
                <img class="checkout-trip-img" src="${booking.snapshotImageUrl}" alt="${booking.snapshotTitle}">
            </c:when>
            <c:otherwise>
                <div class="checkout-trip-img placeholder"></div>
            </c:otherwise>
        </c:choose>

        <div class="checkout-trip-title">
            <h2>
                <c:choose>
                    <c:when test="${not empty booking.snapshotTitle}">
                        ${booking.snapshotTitle}
                    </c:when>
                    <c:otherwise>
                        Plan & Go Trip
                    </c:otherwise>
                </c:choose>
            </h2>

            <p>
                <c:choose>
                    <c:when test="${not empty booking.snapshotLocation}">
                        ${booking.snapshotLocation}
                    </c:when>
                    <c:otherwise>
                        Indonesia
                    </c:otherwise>
                </c:choose>
            </p>
        </div>

        <div class="checkout-info-row">
            <div>
                <small>DATES</small>
                <strong>
                    <c:choose>
                        <c:when test="${not empty booking.tripStart and not empty booking.tripEnd}">
                            ${booking.tripStart} - ${booking.tripEnd}
                        </c:when>
                        <c:otherwise>
                            Menyesuaikan itinerary
                        </c:otherwise>
                    </c:choose>
                </strong>
            </div>

            <div>
                <small>GUESTS</small>
                <strong>
                    <c:choose>
                        <c:when test="${not empty booking.itinerary and not empty booking.itinerary.totalPeople}">
                            ${booking.itinerary.totalPeople} Adults
                        </c:when>
                        <c:otherwise>
                            1 Adult
                        </c:otherwise>
                    </c:choose>
                </strong>
            </div>
        </div>

        <div class="checkout-price-list">
            <div>
                <span>Trip package</span>
                <strong>
                    Rp <fmt:formatNumber value="${booking.totalPrice}" type="number" groupingUsed="true"/>
                </strong>
            </div>

            <div>
                <span>Service fee</span>
                <strong>Rp 0</strong>
            </div>

            <div>
                <span>Travel tax</span>
                <strong>Rp 0</strong>
            </div>
        </div>

        <div class="checkout-total-row">
            <h3>Total price</h3>
            <strong>
                Rp <fmt:formatNumber value="${booking.totalPrice}" type="number" groupingUsed="true"/>
            </strong>
        </div>
    </section>

    <section class="payment-method-section">
        <h2>Select Payment Method</h2>

        <form method="post" action="/payment/${booking.id}">

            <label class="payment-option selected-option">
                <input type="radio" name="method" value="E-Wallet" checked>

                <div class="payment-icon">▣</div>

                <div class="payment-text">
                    <h3>E-Wallet</h3>
                    <p>Balance: Rp 42,300.50</p>
                </div>

            </label>

            <label class="payment-option">
                <input type="radio" name="method" value="Bank Transfer">

                <div class="payment-icon bank">🏦</div>

                <div class="payment-text">
                    <h3>Bank Transfer</h3>
                    <p>Direct deposit</p>
                </div>
            </label>

            <button class="checkout-pay-button" type="submit">
                Pay Now
            </button>
        </form>
    </section>


</div>

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

</body>
</html>