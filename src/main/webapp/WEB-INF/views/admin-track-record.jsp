<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Track Record - Plan & Go</title>
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
                <p class="brand">CUSTOMER SAFETY TRACKING</p>
            </div>

        </section>

        <section class="grid" style="margin-bottom:24px;">
            <div class="card kpi">
                <div class="kpi-icon">🌍</div>
                <div>
                    <p class="subtitle">Emergency Reports</p>
                    <h2>${activeTravelers}</h2>
                </div>
            </div>

            <div class="card kpi">
                <div class="kpi-icon">🛡️</div>
                <div>
                    <p class="subtitle">Handled</p>
                    <h2>${safeCount}</h2>
                </div>
            </div>

            <div class="card kpi">
                <div class="kpi-icon">⚠️</div>
                <div>
                    <p class="subtitle">Urgent Attention</p>
                    <h2 style="color:#C53030;">${urgentCount}</h2>
                </div>
            </div>
        </section>

        <div class="table-wrap">
            <table>
                <thead>
                <tr>
                    <th>Customer</th>
                    <th>Email</th>
                    <th>Safety Status</th>
                    <th>Emergency Message</th>
                    <th>Last Updated</th>
                    <th>Aksi</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="report" items="${emergencyReports}">
                    <tr>
                        <td>${report.username}</td>
                        <td>${report.email}</td>

                        <td>
                            <c:choose>
                                <c:when test="${report.status == 'DONE'}">
                                    <span class="badge">Handled</span>
                                </c:when>

                                <c:otherwise>
                                    <span class="badge badge-red">Urgent</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>${report.message}</td>
                        <td>${report.createdAt}</td>

                        <td>
                            <c:if test="${report.status != 'DONE'}">
                                <form method="post" action="/admin/emergency/${report.id}/done">
                                    <button class="btn btn-small" type="submit">
                                        Tandai Selesai
                                    </button>
                                </form>
                            </c:if>

                            <c:if test="${report.status == 'DONE'}">
                                <span class="badge">Selesai</span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty emergencyReports}">
                    <tr>
                        <td colspan="6" style="text-align:center; color:#777;">
                            Belum ada laporan emergency dari customer.
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </main>

    <nav class="bottom-nav admin-nav">
    <a class="nav-item" href="/admin/dashboard">
        <i class="fa-solid fa-house"></i><br>Home
    </a>

    <a class="nav-item" href="/admin/booking">
        <i class="fa-solid fa-clipboard-list"></i><br>Booking
    </a>

    <a class="nav-item active" href="/admin/track-record">
        <i class="fa-solid fa-chart-line"></i><br>Track
    </a>
</nav>
</div>
</body>
</html>