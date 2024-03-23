package com.example.inventory.repository;

import com.example.inventory.entity.user;
import org.springframework.data.jpa.repository.JpaRepository;

public interface userRepository extends JpaRepository<user, Long> {
    user findByUsername(String username);
}
