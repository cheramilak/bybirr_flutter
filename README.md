# ByBirr Flutter

A comprehensive Flutter mobile application for digital banking and financial services, featuring virtual cards, KYC verification, and secure authentication.

## 🚀 Project Overview

ByBirr Flutter is a modern, feature-rich mobile banking application built with Flutter that provides users with a secure and intuitive platform for managing their financial activities. The app includes virtual card management, KYC verification, blog/news features, and a comprehensive dashboard.

## ✨ Features

### 🔐 Authentication & Security
- **User Registration & Login**: Secure authentication system with email verification
- **Password Management**: Change password and password reset functionality
- **OTP Verification**: Two-factor authentication for enhanced security
- **Secure Storage**: Encrypted local storage for sensitive data

### 💳 Virtual Card Management
- **Virtual Card Creation**: Order and manage virtual cards
- **Card Details**: View comprehensive card information including balance, expiry, and CVV
- **Payment Processing**: Secure payment gateway integration
- **Transaction History**: Track all card transactions

### 🆔 KYC Verification
- **Multi-step Verification**: Comprehensive KYC process
- **Document Upload**: ID verification and address proof
- **Form Validation**: Robust form handling with validation
- **Verification Status**: Real-time KYC status tracking

### 📱 User Interface
- **Modern Design**: Clean, intuitive Material Design interface
- **Dark/Light Theme**: Customizable theme support with smooth transitions
- **Responsive Layout**: Optimized for various screen sizes
- **Lottie Animations**: Engaging loading and success animations

### 📊 Dashboard & Analytics
- **Home Screen**: Overview of cards, balance, and quick actions
- **Blog Section**: News and updates from the platform
- **Profile Management**: User profile and settings
- **Navigation**: Bottom navigation with smooth transitions

## 🏗️ Architecture

### State Management
- **Provider Pattern**: Clean state management using Provider package
- **Separation of Concerns**: Organized providers for different features
- **Reactive UI**: Real-time UI updates based on state changes

### Project Structure
```
lib/
├── core/           # Core utilities, themes, and configurations
├── models/         # Data models and DTOs
├── page/           # UI screens and pages
│   ├── auth/       # Authentication screens
│   ├── blog/       # Blog and news screens
│   ├── card/       # Virtual card management
│   ├── dashboard/  # Main dashboard
│   ├── home/       # Home screen
│   ├── kyc/        # KYC verification
│   └── profile/    # User profile
├── providers/      # State management providers
└── utils/          # Utility functions and styles
```

### Key Dependencies
- **Provider**: State management
- **Dio**: HTTP client for API communication
- **Flutter Secure Storage**: Secure local data storage
- **Lottie**: Animation support
- **Google Fonts**: Typography
- **Flex Color Scheme**: Theme management
- **Image Picker**: Photo selection
- **Shimmer**: Loading animations

## 🛠️ Setup & Installation

### Prerequisites
- Flutter SDK (^3.9.0)
- Dart SDK
- Android Studio / VS Code
- Android SDK (API level 21+)
- iOS SDK (for iOS development)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/bybirr_flutter.git
   cd bybirr_flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### Android
- Ensure Android SDK is properly configured
- Update `android/app/build.gradle.kts` with your application details
- Configure signing keys for release builds

#### iOS
- Install Xcode and iOS SDK
- Update `ios/Runner/Info.plist` with required permissions
- Configure signing and capabilities

## 🔧 Configuration

### Environment Variables
Create a `.env` file in the root directory:
```env
API_BASE_URL=your_api_base_url
API_KEY=your_api_key
```

### API Configuration
Update `lib/core/endpoint.dart` with your API endpoints:
```dart
class Endpoint {
  static const String baseUrl = 'your_base_url';
  static const String apiVersion = 'v1';
  // ... other endpoints
}
```

## 📱 Screenshots

The application includes the following key screens:
- **Splash & Introduction**: Welcome screens with app overview
- **Authentication**: Login, signup, and verification screens
- **Dashboard**: Main navigation hub
- **Home**: Card overview and quick actions
- **Virtual Cards**: Card management and details
- **KYC**: Verification process screens
- **Profile**: User settings and information

## 🚀 Building for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS Archive
```bash
flutter build ios --release
```

## 🧪 Testing

Run tests using:
```bash
flutter test
```

## 📦 Dependencies

### Core Dependencies
- `flutter`: ^3.9.0
- `provider`: ^6.1.5
- `dio`: ^5.9.0
- `flutter_secure_storage`: ^9.2.4
- `lottie`: ^3.3.1

### UI Dependencies
- `google_fonts`: ^6.3.0
- `flex_color_scheme`: ^8.3.0
- `shimmer`: ^3.0.0
- `awesome_snackbar_content`: ^0.1.8

### Utility Dependencies
- `intl`: ^0.20.2
- `cached_network_image`: ^3.4.1
- `image_picker`: ^1.2.0
- `nb_utils`: ^7.1.7+2

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- Create an issue in the GitHub repository
- Contact the development team
- Check the documentation

## 🔮 Roadmap

- [ ] Push notifications
- [ ] Biometric authentication
- [ ] Multi-language support
- [ ] Advanced analytics dashboard
- [ ] Integration with more payment gateways
- [ ] Offline mode support

---

**Built with ❤️ using Flutter**
