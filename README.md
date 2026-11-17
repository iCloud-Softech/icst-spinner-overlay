# Icst Spinner Overlay for Flutter

A customizable Flutter widget that displays spinner as an overlay when busy and you want to block the screen..

## Features

- More thatn 15 different spinners to choose from
- Customizable rotation animation duration
- Each spinner has its own default animation duration for best results
- Configurable overlay (full screen or child-only blocking)
- Adjustable background color and opacity
- Optional message text
- Custom spinner builder for complete control
- Tap gesture support on overlay
- Extension method for easy widget wrapping

## Requirements

- Dart SDK 3.13 or later.
- Flutter SDK 3.47 or later.
- An app that uses [`package:material_ui`](https://pub.dev/packages/material_ui) for its `MaterialApp` and theme.

The spinner reads its default colour and text style from the `material_ui` theme. If your app still uses the Material library of the Flutter SDK (`package:flutter/material.dart`), the spinner does not see your theme. It then shows the default Material colour. To keep the theme colour, move the app to `package:material_ui`, or set `IcstSpinnerConfig.color`.

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  icst_spinner_overlay: ^2.0.0
  material_ui: ^1.11.1
```

Import both packages:

```dart
import 'package:icst_spinner_overlay/icst_spinner_overlay.dart';
import 'package:material_ui/material_ui.dart';
```

## Samples

### Basic
```dart
IcstSpinnerOverlay(
  show: true,
  config: IcstSpinnerConfig(
    spinner: IcstSpinners.cog05,
  ),
  child: YourWidget(),
);
```

### With Extension
```dart
YourWidget()
  .withIcstSpinnerOverlay(
    show: true,
    config: IcstSpinnerConfig(
      spinner: IcstSpinners.loader3,
    ),
  );
```

## Configuration
| Parameter | Type | Default | Description |
|---|---|---|---|
| show | bool | Required | Whether the overlay is active or not |
| config | IcstSpinnerConfig | Required | [See General Configuration documentation](#general-configuration) |
| child | Widget | Required | Wdiget that will contain the overlay |
| onOverlayTap | VoidCallback? | null | Callback for when the overlay is tapped on |
| customLoadingBuilder | Widget Function(BuildContext)? | null | Function that returns the widget to display on top of the overlay |

### General Configuration
| Parameter | Type | Default | Description |
|---|---|---|---|
| spinner | Enum | Required | Any of the spinners in IcstSpinners enum |
| size | double? | 75.0 | Spinner size |
| color | Color? | `colorScheme.primary` of the `material_ui` theme | Spinner color |
| rotationAnimationConfig | IcstSpinnerRotationAnimationConfig? | [See IcstSpinnerRotationAnimationConfig documentation](#icstspinnerrotationanimationconfig) | Animation configuration |
| useRotationAnimation? | bool? | true | Whether the spinner is static or uses animation |
| overlayColor | Color? | Colors.black | Overlay background |
| overlayOpacity | double? | 0.6 | Overlay opacity |
| blockEntireScreen | bool? | true | Full screen vs child-only blockage|
| spinnerPadding | EdgeInsets? | 20.0 | Padding around spinner |
| messageConfig | IsctSvgMessageConfig? | [See IsctSpinnerMessageConfig Documentation](#isctspinnermessageconfig) | Optional Message configuration |

### IcstSpinnerRotationAnimationConfig
| Parameter | Type | Default | Description |
|---|---|---|---|
| rotationDuration | Duration | Default's spinner duration | Rotation speed |
| clockwise | bool | true | Rotation direction |

### IsctSpinnerMessageConfig
| Parameter | Type | Default | Description |
|---|---|---|---|
| text | String | Required | Message text |
| textStyle | TextStyle? | `textTheme.displaySmall` of the `material_ui` theme, in the spinner color | Text style |