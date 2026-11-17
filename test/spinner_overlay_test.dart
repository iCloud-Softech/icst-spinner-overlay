import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

import 'package:icst_spinner_overlay/icst_spinner_overlay.dart';

// A primary colour that no default Material theme uses. If the spinner shows
// it, the spinner read the theme of the material_ui MaterialApp.
const Color _themePrimary = Color(0xFF00A86B);

// The colour that the caller sets in IcstSpinnerConfig.color.
const Color _configColor = Color(0xFFE4572E);

const String _message = 'Loading data';

/// Builds a material_ui MaterialApp whose theme has [_themePrimary] as its
/// primary colour, and puts an active spinner overlay on its home screen.
Widget _buildApp({required bool blockEntireScreen, Color? color}) =>
    MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: _themePrimary),
      ),
      home: Scaffold(
        body: IcstSpinnerOverlay(
          show: true,
          config: IcstSpinnerConfig(
            spinner: IcstSpinners.cog05,
            color: color,
            blockEntireScreen: blockEntireScreen,
            messageConfig: const IsctSpinnerMessageConfig(text: _message),
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );

/// Pumps the app. The second frame lets the full-screen overlay entry, which
/// the widget inserts in a post-frame callback, build.
Future<void> _pumpApp(
  WidgetTester tester, {
  required bool blockEntireScreen,
  Color? color,
}) async {
  await tester.pumpWidget(
    _buildApp(blockEntireScreen: blockEntireScreen, color: color),
  );
  await tester.pump();
  await tester.pump();
}

/// Returns the colour that the spinner SVG is painted with.
ColorFilter? _spinnerColorFilter(WidgetTester tester) =>
    tester.widget<SvgPicture>(find.byType(SvgPicture)).colorFilter;

/// Returns the colour of the message text below the spinner.
Color? _messageColor(WidgetTester tester) =>
    tester.widget<Text>(find.text(_message)).style?.color;

void main() {
  for (final bool blockEntireScreen in <bool>[false, true]) {
    final String mode = blockEntireScreen
        ? 'full-screen overlay'
        : 'in-place overlay';

    group('IcstSpinnerOverlay in a material_ui MaterialApp ($mode)', () {
      testWidgets('uses the theme primary colour when config.color is null', (
        WidgetTester tester,
      ) async {
        await _pumpApp(tester, blockEntireScreen: blockEntireScreen);

        expect(
          _spinnerColorFilter(tester),
          const ColorFilter.mode(_themePrimary, BlendMode.srcIn),
        );
        expect(_messageColor(tester), _themePrimary);
      });

      testWidgets('uses config.color when it is set', (
        WidgetTester tester,
      ) async {
        await _pumpApp(
          tester,
          blockEntireScreen: blockEntireScreen,
          color: _configColor,
        );

        expect(
          _spinnerColorFilter(tester),
          const ColorFilter.mode(_configColor, BlendMode.srcIn),
        );
        expect(_messageColor(tester), _configColor);
      });
    });
  }
}
