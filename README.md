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

## 🏗️ Architectural Decisions

### Backend (Node.js & Express)
- **Modular Architecture**: Follows the MVC (Model-View-Controller) pattern with a clear separation of concerns (Routes -> Middlewares -> Controllers -> Models).
- **Security First**: 
  - **JWT Authentication**: Implemented stateless authentication using JSON Web Tokens.
  - **Password Hashing**: Uses `bcryptjs` with a salt factor of 10 to protect user credentials.
  - **Protected Routes**: Custom `protect` middleware ensures only authenticated users access task data.
  - **Data Isolation**: All database queries are scoped to the `req.user.id` to ensure users only see their own tasks.
- **Database Optimization**: 
  - **Indexing**: Added a compound-like index on the `user` field in the Task model to ensure $O(1)$ or $O(\log n)$ lookup performance as the user base grows.
- **Error Handling**: Centralized error middleware captures all async errors and returns consistent JSON responses with appropriate HTTP status codes.

### Frontend (React Landing Page)
- **Modern Stack**: Built with **Vite** for ultra-fast development and optimized production bundles.
- **Responsive Design**: Mobile-first approach using Vanilla CSS with modern Flexbox/Grid layouts.
- **API Integration**: Decoupled service layer for handling contact form submissions to the shared backend.

### Mobile (Flutter Application)
- **State Management**: Uses the **Provider** pattern for reactive UI updates and clean data flow.
- **Persistence**: Implemented local storage using `shared_preferences` to maintain user sessions across app restarts (Persistent Login).
- **Service Layer**: Clean encapsulation of API calls in a dedicated `ApiService` class.
- **UI/UX**: Custom "White + Clear Blue" theme with a 30px border-radius design system for a premium mobile experience.

## 🔐 Security Considerations
- **CORS Configuration**: Restricts API access to authorized origins only.
- **Token Expiration**: JWTs are issued with a 30-day expiration to balance security and user experience.
- **Input Validation**: Backend schemas enforce strict data types and mandatory fields to prevent malformed data entry.

## 📂 Folder Structure
```text
├── backend/
│   ├── controllers/   # Business logic
│   ├── models/        # Database schemas
│   ├── routes/        # Endpoint definitions
│   ├── middleware/    # Auth and error handlers
│   └── server.js      # Entry point
├── mobile_app/
│   ├── lib/
│   │   ├── models/    # Data classes
│   │   ├── providers/ # State management
│   │   ├── screens/   # UI Screens
│   │   └── services/  # API Logic
├── landing_page/      # React Project
└── README.md
```

## ✅ Evaluation Checklist Compliance
- [x] Secure user registration and login
- [x] JWT-based authentication
- [x] Dashboard Stat Cards (Total, Completed, Pending)
- [x] Full CRUD for tasks (Create, Update, Delete)
- [x] Website Contact Form -> Backend integration
- [x] **Bonus**: Phone Number field in contact form & Mobile app tracking.
- [x] Responsive Landing Page
- [x] Clean, high-end "White + Clear Blue" Theme
