# 🏦 SecureFinance

**SecureFinance** is a modern, production-grade iOS Banking & Insurance application built with **SwiftUI** and **MVVM Architecture**. 

It demonstrates advanced iOS concepts including optimistic UI updates, secure keychain storage, asynchronous networking with error handling, and domain-driven form validation.

## 📱 Features

### 🔐 Security & Onboarding
* **Secure Login:** Mock authentication flow storing session tokens in **Keychain Services**.
* **Persistence:** Auto-login on app launch if a valid token exists.
* **Privacy Mode:** Toggle to hide/unhide sensitive account balances (`****.**`).

### 💸 Banking Module
* **Dashboard:** Real-time view of Account Balance, Policies, and Recent Transactions.
* **Money Transfer:** * Form validation (Account Number, Positive Amounts).
    * **Optimistic UI:** Instant balance updates with automatic rollback on network failure.
    * **Mock Backend:** Simulates network latency and server errors.
* **Loan Application:**
    * Dynamic risk assessment logic.
    * Blocks applications > 200k INR if the user has existing EMIs.

### 📜 History & Data
* **Transaction List:** High-performance `LazyVStack` list handling infinite scrolling.
* **Visual Indicators:** Color-coded credits (Green) and debits (Red).

---

## 🏗 Architecture

The app follows a strict **MVVM (Model-View-ViewModel)** design pattern with a separate Service Layer.

* **Models:** Pure data structs (`Account`, `Transaction`, `Policy`) conforming to `Codable` and `Identifiable`.
* **ViewModels:** MainActor-isolated classes managing state (`@Published`), business logic, and error handling.
* **Views:** Dumb UI components that react to ViewModel state changes.
* **Services:** Singleton layers handling "Network" calls and Data Persistence.

### Folder Structure
```text
SecureFinance/
├── App/                # Entry point (@main)
├── Models/             # Data structures
├── ViewModels/         # Logic & State Management
├── Views/              # Screens (Dashboard, Login, Transfer)
├── Components/         # Reusable UI (Cards, Rows)
└── Services/           # Networking & Keychain
