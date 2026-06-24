<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                <h1>Track Record</h1>
                <p class="subtitle">Versi JSP. Data contoh untuk monitoring keselamatan customer.</p>
            </div>
            <button class="btn btn-danger">🚨 Global Alert</button>
        </section>

        <section class="grid" style="margin-bottom:24px;">
            <div class="card kpi"><div class="kpi-icon">🌍</div><div><p class="subtitle">Active Travelers</p><h2>5</h2></div></div>
            <div class="card kpi"><div class="kpi-icon">🛡️</div><div><p class="subtitle">Status Safe</p><h2>3</h2></div></div>
            <div class="card kpi"><div class="kpi-icon">⚠️</div><div><p class="subtitle">Urgent Attention</p><h2 style="color:#C53030;">2</h2></div></div>
        </section>

        <div class="table-wrap">
            <table>
                <thead>
                <tr>
                    <th>Customer</th>
                    <th>Destination</th>
                    <th>Safety Status</th>
                    <th>Emergency History</th>
                    <th>Last Updated</th>
                </tr>
                </thead>
                <tbody>
                <tr><td>Jane Doe</td><td>Kyoto, Japan</td><td><span class="badge">Safe</span></td><td>No History</td><td>2 mins ago</td></tr>
                <tr><td>Mark Stevenson</td><td>Reykjavik, Iceland</td><td><span class="badge badge-red">Unsafe</span></td><td>2 Incidents</td><td>Just now</td></tr>
                <tr><td>Linda Wu</td><td>Zurich, Switzerland</td><td><span class="badge">Safe</span></td><td>No History</td><td>15 mins ago</td></tr>
                <tr><td>Robert Chen</td><td>Nairobi, Kenya</td><td><span class="badge badge-red">Unsafe</span></td><td>No History</td><td>8 mins ago</td></tr>
                <tr><td>Elena Garcia</td><td>Berlin, Germany</td><td><span class="badge">Safe</span></td><td>No History</td><td>1 hour ago</td></tr>
                </tbody>
            </table>
        </div>
    </main>

    <nav class="bottom-nav admin-nav">
        <a class="nav-item" href="/admin/dashboard">🏠<br>Home</a>
        <a class="nav-item" href="/admin/booking">📋<br>Booking</a>
        <a class="nav-item active" href="/admin/track-record">📊<br>Track</a>
    </nav>
</div>
</body>
</html>
