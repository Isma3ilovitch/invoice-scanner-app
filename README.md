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
