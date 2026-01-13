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

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  icst_spinner_overlay: ^1.0.0
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
| color | Color? | Theme's primary color | Spinner color |
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
| textStyle | TextStyle? | Theme's text displaySmall with either same color as Spinner | Text style |