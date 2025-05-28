
# Blog CMS

A lightweight and extensible content management system built with Adobe ColdFusion and MySQL.  
Ideal for personal blogs, photo galleries, and simple websites with multi-language support.

---

## ✨ Features

- ✅ Admin authentication
- 🌐 Multilingual blog system
- 🖼️ Image gallery with albums
- 📬 Contact form with CAPTCHA & SMTP email notifications
- 🗃️ MySQL backend with importable schema
- 📁 Clean structure and modular codebase

---

## 📦 Project Structure

```
blog-cms/
├── Application.cfc
├── blog_cms_schema.sql
├── .env.example
├── admin/
│   ├── index.cfm
│   ├── login.cfm / logout.cfm / user_auth.cfm
│   ├── posts.cfm / post_form.cfm
│   ├── gallery.cfm / gallery_form.cfm / gallery_images.cfm
│   └── forms.cfm
├── public/
│   ├── index.cfm / blog.cfm / post.cfm
│   ├── gallery.cfm / gallery_view.cfm
│   └── contact.cfm
├── assets/uploads/ (create manually)
└── .gitignore
```

---

## 🚀 Installation Guide

### 1. Database Setup
- Import `blog_cms_schema.sql` into your MySQL server
- Create a datasource in ColdFusion admin named: `blog_cms_db`

### 2. Environment Configuration
- Copy `.env.example` to `.env` and fill in your SMTP credentials
- Make sure your ColdFusion server allows access to environment variables

### 3. ColdFusion Setup
- Deploy all files into your ColdFusion webroot
- Ensure `/assets/uploads/` exists and is writable

### 4. Admin Access
```sql
INSERT INTO users (username, password_hash, role)
VALUES ('admin', HASH('admin123'), 'admin');
```
- Login at `/login.cfm` using the above credentials

---

## 🛡️ Security & Notes

- CAPTCHA is built-in using a simple math question
- SMTP email notification is triggered upon contact form submission
- Admin pages are protected via session-based authentication
- No external dependencies

---

## 🤝 License

This project is open-source and free to use for personal or commercial purposes.  
Feel free to modify, expand, or contribute!

---

Made with ❤️ for simplicity and clarity.
