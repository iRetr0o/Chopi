# Chopi 🛒
Simple iOS application for managing shopping lists.
It allows users to create lists, add products and keep track of purchased items.

This project was built as part of a personal learning process to practice modern iOS development using SwiftUI and MVVM architecture.

---

## ✨ Features

* Create shopping lists
* Edit and delete lists
* Add items to a list
* Mark items as purchased
* Update item status
* Persistent local storage
* Clean and responsive UI

---

## 🧱 Architecture

The app follows the **MVVM (Model–View–ViewModel)** architecture pattern to ensure separation of concerns and better testability.

```
View
 ↓
ViewModel
 ↓
Service
 ↓
Persistence Layer
```

**Responsibilities**

* **Views** → UI built with SwiftUI
* **ViewModels** → Presentation logic and state management
* **Services** → Data access and persistence
* **Models** → Domain entities

---

## 🛠 Tech Stack

* Swift
* SwiftUI
* MVVM Architecture
* Async/Await Concurrency
* XCTest for unit testing

---

## 🧪 Testing

The project includes unit tests for key application logic:

* ViewModels
* Data services
* Business logic

SwiftUI views are validated using UI tests.

---

## 📸 Screenshots

| Home       | List Detail | Items      |
| ---------- | ----------- | ---------- |
| ![Home](https://i.imgur.com/ARJNs30.png) | ![List Detail](https://i.imgur.com/Q3TJZNm.png)  | ![Items](https://i.imgur.com/6vwWNZx.png) |

---

## 🚀 Getting Started

### Clone the repository

```
git clone https://github.com/iretr0o/chopi.git
```

### Open the project

Open the `.xcodeproj` file in Xcode.

### Run the app

Select a simulator or device and run the project.

---

## 📦 Requirements

* Xcode 15+
* iOS 17+
* Swift 5+

---

## 🔮 Future Improvements

Possible future features include:

* Support for additional languages (e.g., English localization)
* UI/UX refinements
* Performance optimizations

---

## 📄 License

This project is licensed under the MIT License.
