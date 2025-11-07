# AR Museum App

Flutter-based **museum companion app** that enhances the visitor experience with rich multimedia content and (future) AR experiences around selected exhibits.

The app is part of a final-year academic project and is designed to be used on-site in a physical museum as a guided companion on the visitor’s phone.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Running the App](#running-the-app)
- [Configuration](#configuration)
- [AR / Content Integration](#ar--content-integration)
- [Future Improvements](#future-improvements)

---

## Project Overview

The **AR Museum App** is a mobile application built with **Flutter** that aims to:

- Help visitors explore museum exhibits in an intuitive way.
- Present additional information (text, images, video, links) for each artifact.
- Serve as a foundation for integrating **Augmented Reality (AR)** experiences on top of physical exhibits (for example, 3D models, timelines, or contextual stories).

The repository focuses on the **Flutter client** – UI, navigation, and content display – and can be connected to an external AR engine or backend API depending on the deployment.

---

## Features

Current app features focus on the museum visitor journey and a clean, mobile-friendly UI:

- **Home screen**
  - Entry point to the app with quick access to main sections (exhibits, map/about, settings).

- **Exhibit list**
  - Scrollable list of exhibits.
  - Each item can show a title, thumbnail, and short description (depending on the data you load).

- **Exhibit details**
  - Dedicated screen per artifact with more detailed information.
  - Space for historical context, images, and additional resources.

- **(Planned) AR view integration**
  - For specific exhibits, the app is designed to support launching an AR view (via AR-capable plugins or an external AR app/scene).
  - This repository provides the Flutter side; the concrete AR implementation can be plugged in later.

- **Multi-platform support**
  - Flutter project set up for:
    - **Android**
    - **iOS**
    - **Web** (for simple demo/preview of the UI)

---

## Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **Platforms:** Android, iOS, Web
- **UI:** Material Design components + custom theming
- **Assets:** Configurable via `assets/` and `pubspec.yaml`

---

## Project Structure

At a high level:

```text
.
├── android/           # Android-specific project files
├── ios/               # iOS-specific project files
├── web/               # Web support for Flutter
├── assets/            # Images, icons, and other static assets
├── lib/               # Main Flutter application source code
│   └── main.dart      # App entry point
├── test/              # Flutter widget/unit tests
├── pubspec.yaml       # Flutter/Dart dependencies and asset configuration
└── README.md          # Project documentation (this file)


Inside lib/ you will typically have:

main.dart – sets up the root MaterialApp / CupertinoApp, routes, and theme.

Additional Dart files for:

Screens (e.g., home, exhibits list, exhibit details).

Widgets (cards, buttons, layout).

Models / data structures (for exhibits and museum content).

Getting Started
Prerequisites

Make sure you have:

Flutter SDK installed
Follow the official docs: https://docs.flutter.dev/get-started/install

Android Studio or VS Code with Flutter/Dart plugins (recommended).

For iOS development:

macOS with Xcode installed.

Verify Flutter is installed correctly:

flutter doctor


Fix any issues that flutter doctor reports (especially for the platform you target).

Running the App
1. Clone the repository
git clone https://github.com/omer5628/ar_museum_app.git
cd ar_museum_app

2. Install dependencies
flutter pub get

3. Run on an emulator / device

Android:

Start an Android emulator (or connect an Android device with USB debugging).

Run:

flutter run


iOS (on macOS):

Open an iOS Simulator from Xcode or open -a Simulator.

Run:

flutter run


Web (for UI preview):

Enable web if needed:

flutter config --enable-web
flutter run -d chrome

Configuration

Common configuration points:

Assets

Add images/icons/content into the assets/ directory.

Make sure they are referenced in pubspec.yaml:

flutter:
  assets:
    - assets/images/
    # - assets/data/exhibits.json


Exhibit data

You can store exhibit metadata locally (e.g., JSON in assets/data/) or load it from a backend API.

The app can be adapted so that exhibit list + details are driven by this data.

App name / icon

Change the app name in:

android/app/src/main/AndroidManifest.xml

ios/Runner/Info.plist

Configure launcher icons via packages like flutter_launcher_icons if you want a custom museum icon.

AR / Content Integration

This Flutter app is meant to be the front-end of an AR museum experience. AR can be integrated in several ways (depending on your chosen tools):

Using a Flutter AR plugin (e.g., ARCore/ARKit wrapper).

Opening a separate AR app or Unity-built AR experience via:

Deep links / URL schemes.

Platform channels (Android/iOS native bridge).

Embedding a WebView that shows a web-based AR experience (for compatible browsers/devices).

Typical flow for an exhibit that supports AR:

User opens an exhibit in the app.

Exhibit details screen shows a “View in AR” button.

The button triggers AR logic (plugin, native code, or external app).

This repository gives you the Flutter structure to build those screens and trigger AR; the low-level AR implementation can be swapped in without changing the high-level UI flow.

Future Improvements

Some directions to extend this project:

Full AR integration

Add real AR scenes for selected exhibits (3D models, animations, overlays).

Indoor navigation

Simple map of the museum with “you are here” and route suggestions.

Guided tours

Predefined tours (e.g., “Highlights”, “Kids tour”, “WWII section”) with a sequence of exhibits.

Multilingual support

Add localization (Hebrew, English, etc.) using Flutter’s intl package.

Backend integration

Connect to a backend service for:

Dynamic content updates.

Analytics of visitor paths and exhibit popularity.

Accessibility

Add larger fonts, high-contrast themes, audio narration per exhibit.
