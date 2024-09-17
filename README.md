# 📱 GitHub Issue Tracker

Get started with the GitHub Issue Tracker app by downloading the APK file:

<img src="https://camo.githubusercontent.com/b7f07c99e616f1684eac5d7809ab904f90fb250cf5c6b859c49e9f8533b206b3/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f776e6c6f61642d41504b2d677265656e3f7374796c653d666f722d7468652d6261646765266c6f676f3d616e64726f6964" alt="Download APK" data-canonical-src="https://img.shields.io/badge/Download-APK-green?style=for-the-badge&amp;logo=android" style="max-width: 100%;">

*Experience seamless issue tracking and management directly on your device!*

![GitHub Issue Tracker Logo](https://github.com/user-attachments/assets/61c33707-2efa-4664-9ca5-0016ca712c88)


**Track, Search, and Filter GitHub Issues - All in One App!**

---

## ✨ Features

- 🔍 **Issue Tracking**: View and track issues from multiple repositories, with a focus on the [Flutter GitHub repository](https://github.com/flutter/flutter).
- 📝 **Issue Details**: Get detailed information on individual GitHub issues with markdown support for easy readability.
- 🔍 **Search Functionality**: Search for specific issues by title or content from the repository.
- 🎯 **Filtered Issue List**: Display only the issues that don’t include the word "flutter" in their titles.
- 🌙 **Dark Mode Support**: Toggle between light and dark themes for comfortable viewing in different environments.
- 🔐 **Firebase Authentication**: Secure login using Firebase for easy access and user management.
- 🚀 **Smooth Navigation**: Seamlessly navigate between issue lists, details, and search results with smooth transitions.

---

## 🛠️ Technologies Used

- 📱 **Flutter SDK**: (>=3.3.0 <4.0.0)
- 🔄 **GetX**: For state management.
- 🌐 **GitHub API**: For fetching and managing issues from the GitHub repository.
- 🔥 **Firebase**: For user authentication and secure login.
- 🖼️ **Markdown Rendering**: To display issue descriptions with proper formatting.
- 💡 **Lottie Animations**: For engaging and smooth loading animations.

---

## 🚀 Getting Started

### Prerequisites

1. Install [Flutter SDK](https://flutter.dev/docs/get-started/install).
2. Set up a Firebase project for authentication.
3. Obtain a GitHub personal access token for API requests.

### Steps

1. Clone the repository:

    ```bash
    git clone https://github.com/yourusername/github_issue_tracker.git
    ```

2. Navigate to the project directory:

    ```bash
    cd github_issue_tracker
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

4. Set up environment variables in `.env` file:

    ```plaintext
    GITHUB_API_TOKEN=your_github_token
    FIREBASE_API_KEY=your_firebase_api_key
    ```

5. Run the app:

    ```bash
    flutter run
    ```

---

## 📦 Dependencies

| Package                          | Purpose                                      |
| --------------------------------- | -------------------------------------------- |
| `get`                             | 🔄 State management using GetX               |
| `http`                            | 🌐 HTTP requests for GitHub API              |
| `firebase_auth`, `firebase_core`  | 🔐 Firebase Authentication                   |
| `flutter_markdown`                | 📝 Markdown rendering for issue details      |
| `loading_animation_widget`        | 💫 Lottie animations for loading indicators  |
| `shared_preferences`              | 💾 Storing local data (e.g., user sessions)  |
| `connectivity_plus`               | 🌐 Check network connectivity                |

For a full list of dependencies, refer to the `pubspec.yaml` file.

---

## ⚙️ Configuration

1. **Firebase**: Set up Firebase and download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS), and place them in the respective directories.

2. **GitHub API**: Set up a GitHub Personal Access Token and add it to the `.env` file as `GITHUB_API_TOKEN`.

3. **Dark/Light Mode**: Ensure you have both themes implemented in your `theme.dart` file for seamless switching between dark and light modes.

---

## 🌟 Bonus Features

- **Unidirectional Data Flow**: Implemented a single source of truth for state management using the GetX controller.
- **Pixel-Perfect UI**: Carefully designed the UI to match the Figma designs for an optimal user experience.
- **Error Handling**: Implemented error handling for network failures, invalid inputs, and other edge cases.

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch:

    ```bash
    git checkout -b feature-branch
    ```

3. Make your changes and commit them:

    ```bash
    git commit -m "Add new feature"
    ```

4. Push to the branch:

    ```bash
    git push origin feature-branch
    ```

5. Open a Pull Request and describe the changes.

---

## 🙏 Acknowledgements

- **Flutter**: For providing a robust and flexible mobile development framework.
- **GitHub API**: For enabling seamless integration with GitHub issues.
- **Firebase**: For authentication services.

---

## 📞 Contact

For any queries or suggestions, feel free to [open an issue](https://github.com/yourusername/github_issue_tracker/issues).

---

## 📹 Demo Video

Check out the short demo video of the GitHub Issue Tracker app: [Demo Video](https://youtube.com/demo-link).
