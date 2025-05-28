
-- Users
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    role ENUM('admin', 'editor') DEFAULT 'editor',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Laguages
CREATE TABLE languages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(5) UNIQUE NOT NULL,  -- 'en', 'ru', etc.
    name VARCHAR(50) NOT NULL
);

-- Posts
CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    slug VARCHAR(150) UNIQUE NOT NULL,
    category_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Posts translations
CREATE TABLE post_translations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    language_code VARCHAR(5) NOT NULL,
    title VARCHAR(255) NOT NULL,
    body TEXT,
    meta_title VARCHAR(255),
    meta_description VARCHAR(500),
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (language_code) REFERENCES languages(code)
);

-- Categegories
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL
);

-- Gallery - albums
CREATE TABLE gallery_albums (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Gallery - images
CREATE TABLE gallery_images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    album_id INT NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    caption VARCHAR(255),
    uploaded_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (album_id) REFERENCES gallery_albums(id)
);

-- Feedback
CREATE TABLE contact_forms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    message TEXT NOT NULL,
    submitted_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Setting (can be used for email SMTP, logos etc.)
CREATE TABLE settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    setting_key VARCHAR(100) UNIQUE NOT NULL,
    setting_value TEXT
);
