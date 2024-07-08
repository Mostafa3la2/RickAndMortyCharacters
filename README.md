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
- Added extra shadow for the back button in details page to increase visibility

## Challenges Faced

- Placeholder for challenges encountered while implementing the clean architecture.
- Placeholder for challenges with network handling and API integration.
- Placeholder for any UI/UX challenges.

## Screenshots

![Screenshot 1](path/to/screenshot1.png)
![Screenshot 2](path/to/screenshot2.png)
![Screenshot 3](path/to/screenshot3.png)

## Getting Started

### Prerequisites

- Xcode 12.0 or later
- iOS 13.0 or later

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/rick-and-morty-characters-app.git
