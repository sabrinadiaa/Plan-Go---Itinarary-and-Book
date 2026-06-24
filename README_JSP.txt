PLAN & GO - VERSI JSP
=====================

Isi folder ini adalah versi Plan & Go yang frontend-nya diganti dari React menjadi JSP.
Jadi yang dijalankan cukup satu project Spring Boot saja.

TEKNOLOGI:
- Backend: Java Spring Boot
- View/Frontend: JSP
- Database: MySQL
- Build tool: Maven
- Database access: Spring JDBC / JdbcTemplate
- Session: HttpSession dengan timeout 30 menit

CARA MENJALANKAN:
1. Buka XAMPP, nyalakan MySQL.
2. Buka phpMyAdmin.
3. Import file:
   database/plango_jsp_schema.sql
4. Buka folder PlanNGo_JSP di IntelliJ atau VS Code.
5. Jalankan:
   mvn spring-boot:run
6. Buka browser:
   http://localhost:8080/login

AKUN CONTOH:
Admin:
email    : admin@gmail.com
password : 123

Customer:
email    : customer@gmail.com
password : 123

ALUR MVC:
Model      : entity + repository
View       : JSP di src/main/webapp/WEB-INF/views
Controller : controller Spring Boot
Service    : service untuk business logic
Database   : MySQL

CATATAN:
- Folder frontend-app React sudah tidak dipakai di versi ini.
- JSP berada langsung di project backend.
- Session timeout ada di application.properties:
  server.servlet.session.timeout=30m
