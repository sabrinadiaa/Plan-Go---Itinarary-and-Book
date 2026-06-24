package com.plango.service;

import com.plango.entity.Booking;
import com.plango.entity.Itinerary;
import com.plango.entity.ItineraryItem;
import com.plango.entity.User;
import com.plango.repository.BookingRepository;
import com.plango.repository.ItineraryRepository;
import com.plango.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class BookingService {

    private final BookingRepository bookingRepository;
    private final UserRepository userRepository;
    private final ItineraryRepository itineraryRepository;

    public BookingService(
            BookingRepository bookingRepository,
            UserRepository userRepository,
            ItineraryRepository itineraryRepository
    ) {
        this.bookingRepository = bookingRepository;
        this.userRepository = userRepository;
        this.itineraryRepository = itineraryRepository;
    }

    public List<Booking> findAll() {
        return bookingRepository.findAll();
    }

    public List<Booking> findByUserId(Long userId) {
        return bookingRepository.findByUserId(userId);
    }

    public Booking findById(Long id) {
        return bookingRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking tidak ditemukan"));
    }

    public Optional<Booking> findExistingBooking(Long userId, Long itineraryId) {
        return bookingRepository.findExistingBooking(userId, itineraryId);
    }

    public Booking createBooking(Long userId, Long itineraryId) {
        Booking existingBooking = bookingRepository
                .findExistingBooking(userId, itineraryId)
                .orElse(null);

        if (existingBooking != null) {
            return existingBooking;
        }

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User tidak ditemukan"));

        Itinerary itinerary = itineraryRepository.findById(itineraryId)
                .orElseThrow(() -> new RuntimeException("Itinerary tidak ditemukan"));

        Booking booking = new Booking();

        booking.setUser(user);
        booking.setItinerary(itinerary);
        booking.setStatus("PENDING");
        booking.setCreatedAt(LocalDateTime.now());
        booking.setBookingDate(LocalDateTime.now());
        booking.setBookingCode("PG-" + System.currentTimeMillis());

        double subtotal = 0.0;
        StringBuilder destinations = new StringBuilder();

        String imageUrl = null;
        String location = null;
        LocalDateTime tripStart = null;
        LocalDateTime tripEnd = null;

        if (itinerary.getItems() != null) {
            for (ItineraryItem item : itinerary.getItems()) {
                if (item.getDestination() != null) {
                    if (item.getDestination().getPrice() != null) {
                        subtotal += item.getDestination().getPrice();
                    }

                    if (destinations.length() > 0) {
                        destinations.append(", ");
                    }

                    destinations.append(item.getDestination().getName());

                    if (imageUrl == null) {
                        imageUrl = item.getDestination().getImageUrl();
                    }

                    if (location == null) {
                        location = item.getDestination().getLocation();
                    }
                }

                if (item.getVisitTime() != null) {
                    if (tripStart == null || item.getVisitTime().isBefore(tripStart)) {
                        tripStart = item.getVisitTime();
                    }

                    if (tripEnd == null || item.getVisitTime().isAfter(tripEnd)) {
                        tripEnd = item.getVisitTime();
                    }
                }
            }
        }

        Integer totalPeopleObject = itinerary.getTotalPeople();
        int totalPeople = totalPeopleObject == null ? 1 : totalPeopleObject;

        booking.setTotalPrice(subtotal * totalPeople);
        booking.setSnapshotTitle(itinerary.getTitle());
        booking.setSnapshotDestinations(destinations.toString());
        booking.setSnapshotImageUrl(imageUrl);
        booking.setSnapshotLocation(location);
        booking.setTripStart(tripStart);
        booking.setTripEnd(tripEnd);

        return bookingRepository.save(booking);
    }

    public void updateStatus(Long id, String status) {
        bookingRepository.updateStatus(id, status);
    }

    public void deleteById(Long id) {
        bookingRepository.deleteById(id);
    }
}