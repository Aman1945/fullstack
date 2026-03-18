# Task Manager Full-Stack Application

A comprehensive task management solution featuring a mobile app, a landing page, and a robust backend.

## Project Structure

- `backend/`: Node.js + Express + MongoDB
- `landing_page/`: React JS + Vite
- `mobile_app/`: Flutter Mobile Application

## Setup Instructions

### 1. Backend Setup
1. Navigate to the `backend` folder.
2. Run `npm install`.
3. Create a `.env` file (if not present) and add your `MONGODB_URI` and `JWT_SECRET`.
4. Run `npm start` or `node server.js`.

### 2. Landing Page Setup
1. Navigate to the `landing_page` folder.
2. Run `npm install`.
3. Run `npm run dev`.
4. Access the landing page at `http://localhost:5173`.

### 3. Mobile App Setup
1. Navigate to the `mobile_app` folder.
2. Run `flutter pub get`.
3. Ensure the `baseUrl` in `lib/services/api_service.dart` points to your backend IP (use `10.0.2.2` for Android Emulator).
4. Run `flutter run`.

## Architectural Decisions

- **Backend**: Used a modular structure with Controllers and Routes to separate concerns. Implemented JWT for secure, stateless authentication.
- **Frontend (Web)**: React with Vite for fast builds. Used Framer Motion for premium animations and glassmorphism for a modern aesthetic.
- **Mobile (Flutter)**: Utilized Provider for state management to ensure a reactive and maintainable UI flow. Persistent login is handled via SharedPreferences.
- **Database**: MongoDB with Mongoose to allow flexible task schemas while maintaining data relationships.

## Features

- **Auth**: Secure Register/Login with JWT.
- **Tasks**: Create, Read, Update, Delete with status filtering.
- **Dashboard**: Visual statistics showing Completed vs Pending tasks.
- **Landing Page**: Responsive design with a functional Contact Us form linked to the backend.
