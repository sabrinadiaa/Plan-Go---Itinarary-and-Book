<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Review - Plan & Go</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="page">
    <header class="topbar">
        <a class="logo" href="/explore">Plan & Go</a>
        <a class="btn btn-outline btn-small" href="/destination/${destination.id}">Kembali</a>
    </header>

    <main class="container">
        <div class="card" style="max-width:540px;margin:0 auto;">
            <p class="brand">REVIEW</p>
            <h1>${destination.name}</h1>
            <form method="post" action="/review/${destination.id}">
                <select class="select" name="rating" required>
                    <option value="5">5 - Sangat Bagus</option>
                    <option value="4">4 - Bagus</option>
                    <option value="3">3 - Cukup</option>
                    <option value="2">2 - Kurang</option>
                    <option value="1">1 - Buruk</option>
                </select>
                <textarea name="comment" placeholder="Komentar" required></textarea>
                <button class="btn full" type="submit">Kirim Review</button>
            </form>
        </div>
    </main>
</div>
</body>
</html>
