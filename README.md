# Rick and Morty Characters App
[![Swift](https://img.shields.io/badge/Swift-5-orange.svg)](https://swift.org/)
[![Platform](https://img.shields.io/badge/Platform-iOS%3E=16-blue.svg)](https://developer.apple.com/ios/)
## Overview

This iOS application fetches and displays character data from the Rick and Morty API. The app is designed to showcase a clean architecture approach, making the codebase modular, scalable, and testable. Users can browse through a paginated list of characters and view detailed information about each character.

## Technologies Used

- **Swift**: The primary programming language used for developing the app.
- **UIKit & SwiftUI**: Utilized for building the user interface.
- **Combine**: Used for handling asynchronous events and data binding.
- **Clean Architecture**: Implements the clean architecture principles to maintain a clear separation of concerns.
- **Dependency Injection**: Used for managing dependencies and enhancing testability.
- **Kingfisher**: Used for image caching.
- **SkeletonView** Add more user-friendly loading style in poor connection situations

## Why Clean Architecture

Clean Architecture was chosen to ensure that the app is modular, testable, and maintainable. while it might seem to be an overkill for such a simple task, I think such task typically would be a part of a larger app that should follow this architecture  like IMDB, Fextralife, etc, This approach provides several benefits as following:
- **Separation of Concerns**: Each layer has a distinct responsibility, making the codebase easier to understand and maintain.
- **Testability**: The architecture allows for easier unit and integration testing by decoupling components that can be mocked individually to increase code coverage
- **Scalability**: The modular structure makes it easier to add new features without impacting existing functionality.
- **Flexibility**: Components can be easily replaced or updated without affecting other parts of the system.

## Assumptions

- Characters are colored in homepage based on their status as following: blue for alive, peach for dead, white for unknown
- Used Xib files for UIKit instead of designing by code as there are already some SwiftUI views writted by code to showcase diversity in creating UI
- Details don't need to be refetched from remote source as the model itself in homepage has the full details and doesn't have a simplified version
- Used the default urlsession because we don't need any additional customization as no features like SSL pinning are implemented.
- Minor UI enhancements like adding shadow to back button in details page to increase visibility and adding pull to refresh logic

## Challenges Faced

- Separation of concers while designing with clean architecture i.e. having multiple mappers between models
- Choosing what to make mockable and testable
- Dependency Injection Container logic, coordinator logic.
- Pagination Unit testing.

## Possible Enhancements

- Enhance network layer to have logging and better error handling
- Adding system for handling accessbility identifier and adding more UI Tests

## Screenshots
![Simulator Screenshot - iPhone 15 Pro - 2024-07-08 at 05 33 19](https://github.com/Mostafa3la2/RickAndMortyCharacters/assets/9192592/136965be-6e90-4136-a2ee-746de78e354d)
![Simulator Screenshot - iPhone 15 Pro - 2024-07-08 at 05 33 24](https://github.com/Mostafa3la2/RickAndMortyCharacters/assets/9192592/86c639b0-263a-4e1f-b9a8-b43167e71e61)
![Simulator Screenshot - iPhone 15 Pro - 2024-07-08 at 05 33 28](https://github.com/Mostafa3la2/RickAndMortyCharacters/assets/9192592/c829969b-a5be-4bba-949b-6b470c2d4c7d)
![Simulator Screenshot - iPhone 15 Pro - 2024-07-08 at 05 33 05](https://github.com/Mostafa3la2/RickAndMortyCharacters/assets/9192592/74a25e30-62b0-4794-aba6-bb83a23b27b2)
<img width="349" alt="Screenshot 2024-07-08 at 05 34 15" src="https://github.com/Mostafa3la2/RickAndMortyCharacters/assets/9192592/2a4236eb-1301-4303-8c51-d61a3d564050">



## Getting Started

### Prerequisites

- Xcode 15.0 or later
- iOS 16.0 or later

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Mostafa3la2/RickAndMortyCharacters.git
