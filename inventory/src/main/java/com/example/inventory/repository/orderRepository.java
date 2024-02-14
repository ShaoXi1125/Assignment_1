package com.example.inventory.repository;
import com.example.inventory.entity.createorder;

import org.springframework.data.jpa.repository.JpaRepository;


public interface orderRepository extends JpaRepository<createorder, Long> {
}
