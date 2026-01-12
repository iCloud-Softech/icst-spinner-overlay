import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './svg_mapper.dart';
import 'generated/assets.gen.dart';

const Duration _defaultDuration = Duration(milliseconds: 2500);
const bool _defaultClockwise = true;

class IcstSpinnerRotationAnimationConfig {
  final Duration duration;
  final bool clockwise;

  const IcstSpinnerRotationAnimationConfig({
    this.duration = _defaultDuration,
    this.clockwise = _defaultClockwise,
  });
}

class IsctSpinnerMessageConfig {
  final String text;
  final TextStyle? textStyle;
  final double spacing;

  const IsctSpinnerMessageConfig({
    required this.text,
    this.textStyle,
    this.spacing = 12,
  });
}

/// Configuration for the SVG spinner
class IcstSpinnerConfig {
  /// Spinner asset
  final IcstSpinners spinner;

  /// Size of the spinner
  final double size;

  /// Color of the spinner (if supported by SVG)
  final Color? color;

  /// Rotation Animation configuration
  final IcstSpinnerRotationAnimationConfig? rotationAnimationConfig;

  /// Use rotation animation
  final bool useRotationAnimation;

  /// Background color of the overlay
  final Color overlayColor;

  /// Opacity of the background overlay (0.0 to 1.0)
  final double overlayOpacity;

  /// Whether the overlay should block the entire screen
  /// If false, it only blocks the child widget area
  final bool blockEntireScreen;

  /// Custom widget builder for the spinner
  /// Allows complete customization of the spinner display
  final Widget Function(BuildContext context, Widget svgWidget)? spinnerBuilder;

  /// Padding around the spinner
  final EdgeInsetsGeometry spinnerPadding;

  /// Custom message/text to display below the spinner
  final IsctSpinnerMessageConfig? messageConfig;

  const IcstSpinnerConfig({
    required this.spinner,
    this.size = 75.0,
    this.color,
    this.rotationAnimationConfig,
    this.useRotationAnimation = true,
    this.overlayColor = Colors.black,
    this.overlayOpacity = 0.7,
    this.blockEntireScreen = true,
    this.spinnerBuilder,
    this.spinnerPadding = const EdgeInsets.all(10.0),
    this.messageConfig,
  });

  IcstSpinnerConfig copyWith({
    IcstSpinners? spinner,
    double? size,
    Color? color,
    IcstSpinnerRotationAnimationConfig? rotationAnimationConfig,
    bool? useRotationAnimation,
    Color? overlayColor,
    double? overlayOpacity,
    bool? blockEntireScreen,
    Widget Function(BuildContext context, Widget svgWidget)? spinnerBuilder,
    EdgeInsetsGeometry? spinnerPadding,
    IsctSpinnerMessageConfig? messageConfig,
  }) {
    return IcstSpinnerConfig(
      spinner: spinner ?? this.spinner,
      size: size ?? this.size,
      color: color ?? this.color,
      rotationAnimationConfig:
          rotationAnimationConfig ?? this.rotationAnimationConfig,
      useRotationAnimation: useRotationAnimation ?? this.useRotationAnimation,
      overlayColor: overlayColor ?? this.overlayColor,
      overlayOpacity: overlayOpacity ?? this.overlayOpacity,
      blockEntireScreen: blockEntireScreen ?? this.blockEntireScreen,
      spinnerBuilder: spinnerBuilder ?? this.spinnerBuilder,
      spinnerPadding: spinnerPadding ?? this.spinnerPadding,
      messageConfig: messageConfig ?? this.messageConfig,
    );
  }
}

/// A widget that shows an SVG spinner overlay when loading
class IcstSpinnerOverlay extends StatefulWidget {
  /// Whether the spinner overlay is active
  final bool show;

  /// The child widget that will be displayed normally
  final Widget child;

  /// Configuration for the spinner
  final IcstSpinnerConfig config;

  /// Custom loading widget builder for complete control
  final Widget Function(BuildContext context)? customLoadingBuilder;

  /// Called when the user taps the overlay (optional)
  final VoidCallback? onOverlayTap;

  // /// Whether the overlay should be dismissed when tapped
  // final bool dismissOnTap;

  /// Creates an SVG spinner overlay
  const IcstSpinnerOverlay({
    super.key,
    required this.show,
    required this.child,
    required this.config,
    this.customLoadingBuilder,
    this.onOverlayTap,
  });

  @override
  State<IcstSpinnerOverlay> createState() => _IcstSpinnerOverlayState();
}

