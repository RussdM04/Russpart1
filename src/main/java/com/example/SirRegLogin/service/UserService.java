package com.example.SirRegLogin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.example.SirRegLogin.model.User;
import com.example.SirRegLogin.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * User Service
 * Handles business logic for user-related operations including:
 * - User registration and validation
 * - Password encryption
 * - Database operations through UserRepository
 * - Logging of user-related activities
 */
@Service
public class UserService {

    /** Logger for tracking service operations */
    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    /** Repository for user data persistence operations */
    @Autowired
    private UserRepository userRepository;

    /** Encoder for secure password hashing */
    @Autowired
    private PasswordEncoder passwordEncoder;

    /**
     * Registers a new user in the system
     * This method:
     * 1. Validates that email and username are unique
     * 2. Encrypts the user's password
     * 3. Saves the user to the database
     * 4. Logs the registration process
     *
     * @param user the User object containing registration data
     * @return the saved User object with encrypted password
     * @throws RuntimeException if email is already registered or username is taken
     */
    public User registerUser(User user) {
        logger.info("Attempting to register user: {}", user.getUsername());

        // Validate email uniqueness
        if (userRepository.existsByEmail(user.getEmail())) {
            logger.error("Registration failed: Email {} already exists", user.getEmail());
            throw new RuntimeException("Email already registered");
        }

        // Validate username uniqueness
        if (userRepository.existsByUsername(user.getUsername())) {
            logger.error("Registration failed: Username {} already exists", user.getUsername());
            throw new RuntimeException("Username already taken");
        }

        if (userRepository.existsByPhoneNumber(user.getPhoneNumber())) {
            logger.error("Registration failed: Phone number {} already exists", user.getPhoneNumber());
            throw new RuntimeException("Phone number already registered");
        }

        
        // Check if the address is already registered (if needed)
        if (userRepository.existsByAddress(user.getAddress())) {
            logger.error("Registration failed: Address {} already exists", user.getAddress());
            throw new RuntimeException("Address already registered");
        }

        // Encrypt password and save user
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        User savedUser = userRepository.save(user);
        logger.info("User registered successfully: {}", savedUser.getUsername());
        return savedUser;
    }
} 