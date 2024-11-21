# Foodie - Your Global Recipe Explorer

A Flutter mobile application that allows users to explore recipes from different cuisines using TheMealDB API.

## Features

- Browse recipe categories with a beautiful grid layout
- View detailed recipes with ingredients and instructions
- Search for recipes by name
- Save favorite recipes for offline access
- Share recipes with friends
- Watch recipe videos on YouTube
- Pull-to-refresh for latest content
- Error handling and offline support

## Screens

1. **Home Screen**
    - Displays recipe categories in a masonry grid
    - Quick access to search and favorites
    - Pull-to-refresh functionality

2. **Recipe List Screen**
    - Shows recipes for selected category
    - Clean card-based UI with images
    - Loading and error states

3. **Recipe Details Screen**
    - Full recipe information
    - Ingredients with measurements
    - Step-by-step instructions
    - Video tutorial link
    - Share functionality
    - Add to favorites option

4. **Search Screen**
    - Real-time recipe search
    - Debounced search input
    - Results in a scrollable list

5. **Favorites Screen**
    - Saved recipes for offline access
    - Remove from favorites option
    - Persistent storage using SharedPreferences

## Technical Implementation

### API Integration
- Using TheMealDB API
- Implemented HTTP requests for:
    - Fetching categories
    - Loading recipe details
    - Searching recipes
    - Error handling for failed requests

### State Management
- Using Provider for favorites management
- Local state management with setState
- Persistent storage with SharedPreferences

### UI Components
- Custom widgets for reusability
- Loading animations with Shimmer effect
- Error handling views
- Hero animations for smooth transitions

### Code Structure
```
lib/
  ├── models/
  │   ├── category.dart
  │   └── recipe.dart
  ├── screens/
  │   ├── home_screen.dart
  │   ├── recipe_list_screen.dart
  │   ├── recipe_details_screen.dart
  │   ├── search_screen.dart
  │   └── favorites_screen.dart
  ├── services/
  │   └── api_service.dart
  ├── widgets/
  │   ├── category_card.dart
  │   ├── recipe_card.dart
  │   ├── error_view.dart
  │   └── loading_grid.dart
  ├── providers/
  │   └── favorites_provider.dart
  └── main.dart
```

### Challenges and Solutions

1. **API Response Handling**
    - Challenge: The API returns ingredients and measurements in numbered fields
    - Solution: Implemented custom parsing logic in the Recipe model

2. **Image Loading**
    - Challenge: Images loading slowly and causing layout shifts
    - Solution: Implemented cached network images with loading placeholders

3. **Offline Support**
    - Challenge: Maintaining favorites without a backend
    - Solution: Implemented local storage using SharedPreferences

4. **Search Implementation**
    - Challenge: Too many API calls during search
    - Solution: Implemented debouncing for search input

## Setup Instructions

1. Clone the repository
```bash
git clone [repository-url]
cd foodie_app
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
  http: ^1.1.0
  cached_network_image: ^3.3.0
  shared_preferences: ^2.2.2
  google_fonts: ^6.1.0
  flutter_staggered_grid_view: ^0.7.0
  shimmer: ^3.0.0
  fluttertoast: ^8.2.4
  url_launcher: ^6.2.1
  share_plus: ^7.2.1
```