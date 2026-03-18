# 🚀 TaskFlow – Full Stack Task Management System

A production-ready full-stack application featuring a Flutter mobile app, a React landing page, and a secure Node.js backend.

---

## 🛠️ Tech Stack

* 📱 **Mobile App**: Flutter (Provider + Shared Preferences)
* 🌐 **Frontend**: React JS (Vite + Vanilla CSS)
* ⚙️ **Backend**: Node.js + Express
* 🗄️ **Database**: MongoDB (Mongoose)
* ☁️ **Deployment**: Render

---

## 🚀 Live Demo

* 🌐 **Live Website**: [https://fullstack-1-dsj4.onrender.com/](https://fullstack-1-dsj4.onrender.com/)
* 📦 **Live Backend**: [https://fullstack-me1i.onrender.com](https://fullstack-me1i.onrender.com)
* 📦 **APK Download**: (https://drive.google.com/file/d/1NMjHKG_7LAsF0DiNkOz5TuUDIrPvdeiP/view?usp=sharing)

---

## ✨ Features

* 🔐 **Secure JWT Authentication**: Stateless auth for both Web & Mobile.
* 📊 **Dashboard Stats**: Real-time tracking of Total, Completed, and Pending tasks.
* ✅ **Full CRUD Management**: Create, Read, Update, and Delete tasks with ease.
* 🌐 **Lead Sync**: Website Contact Form entries appear instantly in the Mobile App.
* 🔄 **Persistent Login**: Automatic session restoration via Shared Preferences.
* 🎯 **Premium UI**: Ultra-clean "White + Clear Blue" theme with 30px geometry.
* ⚡ **Performance**: Optimized backend with indexing and efficient Mongoose queries.

## 🌐 Website-to-App Integration (Special Feature)

This project demonstrates a real-world full-stack synchronization between the public-facing website and the private mobile app:
1.  **Lead Capture**: When a visitor fills the **Contact Form** on the [React Website](https://fullstack-1-dsj4.onrender.com/), they provide their Name, Email, **Phone Number**, and Message.
2.  **Instant Sync**: Data is transmitted to the **Node.js API** and stored in **MongoDB**.
3.  **App Display**: The authenticated user on the **Flutter Mobile App** navigating to **"Website Enquiries"** can instantly view all leads, including the submitted phone numbers.

---

## 🏗️ Architecture

- **Flutter App** → Node.js API (Render) → MongoDB Atlas
- **React Website** → Node.js API (Render) → MongoDB Atlas

A single, secure backend serves both the customer-facing website and the internal productivity app with strict data isolation.

---

## 🔌 API Endpoints

### **Authentication**
- `POST /api/auth/register` : User signup
- `POST /api/auth/login` : User login + JWT issuance

### **Task Management**
- `GET /api/tasks` : Fetch user-specific tasks
- `POST /api/tasks` : Create a new task
- `PUT /api/tasks/:id` : Update task details or status
- `DELETE /api/tasks/:id` : Remove a task (secured)

### **Website Contact**
- `POST /api/contact` : Submit lead/enquiry from landing page

---

## 🏗️ Architectural Decisions

### **Backend (Node.js)**
- **MVC Pattern**: Modular structure (Models, Controllers, Routes) for high maintainability.
- **Security**: Password hashing with `bcryptjs` and protected routes via JWT middleware.
- **Filtering**: Scoped queries ensure users can only ever access their own data.

### **Frontend (Mobile & Web)**
- **Vite (Web)**: Fast build times and optimized delivery.
- **Provider (Mobile)**: Robust state management for reactive UI updates.
- **Service Layer**: Decoupled API logic in both clients for easier testing and maintenance.

---

## ⚙️ Setup Instructions (Local)

### 1. Backend Setup
1. Navigate to `backend/`
2. Run `npm install`
3. Create `.env` file with `MONGODB_URI` and `JWT_SECRET`.
4. Run `npm start`

### 2. Landing Page Setup
1. Navigate to `landing_page/`
2. Run `npm install`
3. Run `npm run dev`

### 3. Mobile App Setup
1. Navigate to `mobile_app/`
2. Run `flutter pub get`
3. Set `baseUrl` in `lib/services/api_service.dart` to your backend URL.
4. Run `flutter run`

---

## 👨‍💻 Author

**Aman Prajapati**
*Full Stack Developer*
