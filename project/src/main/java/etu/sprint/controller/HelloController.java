package etu.sprint.controller;

import etu.sprint.annotation.AnnotationController;
import etu.sprint.annotation.GetMapping;
import etu.sprint.model.ModelView;


@AnnotationController("/")
public class HelloController {

    @GetMapping("/")
    public ModelView hello() {
        ModelView mv = new ModelView();
        mv.addItem("message", "Hello World!");
        mv.setView("/views/hello.jsp");
        return mv;
    }

    @GetMapping("/about")
    public ModelView about() {
        ModelView mv = new ModelView();
        mv.addItem("message", "About page");
        mv.setView("/views/about.jsp");
        return mv;
    }
}
