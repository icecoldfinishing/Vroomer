package etu.sprint.controller;

import etu.sprint.annotation.AnnotationController;
import etu.sprint.annotation.GetMapping;
import etu.sprint.model.ModelView;


@AnnotationController("/")
public class HelloController {

    @GetMapping("/")
    public ModelView home() {
        ModelView mv = new ModelView();
        mv.setView("/views/index.html");
        return mv;
    }

    @GetMapping("/hello")
    public ModelView hello() {
        ModelView mv = new ModelView();
        mv.addItem("message", "Hello World!");
        mv.setView("/views/hello.html");
        return mv;
    }
}
