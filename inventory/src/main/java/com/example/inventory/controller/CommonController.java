package com.example.inventory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.inventory.entity.items;
import com.example.inventory.entity.supplier;
import com.example.inventory.repository.ItemsRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.ui.Model;

import java.util.List;


@Controller
public class CommonController {

	 @Autowired
	    private ItemsRepository itemsRepository;

	    @GetMapping("/")
	    public String displayData(Model model) {
	        List<items> itemList = itemsRepository.findAll();
	        model.addAttribute("itemList", itemList);
	        return "index"; 
	    }
    
    

    @GetMapping("/additems")
    public String getAddItemspage() {
        return "additems";
    }
    
    @GetMapping("/createorder")
	public String getCreateOrderPage(Model model) {
    	List<items> itemList = itemsRepository.findAll();
        model.addAttribute("itemList", itemList);
     
        
        List<supplier> supplierList = itemsRepository.findAllSuppliers(); 
        model.addAttribute("supplierList", supplierList);
        
        return "createorder";
        
	}

    public static void main(String[] args) {
        SpringApplication.run(CommonController.class, args);
    }
}
