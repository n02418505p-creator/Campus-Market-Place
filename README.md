# NUST Campus Store

## 📱 Project Overview

NUST Campus Store is a Flutter-based e-commerce mobile application designed for students of the National University of Science and Technology (NUST), Zimbabwe. The app allows students to browse, search, and purchase campus-related merchandise including bags, clothing, stationery, food items, electronics, graduation regalia, and more.

---

## 👥 Team Members

| # | Name | Student ID | Role |
|---|------|------------|------|
| 1 | Takudzwa Murombedzi | N02418505P | Team Lead, Login & Profile Screens |
| 2 | Owen K. Murewa | N02419341C | Registration & Admin Dashboard |
| 3 | Denzel Joe | N0242776H | Home Screen & Cart Service |
| 4 | Collins Nyamandu | N02424587C | Products Screen & Product Image Widget |
| 5 | Buhlebenkosi Ncube | N02428404M | Cart Screen |
| 6 | Blessings Hoto | N02423763T | Checkout Screen |
| 7 | Caroline T. Maposa | N02424514M | Product Model & Add Product Screen |
| 8 | Sean Ncube | N02426665X | User Model & Database Service |
| 9 | Tinoidaishe Mwenga | N02422373H | Cart Item Model & Add Users Screen |
| 10 | Kundai Rato | N02423683W | Order Model & Auth Service |

---

## 🏗️ Architecture

### MVC (Model-View-Controller) Pattern

```
┌─────────────────────────────────────────────────────────────┐
│                      PRESENTATION LAYER                      │
│  (Screens: Login, Home, Products, Cart, Profile, Admin)     │
├─────────────────────────────────────────────────────────────┤
│                       BUSINESS LAYER                         │
│  (Services: AuthService, CartService, DatabaseService)      │
├─────────────────────────────────────────────────────────────┤
│                         DATA LAYER                           │
│  (Models: Product, User, CartItem, Order)                   │
├─────────────────────────────────────────────────────────────┤
│                      DATABASE LAYER                          │
│  (SQLite / In-Memory Storage)                               │
└─────────────────────────────────────────────────────────────┘
```

### Why MVC?
- **Separation of Concerns**: Each layer has a single responsibility
- **Testability**: Business logic can be tested independently
- **Maintainability**: Easy to update one layer without affecting others
- **Scalability**: Can switch from local to cloud database easily

---

## 🎨 Color Theme

| Color Name | Hex Code | Usage |
|------------|----------|-------|
| Teal/Cyan | `#17A2B8` | AppBar, Headers, Primary elements |
| Button Blue | `#1E88E5` | Interactive buttons |
| Deep Blue | `#0B3C5D` | Text headings, icons |
| Light Gray | `#EDEDED` | Background |
| Input Border | `#D3D3D3` | Text field borders |
| Focus Border | `#6EA8FE` | Input field focus state |
| White | `#FFFFFF` | Cards, surfaces |

### Font: Roboto
- Clean, modern, highly readable on all screen sizes
- Default Material Design font
- Excellent legibility for product names and prices

---

## 👥 Stakeholders

| Stakeholder | Role | Needs |
|-------------|------|-------|
| **Students** | Buyers & Sellers | Easy browsing, secure checkout, student-friendly prices |
| **Admin** | Platform Manager | Product management, order tracking, user oversight |
| **University (NUST)** | Institution | Safe campus commerce, student engagement |
| **Lecturers** | Course advisors | Textbook availability for courses |
| **Graduating Students** | Urgent sellers | Quick sales before leaving campus |

---

## ✨ Features

### Student Features
- User Registration & Login
- Browse Products by Category
- Search Products
- Add to Cart
- Checkout Process
- View Order History
- Update Profile

### Admin Features
- Admin Dashboard
- Add New Products
- Delete Products
- View All Orders
- Delete Orders
- User Management (30+ users)

### Technical Features
- Responsive Design
- Category Filtering
- Search Functionality
- Cart Management
- Order Processing
- Persistent Storage (Android/Windows)

---

## 📋 User Accounts

### Admin Account
| Username | Password |
|----------|----------|
| `admin` | `admin123` |

### Student Accounts (10 classmates)

