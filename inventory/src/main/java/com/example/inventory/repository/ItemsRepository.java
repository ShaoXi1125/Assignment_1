package com.example.inventory.repository;

import com.example.inventory.entity.items;
import com.example.inventory.entity.supplier;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ItemsRepository extends JpaRepository<items, Long> {
    List<items> findByProductNameContaining(String keyword);

    @Query("SELECT DISTINCT s FROM supplier s")
    List<supplier> findAllSuppliers();

    @Query("SELECT i.quantityOnHand FROM items i WHERE i.productId = :productId")
    Integer getQuantityOnHand(@Param("productId") Long productId);

    @Transactional
    @Modifying
    @Query("UPDATE items i SET i.quantityOnHand = :quantity WHERE i.productId = :productId")
    void updateQuantity(@Param("productId") Long productId, @Param("quantity") int quantity);

}