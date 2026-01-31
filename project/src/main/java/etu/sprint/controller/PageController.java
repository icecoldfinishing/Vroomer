package etu.sprint.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/")
    public String index() {
        return "redirect:/index.html";
    }

    @GetMapping("/index")
    public String home() {
        return "redirect:/index.html";
    }

    @GetMapping("/about")
    public String about() {
        return "redirect:/about.html";
    }

    @GetMapping("/services")
    public String services() {
        return "redirect:/services.html";
    }

    @GetMapping("/pricing")
    public String pricing() {
        return "redirect:/pricing.html";
    }

    @GetMapping("/car")
    public String cars() {
        return "redirect:/car.html";
    }

    @GetMapping("/car-single")
    public String carSingle() {
        return "redirect:/car-single.html";
    }

    @GetMapping("/blog")
    public String blog() {
        return "redirect:/blog.html";
    }

    @GetMapping("/blog-single")
    public String blogSingle() {
        return "redirect:/blog-single.html";
    }

    @GetMapping("/contact")
    public String contact() {
        return "redirect:/contact.html";
    }
}
