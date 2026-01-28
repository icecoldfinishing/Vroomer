package etu.sprint.controller;

import etu.sprint.annotation.AnnotationController;
import etu.sprint.annotation.GetMapping;
import etu.sprint.model.ModelView;

@AnnotationController("/model")
public class ModelViewController {

    @GetMapping("/data")
    public ModelView showData() {
        ModelView mv = new ModelView();
        mv.setView("/views/data.jsp");
        mv.addItem("message", "Ceci est un message du ModelView!");
        mv.addItem("number", 12345);
        return mv;
    }
}
