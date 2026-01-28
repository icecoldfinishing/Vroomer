package etu.sprint.model;

import java.util.List;
import java.util.ArrayList;

public class Employe {
    private int id;
    private String nom;
    private double salaire;
    private List<String> skills;

    public Employe() {
        this.skills = new ArrayList<>();
    }

    public Employe(int id, String nom, double salaire) {
        this.id = id;
        this.nom = nom;
        this.salaire = salaire;
        this.skills = new ArrayList<>(); // Default empty list
    }

    public Employe(int id, String nom, double salaire, List<String> skills) {
        this.id = id;
        this.nom = nom;
        this.salaire = salaire;
        this.skills = skills != null ? skills : new ArrayList<>();
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public double getSalaire() {
        return salaire;
    }

    public void setSalaire(double salaire) {
        this.salaire = salaire;
    }

    public List<String> getSkills() {
        return skills;
    }

    public void setSkills(List<String> skills) {
        this.skills = skills;
    }
}
