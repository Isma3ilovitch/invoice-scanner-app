# 📱 Invoice Scanner App

A Flutter app that lets you scan invoices using **Google ML Kit** for text recognition and store data locally with **Hive**.

---

## 🚀 Features
- OCR text extraction from invoices (offline with Google ML Kit).
- Local storage using Hive.
- Add, view, and edit saved invoices.

---

## ⚙️ Prerequisites

Before running the app, make sure you have:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and added to your PATH.
- [Android Studio](https://developer.android.com/studio) or Android SDK installed.
- An Android device with **Developer Options → USB Debugging** enabled.
- `adb` installed on Linux :
  ```bash
  sudo apt update
  sudo apt install adb
Here’s the content formatted in Markdown ready to paste into your README.md:

📲 **Running the App on Android (via USB)**

1. **Clone the repository**

   ```bash
   git clone https://github.com/<your-username>/invoice-scanner-app.git
   cd invoice-scanner-app
Get Flutter dependencies

flutter pub get
Connect your Android device via USB

Enable Developer Mode and USB Debugging on your phone.

Verify the device is detected:

adb devices
You should see your device listed.

Run the app

flutter run -d <device_id>
or, if only one device is connected:

flutter run
🛠 Troubleshooting
No supported devices connected
Run:

flutter devices
to confirm your phone is detected.

Gradle build is very slow
The first run downloads Android dependencies — be patient. Subsequent runs will be faster.

Error: missing invoice_model.g.dart
Regenerate Hive adapters with:

flutter pub run build_runner build --delete-conflicting-outputs
App not installing on phone
Ensure your phone is unlocked and the “Allow USB Debugging” prompt is accepted.
