<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Explore All - Plan & Go</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body class="explore-all-body">

<header class="explore-fixed-header">
    <a class="explore-fixed-logo" href="/explore">Plan & Go</a>

    <div class="explore-fixed-actions">
        <c:choose>
            <c:when test="${not empty itineraryId}">
            </c:when>
            
        </c:choose>

        <a href="/logout">Logout</a>
    </div>
</header>

<main class="explore-all-container">

<body class="mobile-body">

<div class="mobile-page">

    <div class="category-scroll explore-category-top">

        <c:url var="allUrl" value="/explore/all">
            <c:param name="category" value="ALL"/>
            <c:if test="${not empty itineraryId}">
                <c:param name="itineraryId" value="${itineraryId}"/>
            </c:if>
        </c:url>

        <c:url var="natureUrl" value="/explore/all">
            <c:param name="category" value="NATURE"/>
            <c:if test="${not empty itineraryId}">
                <c:param name="itineraryId" value="${itineraryId}"/>
            </c:if>
        </c:url>

        <c:url var="shoppingUrl" value="/explore/all">
            <c:param name="category" value="SHOPPING"/>
            <c:if test="${not empty itineraryId}">
                <c:param name="itineraryId" value="${itineraryId}"/>
            </c:if>
        </c:url>

        <c:url var="cafeUrl" value="/explore/all">
            <c:param name="category" value="CAFE"/>
            <c:if test="${not empty itineraryId}">
                <c:param name="itineraryId" value="${itineraryId}"/>
            </c:if>
        </c:url>

        <c:url var="hotelUrl" value="/explore/all">
            <c:param name="category" value="HOTEL"/>
            <c:if test="${not empty itineraryId}">
                <c:param name="itineraryId" value="${itineraryId}"/>
            </c:if>
        </c:url>

        <c:url var="clubUrl" value="/explore/all">
            <c:param name="category" value="CLUB"/>
            <c:if test="${not empty itineraryId}">
                <c:param name="itineraryId" value="${itineraryId}"/>
            </c:if>
        </c:url>

        <a class="${category == 'ALL' ? 'active' : ''}" href="${allUrl}">
             All
        </a>

        <a class="${category == 'NATURE' ? 'active' : ''}" href="${natureUrl}">
             Nature
        </a>

        <a class="${category == 'SHOPPING' ? 'active' : ''}" href="${shoppingUrl}">
             Shopping
        </a>

        <a class="${category == 'CAFE' ? 'active' : ''}" href="${cafeUrl}">
             Cafe
        </a>

        <a class="${category == 'HOTEL' ? 'active' : ''}" href="${hotelUrl}">
             Hotel
        </a>

        <a class="${category == 'CLUB' ? 'active' : ''}" href="${clubUrl}">
             Club
        </a>
    </div>

    <section class="explore-all-grid">
        <c:forEach var="destination" items="${destinations}">

            <c:choose>
                <c:when test="${not empty itineraryId}">
                    <div class="explore-all-card">
                        <c:choose>
                            <c:when test="${not empty destination.imageUrl}">
                                <img src="${destination.imageUrl}" alt="${destination.name}">
                            </c:when>

                            <c:otherwise>
                                <div class="explore-all-placeholder"></div>
                            </c:otherwise>
                        </c:choose>

                        <div class="explore-all-info">
                            <div class="explore-all-row">
                                <h3>${destination.name}</h3>

                                <strong>
                                    Rp <fmt:formatNumber value="${destination.price}" type="number" groupingUsed="true"/>
                                </strong>
                            </div>

                            <p> ${destination.location}</p>

                            <form method="post" action="/plan/${itineraryId}/add-destination" class="add-itinerary-form">
                                <input type="hidden" name="destinationId" value="${destination.id}">

                                <button type="submit" class="add-itinerary-btn">
                                    + Add to Itinerary
                                </button>
                            </form>
                        </div>
                    </div>
                </c:when>

                <c:otherwise>
                    <a href="/destination/${destination.id}" class="explore-all-card">
                        <c:choose>
                            <c:when test="${not empty destination.imageUrl}">
                                <img src="${destination.imageUrl}" alt="${destination.name}">
                            </c:when>

                            <c:otherwise>
                                <div class="explore-all-placeholder"></div>
                            </c:otherwise>
                        </c:choose>

                        <div class="explore-all-info">
                            <div class="explore-all-row">
                                <h3>${destination.name}</h3>

                                <strong>
                                    Rp <fmt:formatNumber value="${destination.price}" type="number" groupingUsed="true"/>
                                </strong>
                            </div>

                            <p>${destination.location}</p>
                        </div>
                    </a>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </section>

    <c:if test="${empty destinations}">
        <div class="empty-state">
            <h3>Belum ada destinasi</h3>
            <p>Coba pilih kategori lain.</p>
        </div>
    </c:if>

</div>

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