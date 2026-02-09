# Kathakaar — Minimalist Poetry App

A calm, minimalist, multilingual poetry-sharing Android app that feels like a personal poetry journal + community library. Built with Flutter.

## 📱 Features

- **Minimalist Design**: Typography-first, distraction-free reading experience.
- **Multilingual Support**: Read and write poems in Hindi, English, Hinglish, Urdu.
- **Write & Publish**: Simple editor with tag support.
- **Community**: Like, comment, and save poems.
- **Profile**: Showcase your work and bio.

## 🛠️ Tech Stack

- **Frontend**: Flutter (Dart)
- **State Management**: Provider
- **Backend Architecture**: Repository Pattern (Supports Mock & Firebase)
- **Authentication**: Google Sign-In (Ready for integration)
- **Database**: Firestore (Ready for integration)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- Android Studio / VS Code

### Run the App

1.  **Clone the repository**.
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run the app**:
    ```bash
    flutter run
    ```
    *Note: By default, the app runs with **Mock Data** so you can explore the UI and flow immediately without Firebase configuration.*

## 🔥 Firebase Integration

To switch from Mock data to real Firebase backend:

1.  **Create a Firebase Project** in the [Firebase Console](https://console.firebase.google.com/).
2.  **Add an Android App** to the project with package name `com.kathakaar.app`.
3.  **Download `google-services.json`** and place it in `android/app/`.
4.  **Enable Authentication**:
    - Go to Authentication > Sign-in method.
    - Enable **Google**.
5.  **Enable Firestore**:
    - Create a Cloud Firestore database.
    - Set up security rules.
6.  **Update Code**:
    - Open `lib/main.dart`.
    - Uncomment the Firebase initialization code (you need to add `await Firebase.initializeApp();` in `main()`).
    - Change the repository initialization:
      ```dart
      // Replace these lines
      final authRepository = MockAuthRepository();
      final poemRepository = MockPoemRepository();

      // With real implementations (you need to create FirebaseAuthRepository and FirestorePoemRepository implementing the interfaces)
      // final authRepository = FirebaseAuthRepository();
      // final poemRepository = FirestorePoemRepository();
      ```
    - *Note*: You will need to implement `FirebaseAuthRepository` and `FirestorePoemRepository` using the `firebase_auth` and `cloud_firestore` packages, following the `AuthRepository` and `PoemRepository` interfaces.

## 🎨 Design System

- **Fonts**: Playfair Display (Headlines), IBM Plex Serif (Body).
- **Colors**:
  - Background: `#FAFAFA`
  - Text: `#0F0F0F`
  - Accent: `#B3001B`

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
