## 1.0.0

* Initial release.

## 1.0.1

* Updated ReADME.md

## 1.0.2

* Improved README.md and pubspec.yaml to follow dart file conventions

## 2.0.0

* **Breaking:** the package now uses `package:material_ui` in place of the Material library of the Flutter SDK.
  * The spinner and its message read their default colour and text style from the `material_ui` theme.
  * An app that still uses the Material library of the SDK continues to compile. But its spinner ignores the app theme and shows the default Material colour. Move the app to `package:material_ui` to keep the theme colour.
  * The minimum Dart SDK is now 3.13. The minimum Flutter SDK is now 3.47.
* Added widget tests for the spinner colour in the in-place overlay and the full-screen overlay.
