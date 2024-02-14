package com.example.inventory.controller;


import java.math.BigDecimal;
import java.util.Optional;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.inventory.repository.ItemsRepository;
import com.example.inventory.repository.orderRepository;
import com.example.inventory.entity.createorder;
import com.example.inventory.entity.items;


@Controller
public class productcontroller {
	 @Autowired
	    private ItemsRepository itemsRepository;
	 
	 @PostMapping("/additems")
	 public String addProduct(@ModelAttribute items items) {
		    try {
		        itemsRepository.save(items);
		    } catch (Exception e) {
		        e.printStackTrace(); // Log the exception details
		        // You might want to return an error view or handle the error in a specific way
		        return "error";
		    }

		    return "redirect:/"; // Redirect to the home page or any other page after submission
		}
	 
	 @GetMapping("/delete/{productId}")
	    public String deleteProduct(@PathVariable Long productId) {
	        try {
	            itemsRepository.deleteById(productId);
	        } catch (Exception e) {
	            e.printStackTrace();
	            return "error";
	        }
	        return "redirect:/";
	    }
	 
	 @PostMapping("/update/{productId}")
	    @ResponseBody
	    public ResponseEntity<String> updateProduct(@PathVariable Long productId, @RequestBody Map<String, String> data) {
	        Optional<items> productOptional = itemsRepository.findById(productId);
	        if (productOptional.isPresent()) {
	            items product = productOptional.get();
	            product.setProductName(data.get("cell_1"));
	            product.setDescription(data.get("cell_2"));
	            product.setPrice(new BigDecimal(data.get("cell_3")));
	            product.setQuantityOnHand(Integer.parseInt(data.get("cell_4")));
	            itemsRepository.save(product);
	            return ResponseEntity.ok("Product updated successfully");
	        } else {
	            return ResponseEntity.notFound().build();
	        }
	    }
	 
	 @GetMapping("/search")
	 @ResponseBody
	 public List<items> searchItems(@RequestParam String keyword) {
	     return itemsRepository.findByProductNameContaining(keyword);
	 }
	 
	 
	 private int getProductQuantityFromDatabase(Long productId) {
		    Optional<items> productOptional = itemsRepository.findById(productId);
		    if (productOptional.isPresent()) {
		        items product = productOptional.get();
		        return product.getQuantityOnHand();
		    } else {
		        throw new RuntimeException("Product not found for ID: " + productId);
		    }
		}
	 	@Autowired
	 	private orderRepository orderRepository;
	    @PostMapping("/createorder")
	    public String createOrder(@RequestParam Long productId, @RequestParam Long supplierId, @RequestParam int quantity) {
	        try {
	            // create order
	            createorder order = new createorder();
	            order.setProductID(productId);
	            order.setSupplierID(supplierId);
	            order.setQuantity(quantity);

	            // Save order to database
	            orderRepository.save(order);

	            // Update the inventory quantity of the corresponding product in the product table
	            // query the current inventory quantity from the database
	            int currentQuantity = getProductQuantityFromDatabase(productId);
	            int updatedQuantity = currentQuantity - quantity;

	            // update data quantity
	            itemsRepository.updateQuantity(productId, updatedQuantity);

	            return "redirect:/";
	        } catch (Exception e) {
	            e.printStackTrace();
	            return "error"; 
	        }
	    }
}


