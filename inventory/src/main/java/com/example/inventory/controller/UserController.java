package com.example.inventory.controller;

import com.example.inventory.entity.user;
import com.example.inventory.repository.userRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

@Controller
public class UserController {
    
    @Autowired
    private userRepository userRepository;

    // @Autowired
    // private BCryptPasswordEncoder passwordEncoder;

    @GetMapping("/register")
    public String showRegisterForm() {
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@RequestParam("username") String username,@RequestParam("password") String password,@RequestParam("role") String role) {
      
        user user = new user();
        user.setUsername(username);
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        user.setPassword(hashedPassword);
        user.setRole(role);

 
        userRepository.save(user);

 
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String showLoginForm(){
        return "login";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam("username") String username,@RequestParam("password") String password,HttpSession session) {
        user user = userRepository.findByUsername(username);

        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            session.setAttribute("username", username);
            session.setAttribute("role", user.getRole());
            if (user.getRole().equals("Admin")) {
                return "redirect:/";
            } else if (user.getRole().equals("User")) {
                return "redirect:/dashboard";
            }
        }

        return "redirect:/login?error";
    }




    @GetMapping("/logout")
    public String logout(HttpSession session, SessionStatus sessionStatus) { 
        session.invalidate();
        sessionStatus.setComplete();
        return "redirect:/login";
    }

//     @GetMapping("/protectedPage")
//     public String protectedPage(HttpServletRequest request, HttpSession session) {
//     String originalUrl = request.getRequestURI();
//     session.setAttribute("originalUrl", originalUrl);
//     return "redirect:/login";
// }

}
