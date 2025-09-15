# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is a Flutter application for securely storing debit/credit card details locally on the user's phone. The app is password-protected and provides secure access to card information with additional security layers for viewing sensitive data like PIN/CVV.

## Common Development Commands

### Flutter Development
- **Install dependencies**: `flutter pub get`
- **Run the app**: `flutter run`
- **Run on specific device**: `flutter run -d <device_id>`
- **Build APK**: `flutter build apk`
- **Build iOS**: `flutter build ios`
- **Run tests**: `flutter test`
- **Run a specific test**: `flutter test test/widget_test.dart`
- **Clean build cache**: `flutter clean`
- **Analyze code**: `flutter analyze`

### Code Generation (Hive)
- **Generate Hive adapters**: `flutter packages pub run build_runner build`
- **Watch for changes**: `flutter packages pub run build_runner watch`
- **Force rebuild**: `flutter packages pub run build_runner build --delete-conflicting-outputs`

### Development Tools
- **Hot reload**: Press `r` in the terminal while app is running
- **Hot restart**: Press `R` in the terminal while app is running
- **Toggle inspector**: Press `i` in the terminal while app is running

## Code Architecture

### Data Storage Layer (Hive Database)
The app uses Hive as a local NoSQL database for persistent storage:

- **Box Management**: `lib/Box/boxWallet.dart` - Defines the global Hive box instance
- **Data Models**: `lib/hive_adapters/WalletAdapter.dart` - Card data model with Hive type annotations
- **Generated Adapters**: `lib/hive_adapters/WalletAdapter.g.dart` - Auto-generated Hive adapter (don't edit manually)

### State Management (Provider Pattern)
The app uses Provider for state management:

- **Providers**: Located in `lib/providers/`
- **Add Wallet Provider**: `add_wallet_provider.dart` - Manages form state for adding new cards
- **Global State**: Registered in `main.dart` using `MultiProvider`

### UI Layer Structure
The app follows a screen-based architecture:

- **Screens**: Located in `lib/ui/screens/`
  - `home_page.dart` - Main screen showing card list and empty state
  - `add_wallet_screen.dart` - Form for adding new card details
  - `wallet_screen.dart` - Individual card details view with copy functionality
- **Navigation**: Handled using named routes in `main.dart`

### App Initialization Flow
1. **Main Entry**: `main.dart` initializes Hive database
2. **Database Setup**: Registers `WalletAdapter` and opens `walletBox`
3. **UI Setup**: Configures MaterialApp with routes and providers
4. **System UI**: Sets transparent status bar

### Key Architectural Patterns

#### Local Data Storage
- All card data is stored locally using Hive database
- No network calls or cloud storage
- Data persists between app launches

#### Security Considerations
- Local storage only (as per README requirements)
- Copy-to-clipboard functionality for easy access to card details
- Delete confirmation dialogs for destructive actions

#### Form Validation
- Text field validation in add wallet screen
- Required field checking before database storage
- Global form key management

### Platform Support
The app is set up for multi-platform deployment:
- **Android**: `android/` directory
- **iOS**: `ios/` directory  
- **macOS**: `macos/` directory
- **Linux**: `linux/` directory
- **Windows**: `windows/` directory
- **Web**: `web/` directory

### Dependencies Overview
- **flutter**: Framework
- **hive** & **hive_flutter**: Local database
- **provider**: State management
- **cupertino_icons**: iOS-style icons
- **build_runner** & **hive_generator**: Code generation for Hive adapters

### Development Workflow Notes
- Use `build_runner` to regenerate Hive adapters when modifying the `WalletAdapter` class
- The app expects card numbers to be integers (consider validation for real card numbers)
- Form controllers are properly disposed to prevent memory leaks
- Navigation uses both named routes and direct MaterialPageRoute navigation
