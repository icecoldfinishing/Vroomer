package etu.sprint.controller;

import etu.sprint.entity.*;
import etu.sprint.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class ApiRestController {

    @Autowired
    private VoitureService voitureService;

    @Autowired
    private ServiceService serviceService;

    @Autowired
    private TemoignageService temoignageService;

    @Autowired
    private BlogService blogService;

    @Autowired
    private StatistiqueService statistiqueService;

    @Autowired
    private ReservationService reservationService;

    // ============== VOITURES ==============

    @GetMapping("/voitures")
    public ResponseEntity<List<Voiture>> getVoitures() {
        return ResponseEntity.ok(voitureService.findAll());
    }

    @GetMapping("/voitures/featured")
    public ResponseEntity<List<Voiture>> getFeaturedVoitures() {
        return ResponseEntity.ok(voitureService.findFeatured());
    }

    @GetMapping("/voiture")
    public ResponseEntity<Voiture> getVoiture(@RequestParam Integer id) {
        return voitureService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // ============== SERVICES ==============

    @GetMapping("/services")
    public ResponseEntity<List<Service>> getServices() {
        return ResponseEntity.ok(serviceService.findAllActive());
    }

    // ============== TEMOIGNAGES ==============

    @GetMapping("/temoignages")
    public ResponseEntity<List<Temoignage>> getTemoignages() {
        return ResponseEntity.ok(temoignageService.findAllActive());
    }

    // ============== BLOGS ==============

    @GetMapping("/blogs")
    public ResponseEntity<List<Blog>> getBlogs() {
        return ResponseEntity.ok(blogService.findAllActive());
    }

    @GetMapping("/blogs/recent")
    public ResponseEntity<List<Blog>> getRecentBlogs() {
        return ResponseEntity.ok(blogService.findRecent(3));
    }

    @GetMapping("/blog")
    public ResponseEntity<Blog> getBlog(@RequestParam Integer id) {
        return blogService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // ============== STATISTIQUES ==============

    @GetMapping("/statistiques")
    public ResponseEntity<List<Statistique>> getStatistiques() {
        return ResponseEntity.ok(statistiqueService.findAll());
    }

    // ============== RESERVATIONS ==============

    @PostMapping("/reservations")
    public ResponseEntity<Reservation> createReservation(@RequestBody Reservation reservation) {
        Reservation saved = reservationService.save(reservation);
        return ResponseEntity.ok(saved);
    }

    @GetMapping("/reservations")
    public ResponseEntity<List<Reservation>> getReservations() {
        return ResponseEntity.ok(reservationService.findAll());
    }
}
