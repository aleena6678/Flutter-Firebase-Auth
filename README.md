# Flutter-Firebase-Auth

A Flutter application demonstrating a complete authentication flow using Firebase Authentication and storing user profile data in Cloud Firestore.

## Features

- **User Registration (Sign Up)**: Users can create an account using their email and password. Additional user data (name and email) is securely saved in a Cloud Firestore `users` collection.
- **User Login**: Returning users can log in using their credentials. Includes form validation and a password visibility toggle.
- **Home Screen**: A protected route only accessible to authenticated users, which greets the user by fetching their personalized name from Firestore.
- **Logout**: Users can securely sign out of the application, taking them back to the login screen.
- **State & Routing**: Navigation is handled smoothly based on authentication state, ensuring unauthorized users cannot access the home screen.

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) (Dart)
- **Backend/BaaS**: [Firebase](https://firebase.google.com/)
- **Authentication**: Firebase Authentication (Email/Password)
- **Database**: Cloud Firestore

## Project Structure

```text
lib/
├── firebase_options.dart  # Auto-generated Firebase configuration (via FlutterFire CLI)
├── login_page.dart        # Login UI and authentication logic
├── main.dart              # App entry point, Firebase init, and Home Screen UI
└── signup.dart            # Registration UI and user data storage logic
```

## Prerequisites

Before you begin, ensure you have met the following requirements:
* You have installed the latest version of [Flutter SDK](https://docs.flutter.dev/get-started/install).
* You have a [Firebase](https://console.firebase.google.com/) account and project set up.
* You have installed the [Firebase CLI](https://firebase.google.com/docs/cli) and [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup).

## Getting Started

Follow these steps to get the project up and running on your local machine:

### 1. Clone the repository

```bash
git clone https://github.com/your-username/your-repo-name.git
cd flutter-firebase-auth
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

Since this project relies on Firebase backend services, you need to connect it to your own Firebase project.

1. Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.
2. Enable **Authentication** and add the **Email/Password** sign-in provider.
3. Enable **Firestore Database** and set up the security rules. For development, you can start in test mode.
4. Open your terminal at the root of the project and run the FlutterFire configuration command to generate the `lib/firebase_options.dart` file:

```bash
flutterfire configure
```

### 4. Run the App

You can now run the app on your preferred emulator (Android/iOS) or physical device:

```bash
flutter run
```

## License

This project is open-source and available under the [MIT License](LICENSE).
