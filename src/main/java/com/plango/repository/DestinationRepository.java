package com.plango.repository;

import com.plango.entity.Destination;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class DestinationRepository {

    private final JdbcTemplate jdbcTemplate;

    public DestinationRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<Destination> mapper = (rs, rowNum) -> {
        Destination destination = new Destination();
        destination.setId(rs.getLong("id"));
        destination.setName(rs.getString("name"));
        destination.setLocation(rs.getString("location"));
        destination.setCategory(rs.getString("category"));
        destination.setDescription(rs.getString("description"));
        destination.setPrice(rs.getDouble("price"));
        destination.setImageUrl(rs.getString("image_url"));
        destination.setLatitude(rs.getDouble("latitude"));
        destination.setLongitude(rs.getDouble("longitude"));
        return destination;
    };

    public List<Destination> findAll() {
        return jdbcTemplate.query("SELECT * FROM destination", mapper);
    }

    public Optional<Destination> findById(Long id) {
        try {
            Destination destination = jdbcTemplate.queryForObject(
                    "SELECT * FROM destination WHERE id = ?",
                    mapper,
                    id
            );
            return Optional.ofNullable(destination);
        } catch (EmptyResultDataAccessException e) {
            return Optional.empty();
        }
    }

    public void createFromAdmin(Destination destination) {
        String sql = """
                INSERT INTO destination
                (name, location, category, description, price, image_url, latitude, longitude)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                """;

        jdbcTemplate.update(
                sql,
                destination.getName(),
                destination.getLocation(),
                destination.getCategory(),
                destination.getDescription(),
                destination.getPrice(),
                destination.getImageUrl(),
                destination.getLatitude(),
                destination.getLongitude()
        );
    }

    public void updateFromAdmin(Destination destination) {
        String sql = """
                UPDATE destination
                SET name = ?,
                    location = ?,
                    category = ?,
                    description = ?,
                    price = ?,
                    image_url = ?,
                    latitude = ?,
                    longitude = ?
                WHERE id = ?
                """;

        jdbcTemplate.update(
                sql,
                destination.getName(),
                destination.getLocation(),
                destination.getCategory(),
                destination.getDescription(),
                destination.getPrice(),
                destination.getImageUrl(),
                destination.getLatitude(),
                destination.getLongitude(),
                destination.getId()
        );
    }

    public void deleteFromAdmin(Long id) {
        jdbcTemplate.update("DELETE FROM review WHERE destination_id = ?", id);
        jdbcTemplate.update("DELETE FROM itinerary_item WHERE destination_id = ?", id);
        jdbcTemplate.update("DELETE FROM destination WHERE id = ?", id);
    }
}