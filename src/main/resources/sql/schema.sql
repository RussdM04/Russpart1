-- Drop existing table if exists
CREATE DATABASE IF NOT EXISTS russpart1;
USE russpart1;

DROP TABLE IF EXISTS users;
 
-- Create users table with proper constraints and indexes
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uk_username UNIQUE (username),
    CONSTRAINT uk_email UNIQUE (email),
    INDEX idx_email (email),
    INDEX idx_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add comments to the table and columns
ALTER TABLE users COMMENT 'User accounts table';
ALTER TABLE users MODIFY COLUMN id BIGINT AUTO_INCREMENT COMMENT 'Primary key';
ALTER TABLE users MODIFY COLUMN username VARCHAR(50) NOT NULL COMMENT 'Unique username';
ALTER TABLE users MODIFY COLUMN email VARCHAR(100) NOT NULL COMMENT 'Unique email address';
ALTER TABLE users MODIFY COLUMN password VARCHAR(255) NOT NULL COMMENT 'Encrypted password';
ALTER TABLE users MODIFY COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Account creation timestamp';
ALTER TABLE users MODIFY COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update timestamp';
ALTER TABLE users ADD COLUMN phone_number VARCHAR(20) NOT NULL DEFAULT '+0000000000' COMMENT 'Unique phone number';
ALTER TABLE users ADD CONSTRAINT uk_phone_number UNIQUE (phone_number);
ALTER TABLE users ADD INDEX idx_phone_number (phone_number);
ALTER TABLE users ADD COLUMN address VARCHAR(255) NOT NULL DEFAULT 'Unknown' COMMENT 'User address';
ALTER TABLE users ADD COLUMN date_of_birth DATE NOT NULL COMMENT 'User Date of Birth';