class _IcstSpinnerOverlayState extends State<IcstSpinnerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isUsingDefaultDuration = true;

  OverlayEntry? _fullScreenOverlayEntry;

  @override
  void initState() {
    super.initState();
    isUsingDefaultDuration =
        widget.config.rotationAnimationConfig?.duration == null;
    _controller = AnimationController(
      duration:
          widget.config.rotationAnimationConfig?.duration ??
          widget.config.spinner.defaultDuration,
      vsync: this,
    )..repeat();
    if (widget.config.blockEntireScreen && widget.show) {
      _insertFullScreenOverlay();
    }
  }

  @override
  void didUpdateWidget(IcstSpinnerOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show != oldWidget.show) {
      if (widget.show) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
      // toggle full screen overlay based on active state
      if (widget.config.blockEntireScreen) {
        if (widget.show) {
          _insertFullScreenOverlay();
        } else {
          _removeFullScreenOverlay();
        }
      }
    }
    if (isUsingDefaultDuration) {
      if (widget.config.spinner.defaultDuration !=
          oldWidget.config.spinner.defaultDuration) {
        _controller.duration = widget.config.spinner.defaultDuration;
        if (widget.show) {
          _controller.repeat();
        }
      }
    } else {
      if (widget.config.rotationAnimationConfig?.duration !=
          oldWidget.config.rotationAnimationConfig?.duration) {
        _controller.duration =
            widget.config.rotationAnimationConfig?.duration ??
            widget.config.spinner.defaultDuration;
        if (widget.show) {
          _controller.repeat();
        }
      }
    }
    // If blockEntireScreen flag changed, insert/remove overlay accordingly
    if (widget.config.blockEntireScreen != oldWidget.config.blockEntireScreen) {
      if (widget.config.blockEntireScreen && widget.show) {
        _insertFullScreenOverlay();
      } else {
        _removeFullScreenOverlay();
      }
    }
  }

  @override
  void dispose() {
    _removeFullScreenOverlay();
    _controller.dispose();
    super.dispose();
  }

  void _insertFullScreenOverlay() {
    if (_fullScreenOverlayEntry != null) return;
    _fullScreenOverlayEntry = OverlayEntry(
      builder: (ctx) =>
          Positioned.fill(child: _buildOverlayWithGesture(Theme.of(ctx))),
    );
    // insert on next frame to avoid build-time overlay insertion issues
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final overlay = Overlay.of(context, rootOverlay: true);
      overlay.insert(_fullScreenOverlayEntry!);
    });
  }

  void _removeFullScreenOverlay() {
    _fullScreenOverlayEntry?.remove();
    _fullScreenOverlayEntry = null;
  }

  Widget _buildSpinner(ThemeData theme) {
    final svgWidget = SvgPicture.asset(
      widget.config.spinner.path,
      package: Assets.package,
      width: widget.config.size,
      height: widget.config.size,
      colorFilter: ColorFilter.mode(
        widget.config.color ?? theme.colorScheme.primary,
        BlendMode.srcIn,
      ),
    );

    Widget? rotationWidget;
    if (widget.config.useRotationAnimation == true) {
      // Apply rotation animation
      final rotationConfig =
          widget.config.rotationAnimationConfig ??
          IcstSpinnerRotationAnimationConfig();
      rotationWidget = RotationTransition(
        turns: Tween(
          begin: 0.0,
          end: rotationConfig.clockwise ? 1.0 : -1.0,
        ).animate(_controller),
        child: svgWidget,
      );
    }

    // Use custom spinner builder if provided
    if (widget.config.spinnerBuilder != null) {
      return widget.config.spinnerBuilder!(
        context,
        rotationWidget ?? svgWidget,
      );
    }

    // Build default spinner with optional text
    Widget spinnerContent = rotationWidget ?? svgWidget;

    if (widget.config.messageConfig != null) {
      spinnerContent = Column(
        mainAxisSize: MainAxisSize.min,
        spacing: widget.config.messageConfig!.spacing,
        children: [
          spinnerContent,
          Text(
            widget.config.messageConfig!.text,
            textAlign: TextAlign.center,
            style:
                widget.config.messageConfig!.textStyle ??
                theme.textTheme.displaySmall?.copyWith(
                  color: widget.config.color ?? theme.colorScheme.primary,
                ),
          ),
        ],
      );
    }

    return Padding(
      padding: widget.config.spinnerPadding,
      child: spinnerContent,
    );
  }

  Widget _buildOverlay(ThemeData theme) {
    // Use custom loading builder if provided
    if (widget.customLoadingBuilder != null) {
      return widget.customLoadingBuilder!(context);
    }

    return Container(
      color: widget.config.overlayColor.withValues(
        alpha: widget.config.overlayOpacity,
      ),
      child: Center(
        child: Material(color: Colors.transparent, child: _buildSpinner(theme)),
      ),
    );
  }

  Widget _buildOverlayWithGesture(ThemeData theme) {
    final overlay = _buildOverlay(theme);

    if (widget.onOverlayTap != null) {
      return GestureDetector(
        onTap: () {
          widget.onOverlayTap?.call();
        },
        child: overlay,
      );
    }

    return overlay;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    if (widget.config.blockEntireScreen) {
      return widget.child;
    } else {
      return ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            widget.child,
            if (widget.show)
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: false,
                  child: _buildOverlayWithGesture(theme),
                ),
              ),
          ],
        ),
      );
    }
  }
}

/// Extension for quick overlay addition
extension IcstSpinnerOverlayExtension on Widget {
  Widget withIcstSpinnerOverlay({
    required bool show,
    required IcstSpinnerConfig config,
    Widget Function(BuildContext context)? customLoadingBuilder,
    VoidCallback? onOverlayTap,
  }) {
    return IcstSpinnerOverlay(
      show: show,
      config: config,
      customLoadingBuilder: customLoadingBuilder,
      onOverlayTap: onOverlayTap,
      child: this,
    );
  }
}
