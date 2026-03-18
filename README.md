# Task Manager Full-Stack Application

A comprehensive task management solution featuring a mobile app, a landing page, and a robust backend.

## Project Structure

- `backend/`: Node.js + Express + MongoDB
- `landing_page/`: React JS + Vite
- `mobile_app/`: Flutter Mobile Application

## Setup Instructions (Local)

### 1. Backend Setup
1. Navigate to the `backend` folder.
2. Run `npm install`.
3. Create a `.env` file and add your `MONGODB_URI` and `JWT_SECRET`.
4. Run `npm start`.

### 2. Landing Page Setup
1. Navigate to the `landing_page` folder.
2. Run `npm install`.
3. Run `npm run dev`.
4. Access at `http://localhost:5173`.

### 3. Mobile App Setup
1. Navigate to the `mobile_app` folder.
2. Run `flutter pub get`.
3. Update `baseUrl` in `lib/services/api_service.dart`.
4. Run `flutter run`.

## Deployment Instructions (Render)

### 1. Backend Deployment (Web Service)
- **Root Directory**: `backend`
- **Build Command**: `npm install`
- **Start Command**: `node server.js`
- **Environment Variables**:
  - `MONGODB_URI`: (Your Atlas connection string)
  - `JWT_SECRET`: `taskmanager_jwt_secret_key_2024`
  - `PORT`: `5000`

### 2. Landing Page Deployment (Static Site)
- **Root Directory**: `landing_page`
- **Build Command**: `npm run build`
- **Publish Directory**: `dist`

### 3. Flutter App Update
Update the `baseUrl` in `lib/services/api_service.dart` with your live Render URL:
```dart
static final String baseUrl = 'https://your-backend.onrender.com/api';
```

## Architectural Decisions

- **Backend**: Modular structure with Controllers/Routes. JWT for secure auth.
- **Frontend (Web)**: React with Vite and Framer Motion for a premium look.
- **Mobile (Flutter)**: Provider for state management and SharedPreferences for persistent login.
- **Database**: MongoDB Atlas for cloud-based data storage.
