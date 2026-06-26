package com.plango.entity;

import java.time.LocalDateTime;

// Class anak yang mewarisi Booking (INHERITANCE)
public class TiketWisataBooking extends Booking {
    
    // Field khusus untuk booking tiket wisata
    private String namaDestinasi;
    private String lokasiDestinasi;
    private String kategoriDestinasi;
    private int jumlahTiket;
    private LocalDateTime tanggalKunjungan;
    private String tipeTiket; // DEWASA, ANAK-ANAK, VIP
    private String namaPengunjung;

    // Constructor
    public TiketWisataBooking() {
        super(); // Memanggil constructor class induk (Booking)
    }

    // Getter dan Setter untuk field khusus tiket wisata
    public String getNamaDestinasi() {
        return namaDestinasi;
    }

    public void setNamaDestinasi(String namaDestinasi) {
        this.namaDestinasi = namaDestinasi;
    }

    public String getLokasiDestinasi() {
        return lokasiDestinasi;
    }

    public void setLokasiDestinasi(String lokasiDestinasi) {
        this.lokasiDestinasi = lokasiDestinasi;
    }

    public String getKategoriDestinasi() {
        return kategoriDestinasi;
    }

    public void setKategoriDestinasi(String kategoriDestinasi) {
        this.kategoriDestinasi = kategoriDestinasi;
    }

    public int getJumlahTiket() {
        return jumlahTiket;
    }

    public void setJumlahTiket(int jumlahTiket) {
        this.jumlahTiket = jumlahTiket;
    }

    public LocalDateTime getTanggalKunjungan() {
        return tanggalKunjungan;
    }

    public void setTanggalKunjungan(LocalDateTime tanggalKunjungan) {
        this.tanggalKunjungan = tanggalKunjungan;
    }

    public String getTipeTiket() {
        return tipeTiket;
    }

    public void setTipeTiket(String tipeTiket) {
        this.tipeTiket = tipeTiket;
    }

    public String getNamaPengunjung() {
        return namaPengunjung;
    }

    public void setNamaPengunjung(String namaPengunjung) {
        this.namaPengunjung = namaPengunjung;
    }
}
