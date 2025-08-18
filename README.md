# Thmanyah iOS App Architecture

## Overview

This repository demonstrates the architecture of the **Thmanyah iOS Application**. It is designed using **Clean Architecture** principles and modularized into **Swift Packages (SP)**. Each core component exists in a separate package to ensure high reusability, testability, and maintainability. This approach enhances the flexibility of the system by isolating concerns into distinct modules that can evolve independently.

## Table of Contents

* [Overview](#overview)
* [Architecture Overview](#architecture-overview)
* [High-Level Design](#high-level-design)
* [Layers](#layers)
  * [Domain Layer](#domain-layer)
  * [Data Layer](#data-layer)
  * [Presentation Layer](#presentation-layer)
* [Components](#components)
* [Deep Dive: Home Feed Flow](#deep-dive-home-feed-flow)
* [Technology Stack](#technology-stack)
* [Setup](#setup)
* [Features](#features)

## Architecture Overview

Our architecture adheres to Clean Architecture principles, organized in layers that decouple responsibilities to improve testability and maintainability. The structure enables easy modifications, whether for business rules, UI updates, or changes in external data sources.

## High-Level Design

The architecture is divided into several components:

* **App Module:** The root module responsible for initializing and coordinating various flows across the application.
* **Coordinator:** Manages the navigation between different screens and orchestrates the flow of data.
* **Image Loader:** Handles image loading and caching using SwiftUI's AsyncImage.
* **Use Cases:** Contain business logic and are responsible for orchestrating data between the repository and the domain layer.
* **Repository:** Acts as a mediator between the data sources (API, database) and the use cases.
* **API Service:** Fetches data from the backend using URLSession.
* **Dependency Injection:** Manages dependencies using a custom DIContainer for better testability.

![Thmanyah Design Architecture]()
![Thmanyah Design Architecture Interview]()

## Layers

### Domain Layer

* **Entities:** These represent the core business objects, such as `Podcast`, `Episode`, `AudioBook`, `AudioArticle`, and `FeedSection`.
* **Use Cases:** These are the application-specific rules that govern how the app interacts with the repository layer. They retrieve and manipulate data from repositories and provide it to the presentation layer.

### Data Layer

* **Repository:** Manages communication between the local data and remote sources (REST APIs). The repository abstracts this complexity from the use cases.
* **Network Layer:** Built using URLSession, this layer interacts with the backend API, fetching data or sending updates.
* **Persistence:** Stores data locally, ensuring data is available offline and for faster access.

### Presentation Layer

* **ViewModel:** Manages the presentation logic and provides data from the use cases to the UI components.
* **Views:** SwiftUI views are responsible for rendering the UI and listening to state changes in the ViewModel.

## Components

The application is structured into several Swift Packages:

* **ThmanyahCoreAPI:** Core networking and API definitions
* **ThmanyahNetworkLayer:** Network service implementations
* **ThmanyahRepository:** Data access layer implementations
* **ThmanyahUseCase:** Business logic and use cases
* **DependencyContainer:** Dependency injection container
* **ThmanyahChallenges:** Main app module with UI components

## Deep Dive: Home Feed Flow

The **Home Feed Flow** manages the display of various content sections including podcasts, episodes, audiobooks, and articles.

* **HomeFeedView:** Displays the home feed with navigation tabs and content sections.
* **HomeFeedViewModel:** Provides data from the HomeFeedUseCase to the UI. It listens for state changes and updates the view accordingly.
* **HomeFeedUseCase:** Fetches home feed data by communicating with the HomeFeedRepository.
* **HomeFeedRepository:** Interacts with the Network Service to retrieve home feed data.
* **Network Service:** Fetches home feed information from the backend REST API.
* **Enhanced UI Components:** Uses modern SwiftUI components like `FeaturedCard`, `SquareCard`, `TwoLinesCard`, and various section views for rich content display.

## Technology Stack

* **Swift:** The primary language used in the application.
* **SwiftUI:** For building declarative user interfaces.
* **Async/Await:** Used for handling asynchronous programming.
* **URLSession:** Handles network requests.
* **Dependency Injection:** Custom DIContainer for managing dependencies.
* **IBM Plex Sans Arabic Fonts:** Custom Arabic typography support.
* **XCTest:** Comprehensive testing framework for unit and UI tests.

## Features

### Core Features
* **Home Feed:** Rich content display with multiple section types
* **Search:** Advanced search functionality across all content types
* **Navigation:** Tab-based navigation with Arabic localization
* **Content Types:** Support for podcasts, episodes, audiobooks, and articles

### UI Components
* **Enhanced Cards:** Multiple card types for different content layouts
* **Section Views:** Flexible section rendering with various layouts
* **Arabic Typography:** Full support for Arabic text with custom fonts
* **Responsive Design:** Adaptive layouts for different screen sizes

### Architecture Features
* **Clean Architecture:** Separation of concerns with clear layer boundaries
* **Dependency Injection:** Testable and maintainable dependency management
* **Protocol-Oriented Design:** Flexible and extensible component interfaces
* **Comprehensive Testing:** Unit tests, UI tests, and network mocking

## Setup

1. Clone the repository:
```bash
git clone https://github.com/obadasemary/ThmanyahChallenges.git
cd ThmanyahChallenges
```

2. Install dependencies (SPM)
3. Open the project workspace: `ThmanyahChallenges.xcworkspace`
4. Build and run the project on your simulator or device

## Project Structure

```
ThmanyahChallenges/
├── App/
│   ├── ThmanyahChallengesApp.swift
│   └── DevPreview.swift
├── HomeFeed/
│   ├── HomeFeedView.swift
│   ├── HomeFeedViewModel.swift
│   ├── HomeFeedBuilder.swift
│   └── Views/
│       ├── EnhancedCards/
│       ├── EnhancedSections/
│       └── UIConstants.swift
├── Search/
│   ├── SearchView.swift
│   ├── SearchViewModel.swift
│   └── SearchBuilder.swift
├── Shared/
│   └── Utilities.swift
└── Resources/
    └── Fonts/
```

## Testing

The project includes comprehensive testing:

* **Unit Tests:** Core business logic and use cases
* **UI Tests:** User interface interactions and flows
* **Network Tests:** Mocked network responses for reliable testing
* **Accessibility Tests:** Ensuring app accessibility compliance

## Conclusion

By isolating each component into **Swift Packages**, we ensure that the codebase is modular, scalable, and easy to test. Each package can evolve independently, ensuring flexibility in the face of future requirements. The **Clean Architecture** pattern guarantees a long-lasting, maintainable project that adheres to the **SOLID principles** of software design.

The integration of modern SwiftUI patterns, Arabic typography support, and comprehensive testing makes this project a robust foundation for building scalable iOS applications with excellent user experience and maintainable codebase.
