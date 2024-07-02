# Flutter Clean Architecture with BLoC and TDD

Welcome to the **Flutter Clean Architecture with BLoC and TDD** repository! This project provides an in-depth guide to implementing Clean Architecture using the BLoC pattern and Test-Driven Development (TDD) in Flutter. It's designed to help developers build scalable, maintainable, and testable Flutter applications.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Running Tests](#running-tests)
- [Contributing](#contributing)
- [License](#license)

## Features

### Main Features
- **Social Login**: Seamless authentication with social media accounts.
- **View Course**: Browse and view available courses effortlessly.
- **Join Group Chat**: Engage in real-time group conversations.
- **Auto Create Group Chat**: Automatically create group chats.
- **Leave Group Chat**: Exit group chats easily.
- **Upload Video from Admin Section**: Admins can upload videos for courses.
- **Play Video from Local Storage**: Smooth video playback from local storage.
- **Profile Center**: Create, update, and delete profiles with images.
- **Receive Notifications**: Stay updated with push notifications.
- **Clear Notifications**: Manage and clear notifications.
- **Onboarding Screen**: Smooth onboarding experience for new users.
- **Firebase Integration**: Robust backend support with Firebase.
- **Admin Panel**: Comprehensive admin management features.
- **Upload Exam**: Facilitate exam uploads for courses.

### Architecture Features
- **Domain Layer**: Central business logic and entities.
- **Data Layer**: Efficient data management and repositories.
- **Presentation Layer**: Clear and responsive UI.
- **TDD**: Ensuring quality and reliability through rigorous testing.

## Architecture

This project follows the Clean Architecture principles to ensure a scalable and maintainable codebase. Here's a brief overview of the architecture layers:

- **Domain Layer**: Contains the business logic, use cases, and entities.
- **Data Layer**: Manages data sources, repositories, and data models.
- **Presentation Layer**: Handles the UI, state management (BLoC), and presentation logic.

## Getting Started

### Prerequisites

Before you begin, ensure you have met the following requirements:

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Firebase Account: [Set up Firebase](https://firebase.google.com/)

### Installation

1. Clone the repository:
   ```sh
   git clone [https://github.com/FranklinBMW/tdd_clean_arch]
   ```
2. Navigate to the project directory:
   ```sh
   cd flutter-clean-architecture-tdd
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```

### Firebase Configuration

1. Create a Firebase project and add your Flutter app.
2. Download the `google-services.json` file and place it in the `android/app` directory.
3. Follow the [Firebase setup guide](https://firebase.google.com/docs/flutter/setup) to complete the configuration.

## Project Structure

```
lib/
├── data/
│   ├── models/
│   ├── repositories/
│   └── sources/
├── domain/
│   ├── entities/
│   ├── usecases/
│   └── repositories/
├── presentation/
│   ├── blocs/
│   ├── pages/
│   └── widgets/
├── main.dart
test/
├── data/
├── domain/
├── presentation/
└── test_helper.dart
```

- **data**: Contains data models, repositories, and data sources.
- **domain**: Contains entities, use cases, and repository interfaces.
- **presentation**: Contains BLoC, pages, and widgets for the UI.
- **main.dart**: Entry point of the application.
- **test**: Contains unit and widget tests.

## Running Tests

To ensure the code quality and reliability, this project follows Test-Driven Development (TDD). Run the tests using the following command:

```sh
flutter test
```

## Contributing

Contributions are always welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a Pull Request.

Please make sure your code follows the [coding standards](https://flutter.dev/docs/development/tools/formatting) and includes relevant tests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Thank you for exploring this repository! If you have any questions or feedback, feel free to reach out. Let's build something amazing together! 🚀
