package com.example.inventory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;

import com.example.inventory.entity.items;
import com.example.inventory.entity.supplier;
import com.example.inventory.repository.ItemsRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.ui.Model;

import java.util.List;

import javax.servlet.http.HttpSession;


@Controller
// @RequestMapping("/common")
public class CommonController {

	 @Autowired
	    private ItemsRepository itemsRepository;

	    @GetMapping("/")
	    public String displayData(Model model, HttpSession session) {
            
        String username = (String) session.getAttribute("username");
            if (username != null) {
        
                List<items> itemList = itemsRepository.findAll();
                model.addAttribute("itemList", itemList);
                return "index"; 
            } else {
              
                return "redirect:/login";
            }
	    }

        @GetMapping("/dashboard")
        public String userDashboard(Model model,HttpSession session) {

            String username = (String) session.getAttribute("username");
            if (username != null) {
                List<items> itemList = itemsRepository.findAll();
                model.addAttribute("itemList", itemList);
                return "dashboard";
            } 
            return "redirect:/login";
        }
        
        @GetMapping("/additems")
        public String getAddItemspage(HttpSession session) {
            String username = (String) session.getAttribute("username");
            if (username != null) {
                return "additems";
            } else {
                return "redirect:/login";
            }
        }
    
        @GetMapping("/createorder")
        public String getCreateOrderPage(Model model, HttpSession session) {
            String username = (String) session.getAttribute("username");
            if (username != null) {
                List<items> itemList = itemsRepository.findAll();
                model.addAttribute("itemList", itemList);
    
                List<supplier> supplierList = itemsRepository.findAllSuppliers();
                model.addAttribute("supplierList", supplierList);
    
                return "createorder";
            } else {
                return "redirect:/login";
            }
        }
    

    public static void main(String[] args) {
        SpringApplication.run(CommonController.class, args);
    }
}
