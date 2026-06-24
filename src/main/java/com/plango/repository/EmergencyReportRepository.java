package com.plango.repository;

import com.plango.entity.EmergencyReport;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;

@Repository
public class EmergencyReportRepository {

    private final JdbcTemplate jdbcTemplate;

    public EmergencyReportRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public void save(Long userId, String username, String email, String message) {
        String sql = """
                INSERT INTO emergency_report (user_id, username, email, message, status, created_at)
                VALUES (?, ?, ?, ?, 'PENDING', NOW())
                """;

        jdbcTemplate.update(sql, userId, username, email, message);
    }

    public List<EmergencyReport> findAll() {
        String sql = """
                SELECT id, user_id, username, email, message, status, created_at
                FROM emergency_report
                ORDER BY created_at DESC
                """;

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            EmergencyReport report = new EmergencyReport();

            report.setId(rs.getLong("id"));
            report.setUserId(rs.getLong("user_id"));
            report.setUsername(rs.getString("username"));
            report.setEmail(rs.getString("email"));
            report.setMessage(rs.getString("message"));
            report.setStatus(rs.getString("status"));

            Timestamp createdAt = rs.getTimestamp("created_at");
            if (createdAt != null) {
                report.setCreatedAt(createdAt.toLocalDateTime());
            }

            return report;
        });
    }

    public void updateStatus(Long id, String status) {
        String sql = """
                UPDATE emergency_report
                SET status = ?
                WHERE id = ?
                """;

        jdbcTemplate.update(sql, status, id);
    }
}