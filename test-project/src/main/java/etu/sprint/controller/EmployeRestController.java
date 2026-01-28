package etu.sprint.controller;

import etu.sprint.annotation.AnnotationController;
import etu.sprint.annotation.GetMapping;
import etu.sprint.annotation.RestAPI;
import etu.sprint.model.Employe;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@AnnotationController("/api/employers")
public class EmployeRestController {

    private static final List<Employe> employes = new ArrayList<>();
    private static int nextId = 1;

    static {
        employes.add(new Employe(nextId++, "Jean Dupont", 2500.0, Arrays.asList("Java", "SQL")));
        employes.add(new Employe(nextId++, "Marie Martin", 2800.50, Arrays.asList("Python", "Cloud")));
        employes.add(new Employe(nextId++, "Paul Durand", 3200.0, Arrays.asList("Frontend", "UI/UX")));
    }

    @GetMapping("/")
    @RestAPI
    public List<Employe> getAllEmployes() {
        return employes;
    }

    @GetMapping("{id}")
    @RestAPI
    public Employe getEmployeById(int id) {
        return employes.stream()
                .filter(e -> e.getId() == id)
                .findFirst()
                .orElse(null); // In a real app, you might throw an exception for a 404
    }
}