| Username | Password |
|----------|----------|
| Buhlebenkosi | N02428404M |
| Collins | N02424587C |
| Denzel | N0242776H |
| Blessings | N02423763T |
| Kundai | N02423683W |
| Owen | N02419341C |
| Tinoidaishe | N02422373H |
| Caroline | N02424514M |
| Sean | N02426665X |
| Takudzwa | N02418505P |

### Additional Students (20 users)
- Usernames: Tanaka, Rutendo, Kudakwashe, Tafadzwa, Munashe, Anotida, Tinashe, Rumbidzai, Nyasha, Makanaka, Tawananyasha, Panashe, Ruvimbo, Tadiwanashe, Tanyaradzwa, Mufaro, Ropafadzo, Kudzai, Tendai, Chipo
- Passwords: NUST2024001 - NUST2024020

**Total Users: 31 (1 Admin + 30 Students)**

---

## 🛍️ Products

| Category | Examples |
|----------|----------|
| Bags | Leather Satchel, Canvas Backpack, Dorm Essentials |
| Clothing | NUST Cap, Scarf, T-Shirt, Hoodie, Sweater |
| Stationery | Pen Set, Diary, Notebook, Office Supplies |
| Food | Biscuits, Chips, Chocolates |
| Drinks | Juice, Fizzy Drink, Coffee Mug |
| Electronics | Laptop, Tech Accessories |
| Graduation | Graduation Gown |
| Accessories | Keychain Set |
| Souvenirs | NUST Souvenirs |
| Books | Textbooks Set |

**Total Products: 25**

---

## 🛠️ Technology Stack

| Technology | Purpose |
|------------|---------|
| Flutter | Frontend framework |
| Dart | Programming language |
| Provider | State management |
| SQLite / In-Memory | Database |
| SharedPreferences | Local storage |
| Material Design | UI components |

---

## 📱 Installation

### Prerequisites
- Flutter SDK installed
- Android Studio / VS Code
- Android SDK for APK build

### Steps

1. **Clone or extract the project**
```bash
cd Campus-Market-Place
```

2. **Get dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
# For Chrome (Web)
flutter run -d chrome

# For Windows
flutter run -d windows

# For Android (with device connected)
flutter run
```

4. **Build APK for Android**
```bash
flutter build apk --release
```
APK location: `build/app/outputs/flutter-apk/app-release.apk`

---

## 📁 Project Structure

```
Campus-Market-Place/
├── RESULTS/
│   ├── screenshots/          # 12 screenshots for submission
│   ├── app-release.apk       # Release APK file
│   ├── DOCUMENTATION.md      # Project documentation
│   └── PRESENTATION_SLIDES.md # Presentation guide
├── assets/
│   └── images/               # 27 product images
├── lib/
│   ├── main.dart
│   ├── models/               # Product, User, CartItem, Order
│   ├── screens/              # 9 main screens + 3 admin screens
│   ├── services/             # Auth, Database, Cart services
│   └── widgets/              # ProductImage widget
├── pubspec.yaml
└── README.md
```

---

## 🧪 Testing Credentials

| Role | Username | Password |
|------|----------|----------|
| Admin | `admin` | `admin123` |
| Student | `Takudzwa` | `N02418505P` |
| Student | `Owen` | `N02419341C` |

---

## 📸 Screenshots

Screenshots are available in the `RESULTS/screenshots/` folder:

1. Login Screen
2. Register Screen
3. Home Screen
4. Products Screen
5. Category Filter
6. Cart Screen
7. Checkout Screen
8. Order Confirmation
9. Profile Screen
10. Admin Dashboard
11. Add Product
12. User Management

---

## 🚀 Future Improvements

- Add payment gateway integration
- Implement real-time chat between buyers and sellers
- Add product rating and review system
- Push notifications for order updates
- Google Maps integration for meetup locations
- PDF receipt generation

---

## 📄 License

This project was developed for academic purposes at the National University of Science and Technology (NUST), Zimbabwe.

---

## 🙏 Acknowledgements

- National University of Science and Technology
- Software Engineering Department
- All team members for their contributions

---

## 📞 Contact

For any inquiries, please contact the team lead:
- **Name**: Takudzwa Murombedzi
- **Student ID**: N02418505P
- **Email**: takudzwamurombedzi34@gmail.com

OR Assistant Team Lead:
- **Name**: Owen K. Murerwa
- **Student ID**: N02419341C
- **Email**: owenkupakwashe@gmail.com
---

**© 2026 NUST Campus Store - All Rights Reserved**
```
