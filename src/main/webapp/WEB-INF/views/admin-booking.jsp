<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Booking - Plan & Go</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="page">
    <header class="topbar">
        <a class="logo" href="/admin/dashboard">Plan & Go Admin</a>
        <a class="btn btn-outline btn-small" href="/logout">Logout</a>
    </header>

    <main class="container">
        <section class="hero">
            <div>
                <p class="brand">BOOKING MANAGEMENT</p>
                <h1>All Bookings</h1>
                <p class="subtitle">Admin bisa melihat booking customer dan mengubah status booking.</p>
            </div>
        </section>

        <div class="table-wrap">
            <table>
                <thead>
                <tr>
                    <th>Kode</th>
                    <th>Customer</th>
                    <th>Trip</th>
                    <th>Destinasi</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="booking" items="${bookings}">
                    <tr>
                        <td><strong>${booking.bookingCode}</strong></td>
                        <td>${booking.user.username}</td>
                        <td>${booking.snapshotTitle}</td>
                        <td>${booking.snapshotDestinations}</td>
                        <td>Rp ${booking.totalPrice}</td>
                        <td>
                            <c:choose>
                                <c:when test="${booking.status == 'CONFIRMED'}"><span class="badge">${booking.status}</span></c:when>
                                <c:otherwise><span class="badge badge-red">${booking.status}</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <form method="post" action="/admin/booking/${booking.id}/status" class="action-row">
                                <select class="select" name="status" style="margin:0;min-width:130px;">
                                    <option value="PENDING">PENDING</option>
                                    <option value="CONFIRMED">CONFIRMED</option>
                                    <option value="COMPLETED">COMPLETED</option>
                                    <option value="CANCELLED">CANCELLED</option>
                                </select>
                                <button class="btn btn-small" type="submit">Update</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>

    <nav class="bottom-nav admin-nav">
        <a class="nav-item" href="/admin/dashboard"><br>Home</a>
        <a class="nav-item active" href="/admin/booking"><br>Booking</a>
        <a class="nav-item" href="/admin/track-record"><br>Track</a>
    </nav>
</div>
</body>
</html>
