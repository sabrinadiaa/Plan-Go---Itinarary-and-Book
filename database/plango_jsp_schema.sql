DROP DATABASE IF EXISTS plango;
CREATE DATABASE plango CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE plango;

CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    saldo DOUBLE DEFAULT 0,
    role VARCHAR(20) NOT NULL DEFAULT 'CUSTOMER'
);

CREATE TABLE destination (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    location VARCHAR(150),
    category VARCHAR(80),
    description TEXT,
    price DOUBLE DEFAULT 0,
    image_url VARCHAR(500),
    latitude DOUBLE,
    longitude DOUBLE
);

CREATE TABLE itinerary (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    title VARCHAR(150) NOT NULL,
    total_people INT DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_itinerary_user FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE itinerary_item (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    itinerary_id BIGINT NOT NULL,
    destination_id BIGINT NOT NULL,
    visit_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_item_itinerary FOREIGN KEY (itinerary_id) REFERENCES itinerary(id) ON DELETE CASCADE,
    CONSTRAINT fk_item_destination FOREIGN KEY (destination_id) REFERENCES destination(id)
);

CREATE TABLE booking (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    itinerary_id BIGINT NOT NULL,
    status VARCHAR(30) DEFAULT 'PENDING',
    total_price DOUBLE DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    booking_code VARCHAR(80),
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    snapshot_title VARCHAR(150),
    snapshot_destinations TEXT,
    snapshot_image_url VARCHAR(500),
    snapshot_location VARCHAR(150),
    trip_start DATETIME NULL,
    trip_end DATETIME NULL,
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_booking_itinerary FOREIGN KEY (itinerary_id) REFERENCES itinerary(id)
);

CREATE TABLE payment (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    booking_id BIGINT NOT NULL,
    method VARCHAR(80),
    status VARCHAR(30),
    amount DOUBLE DEFAULT 0,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES booking(id)
);

CREATE TABLE review (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    destination_id BIGINT NOT NULL,
    rating INT,
    comment TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_review_destination FOREIGN KEY (destination_id) REFERENCES destination(id)
);

INSERT INTO users (username, email, password, saldo, role) VALUES
('admin', 'admin@gmail.com', '123', 0, 'ADMIN'),
('customer', 'customer@gmail.com', '123', 500000, 'CUSTOMER');

INSERT INTO destination (name, location, category, description, price, image_url, latitude, longitude) VALUES
('Tanah Lot', 'Bali, Indonesia', 'Nature', 'Destinasi wisata dengan pemandangan laut dan pura yang ikonik.', 75000, 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?auto=format&fit=crop&w=900&q=80', -8.6212, 115.0868),
('Ubud Monkey Forest', 'Bali, Indonesia', 'Nature', 'Hutan wisata populer di Ubud dengan suasana alam yang sejuk.', 90000, 'https://images.unsplash.com/photo-1604999333679-b86d54738315?auto=format&fit=crop&w=900&q=80', -8.5193, 115.2606),
('Malioboro', 'Yogyakarta, Indonesia', 'City Tour', 'Area wisata belanja dan kuliner khas Yogyakarta.', 50000, 'https://images.unsplash.com/photo-1566552881560-0be862a7c445?auto=format&fit=crop&w=900&q=80', -7.7926, 110.3658),
('Bromo', 'Jawa Timur, Indonesia', 'Mountain', 'Gunung dengan sunrise terkenal dan pemandangan pasir berbisik.', 125000, 'https://images.unsplash.com/photo-1589308454676-22de49ed8f33?auto=format&fit=crop&w=900&q=80', -7.9425, 112.9530),
('Kota Lama', 'Semarang, Indonesia', 'Heritage', 'Kawasan heritage dengan bangunan tua bergaya kolonial.', 40000, 'https://images.unsplash.com/photo-1596402184320-417e7178b2cd?auto=format&fit=crop&w=900&q=80', -6.9683, 110.4288);
