# 📦 CHANGELOG

> Project: **GeoSnap**  
> Author: Frank Erick Santos Gonzales  
> Start Date: May 2025  

---

## [v0.1.0] - 2025-05-24

### 🎉 Initial MVP - GeoSnap ready for local testing

#### ✅ Added
- Full project architecture based on **Clean Architecture**, using:
  - `application`, `data`, `domain`, `presentation`, `core`, `di`, `config` modules
- **Dependency Injection** configured via `get_it`
- **State management** using `flutter_bloc` for `CameraBloc` and `PhotoBloc`
- **Routing** handled via `GoRouter`, using `RouteNames` and `RoutePaths`
- Camera integration using:
  - `camera`, `camera_android_camerax`
  - Permission handling with `permission_handler`
- Location integration using `geolocator`
- Local data storage via `Drift` and `sqlite3_flutter_libs`
  - Database layer: `GeoSnapDatabase`, DAO, mappers
  - Entities: `PhotoEntity`
- Gallery:
  - List of saved photos (lat, lon, ID)
  - Detail screen to view each photo
- UI:
  - Loading indicators for list/detail
  - Empty state message when no photos exist
- Errors handled when photo is not found or fails to load from file
- Basic `proguard-rules.pro` configured for minification support
- Git repository initialized and structured

#### 🛠️ Changed
- Refactored `PhotoBloc` to include `PhotoDetailLoaded` state
- Adjusted routing to inject bloc instances per route
- Added fallback UI and error loaders in detail/gallery view

#### 🧪 Fixed
- `get_it` injection issue when navigating between routes
- BLoC instance not being disposed properly on back navigation (handled via `BlocProvider` per route)

---

## 🔜 Upcoming Features (planned for `v0.2.0`)

### 🔐 Authentication
- Login screen and user session flow
- Integration with external API

### ☁️ API Integration
- Remote syncing of captured photos
- Online/offline handling
- Auto sync when network is restored

---

## [Unreleased]
- Continuous refactoring and optimization
