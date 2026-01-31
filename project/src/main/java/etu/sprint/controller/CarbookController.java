package etu.sprint.controller;

import etu.sprint.annotation.AnnotationController;
import etu.sprint.annotation.GetMapping;
import etu.sprint.model.ModelView;

@AnnotationController("/")
public class CarbookController {

    @GetMapping("/index")
    public ModelView index() {
        ModelView mv = new ModelView();
        mv.setView("/views/index.html");
        return mv;
    }

    @GetMapping("/about")
    public ModelView about() {
        ModelView mv = new ModelView();
        mv.setView("/views/about.html");
        return mv;
    }

    @GetMapping("/services")
    public ModelView services() {
        ModelView mv = new ModelView();
        mv.setView("/views/services.html");
        return mv;
    }

    @GetMapping("/pricing")
    public ModelView pricing() {
        ModelView mv = new ModelView();
        mv.setView("/views/pricing.html");
        return mv;
    }

    @GetMapping("/car")
    public ModelView car() {
        ModelView mv = new ModelView();
        mv.setView("/views/car.html");
        return mv;
    }

    @GetMapping("/car-single")
    public ModelView carSingle() {
        ModelView mv = new ModelView();
        mv.setView("/views/car-single.html");
        return mv;
    }

    @GetMapping("/blog")
    public ModelView blog() {
        ModelView mv = new ModelView();
        mv.setView("/views/blog.html");
        return mv;
    }

    @GetMapping("/blog-single")
    public ModelView blogSingle() {
        ModelView mv = new ModelView();
        mv.setView("/views/blog-single.html");
        return mv;
    }

    @GetMapping("/contact")
    public ModelView contact() {
        ModelView mv = new ModelView();
        mv.setView("/views/contact.html");
        return mv;
    }

    @GetMapping("/main")
    public ModelView main() {
        ModelView mv = new ModelView();
        mv.setView("/views/main.html");
        return mv;
    }
}
