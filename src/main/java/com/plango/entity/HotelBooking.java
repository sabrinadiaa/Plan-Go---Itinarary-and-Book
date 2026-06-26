package com.plango.entity;

import java.time.LocalDateTime;

// Class anak yang mewarisi Booking (INHERITANCE)
public class HotelBooking extends Booking {
    
    // Field khusus untuk booking hotel
    private String hotelName;
    private String hotelAddress;
    private String roomType;
    private int totalMalam;
    private LocalDateTime checkInDate;
    private LocalDateTime checkOutDate;
    private int totalTamu;

    // Constructor
    public HotelBooking() {
        super(); // Memanggil constructor class induk (Booking)
    }

    // Getter dan Setter untuk field khusus hotel
    public String getHotelName() {
        return hotelName;
    }

    public void setHotelName(String hotelName) {
        this.hotelName = hotelName;
    }

    public String getHotelAddress() {
        return hotelAddress;
    }

    public void setHotelAddress(String hotelAddress) {
        this.hotelAddress = hotelAddress;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public int getTotalMalam() {
        return totalMalam;
    }

    public void setTotalMalam(int totalMalam) {
        this.totalMalam = totalMalam;
    }

    public LocalDateTime getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(LocalDateTime checkInDate) {
        this.checkInDate = checkInDate;
    }

    public LocalDateTime getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(LocalDateTime checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public int getTotalTamu() {
        return totalTamu;
    }

    public void setTotalTamu(int totalTamu) {
        this.totalTamu = totalTamu;
    }
}