package com.plango.service;

import com.plango.entity.Destination;
import com.plango.entity.Itinerary;
import com.plango.entity.ItineraryItem;
import com.plango.entity.User;
import com.plango.repository.DestinationRepository;
import com.plango.repository.ItineraryItemRepository;
import com.plango.repository.ItineraryRepository;
import com.plango.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ItineraryService {

    private final ItineraryRepository itineraryRepository;
    private final ItineraryItemRepository itineraryItemRepository;
    private final DestinationRepository destinationRepository;
    private final UserRepository userRepository;

    public ItineraryService(
            ItineraryRepository itineraryRepository,
            ItineraryItemRepository itineraryItemRepository,
            DestinationRepository destinationRepository,
            UserRepository userRepository
    ) {
        this.itineraryRepository = itineraryRepository;
        this.itineraryItemRepository = itineraryItemRepository;
        this.destinationRepository = destinationRepository;
        this.userRepository = userRepository;
    }

    public List<Itinerary> findByUserId(Long userId) {
        return itineraryRepository.findByUserId(userId);
    }

    public Itinerary findById(Long id) {
        return itineraryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Itinerary tidak ditemukan"));
    }

    public Itinerary create(Long userId, String title, Integer totalPeople) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User tidak ditemukan"));

        Itinerary itinerary = new Itinerary();
        itinerary.setUser(user);
        itinerary.setTitle(title);
        itinerary.setTotalPeople(totalPeople == null ? 1 : totalPeople);
        itinerary.setCreatedAt(LocalDateTime.now());

        return itineraryRepository.save(itinerary);
    }

    public ItineraryItem addDestination(Long itineraryId, Long destinationId) {
        Itinerary itinerary = findById(itineraryId);
        Destination destination = destinationRepository.findById(destinationId)
                .orElseThrow(() -> new RuntimeException("Destination tidak ditemukan"));

        ItineraryItem item = new ItineraryItem();
        item.setItinerary(itinerary);
        item.setDestination(destination);
        item.setVisitTime(LocalDateTime.now());

        return itineraryItemRepository.save(item);
    }

    public void deleteItem(Long itemId) {
        itineraryItemRepository.deleteById(itemId);
    }

    public void updateVisitTime(Long itemId, LocalDateTime visitTime) {
    itineraryItemRepository.updateVisitTime(itemId, visitTime);
}
}
