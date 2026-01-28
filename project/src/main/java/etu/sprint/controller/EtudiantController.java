package etu.sprint.controller;

import etu.sprint.annotation.AnnotationController;
import etu.sprint.annotation.GetMapping;
import etu.sprint.annotation.RequestParameter;
import etu.sprint.model.Etudiant;
import etu.sprint.model.ModelView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@AnnotationController("/etudiants")
public class EtudiantController {

    private static final Map<String, Etudiant> etudiants = new HashMap<>();

    static {
        etudiants.put("ETU001", new Etudiant("ETU001", "Jean Dupont", 20));
        etudiants.put("ETU002", new Etudiant("ETU002", "Marie Martin", 22));
        etudiants.put("ETU003", new Etudiant("ETU003", "Paul Durand", 21));
    }

    @GetMapping("/")
    public ModelView findAll() {
        ModelView mv = new ModelView();
        // Create a list of all students
        List<Etudiant> etudiantList = new ArrayList<>(etudiants.values());
        // Add the list to the ModelView
        mv.addItem("etudiantList", etudiantList);
        // Set the view to display the list of students
        mv.addItem("etudiantList", new ArrayList<>(etudiants.values()));
        mv.setView("/views/etudiant-list.jsp");
        // Return the ModelView
        return mv;
    }
/*******  c1da0671-3f40-42cc-8538-3e45364dd5b8  *******/

    @GetMapping("{code}")
    public ModelView findById(@RequestParameter("code") String id) {
        ModelView mv = new ModelView();
        Etudiant etudiant = etudiants.get(id);
        if (etudiant != null) {
            mv.addItem("etudiant", etudiant);
            mv.setView("/views/etudiant-details.jsp");
        } else {
            mv.setView("/views/error.jsp"); 
            mv.addItem("message", "Student with id: " + id + " not found.");
        }
        return mv;
    }


    @GetMapping("{id}/name/{name}")
    public ModelView findDetails(String id, @RequestParameter("name") String nom) {
        ModelView mv = new ModelView();
        Etudiant etudiant = etudiants.get(id);
        if (etudiant != null) {
            mv.addItem("etudiant", etudiant);
            mv.addItem("nameFromUrl", nom);
            mv.setView("/views/etudiant-details-with-name.jsp"); 
        } else {
            mv.setView("/views/error.jsp");
            mv.addItem("message", "Student with ID: " + id + " not found.");
        }
        return mv;
    }
}

