package etu.sprint.controller;

import etu.sprint.annotation.AnnotationController;
import etu.sprint.annotation.GetMapping;

@AnnotationController("/")
public class HelloController {

    @GetMapping("/")
    public String index() {
        return "<h1>Hello World from Annotation Controller!</h1>";
    }
}
