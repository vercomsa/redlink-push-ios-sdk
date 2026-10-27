# Changelog

All notable changes to this project are documented in this file.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.1.22] - 2026-09-22

### Fixed
- Push delivery and open status reports sent from a Notification Service Extension were not recorded when the extension target did not bundle its own `RedlinkConfig.plist`. The SDK now falls back to the containing app's `RedlinkConfig.plist`, so the config no longer needs to be duplicated into extension targets.

## [1.1.21] - 2026-08-05

Internal rebuild; no functional changes.

## [1.1.20] - 2026-07-22

### Added
- `RedlinkPush.didReceiveNotificationServiceRequest(_:completion:)` for apps that implement their own `UNNotificationServiceExtension`.
- `RedlinkPush.reportPushDelivered(userInfo:completion:)`.

## [1.1.19] - 2026-03-18

Internal rebuild; no functional changes.

## [1.1.18] - 2026-02-17

### Added
- Localized push notification strings for 11 additional languages (Bulgarian, Czech, German, Greek, Croatian, Hungarian, Italian, Lithuanian, Romanian, Slovak, Ukrainian).

## [1.1.17] - 2025-04-18

### Added
- `Redlink.user.detachToken()` to unsubscribe the current device's push token without clearing the rest of the user's stored data.

## [1.1.16] - 2025-03-21

### Fixed
- Removed stray build artifacts that had been accidentally included in the 1.1.15 package.

## [1.1.15] - 2025-02-27

### Changed
- Raised minimum Swift language version to 6.0.3 and minimum iOS deployment target to 14.0.
- Updated `SQLite.swift` dependency to 0.15.3.
- Aligned the Swift Package Manager distribution's architecture support with the CocoaPods distribution.

## [1.1.14] - 2022-11-14

### Removed
- Dropped 32-bit architecture support (`armv7` device, `i386` simulator).

## [1.1.13] - 2022-05-24

Internal rebuild; no functional changes.

## [1.1.12] - 2022-05-08

### Added
- Swift Package Manager (SPM) distribution support.
- `externalId` property on `RedlinkUserData`.

## [1.1.11] - 2022-03-16

Internal rebuild; no functional changes.

## [1.1.10] - 2022-02-23

### Changed
- Migrated packaging to `.xcframework`, with per-platform slices and module-stability interfaces.
- Updated `SQLite.swift` dependency to 0.13.2.

## [1.1.9] - 2022-01-30

Internal rebuild; no functional changes.

## [1.1.8] - 2021-11-23

### Fixed
- Restored full multi-architecture support after a packaging issue in 1.1.7 affecting Simulator and other non-arm64 builds.

## [1.1.7] - 2021-11-16

### Fixed
- Reduced framework size due to a packaging issue; resolved in 1.1.8.

## [1.1.6] - 2021-05-11

Internal rebuild; no functional changes.

## [1.1.5] - 2021-03-16

Internal rebuild; no functional changes.

## [1.1.4] - 2020-10-20

### Fixed
- Apple Silicon compile issue when building for the iOS Simulator.

## [1.1.3] - 2020-01-09

### Added
- Polish localized notification strings.

## [1.1.2] - 2019-07-17

### Changed
- Reverted `SQLite.swift` dependency to 0.11.5.

### Documentation
- Documented that `UNUserNotificationCenter.current().delegate` must be set in `AppDelegate` for the `willPresentNotification` callback to fire.

## [1.1.1] - 2019-07-15

### Added
- Demo app.
- `RedlinkPushOptions` configuration type (`authorizationOptions`, `useAutomaticConfiguration`).

### Changed
- Updated `SQLite.swift` dependency to 0.12.2.

## [1.1.0] - 2019-06-13

### Added
- x86_64 simulator architecture support.
- Documented validation rules (email format, 64-character field limits) and the `userData` parameter on `trackEvent`.

## [1.0.0] - 2019-02-15

Initial public release.
