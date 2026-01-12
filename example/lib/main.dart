import 'package:flutter/material.dart';

import 'package:icst_spinner_overlay/icst_spinner_overlay.dart';

typedef OnSpinnerChangeCallback =
    Function(IcstSpinners newSpinner, bool isFullScreen);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ICST Spinner Overlay Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.teal)),
      home: const MyHomePage(title: 'ICST Spinner Overlay Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _blockFullScreen = false;
  IcstSpinners _fullScreenSpinner = IcstSpinners.cog05;

  bool _blockChild = false;
  IcstSpinners _childSpinner = IcstSpinners.dotsScaleRotate12;

  Duration get _duration => Duration(seconds: 10);

  void _toggleFullScreen() {
    setState(() {
      _blockFullScreen = !_blockFullScreen;
    });
    if (_blockFullScreen) {
      Future.delayed(_duration, () {
        setState(() {
          _blockFullScreen = false;
        });
      });
    }
  }

  void _toggleChild() {
    setState(() {
      _blockChild = !_blockChild;
    });
    if (_blockChild) {
      Future.delayed(_duration, () {
        setState(() {
          _blockChild = false;
        });
      });
    }
  }

  void _onSpinnerChanged(IcstSpinners newSpinner, bool isFullScreen) {
    setState(() {
      if (isFullScreen) {
        _fullScreenSpinner = newSpinner;
      } else {
        _childSpinner = newSpinner;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: .center,
              spacing: 25,
              children: [
                _FullScreenBlockSample(
                  show: _blockFullScreen,
                  onToggle: _toggleFullScreen,
                  seconds: _duration.inSeconds,
                  spinner: _fullScreenSpinner,
                  onSpinnerChanged: _onSpinnerChanged,
                ),
                _ChildBlockSample(
                  show: _blockChild,
                  onToggle: _toggleChild,
                  seconds: _duration.inSeconds,
                  spinner: _childSpinner,
                  onSpinnerChanged: _onSpinnerChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FullScreenBlockSample extends StatelessWidget {
  const _FullScreenBlockSample({
    required this.show,
    required this.onToggle,
    required this.seconds,
    required this.spinner,
    this.onSpinnerChanged,
  });

  final bool show;
  final VoidCallback onToggle;
  final int seconds;
  final IcstSpinners spinner;
  final OnSpinnerChangeCallback? onSpinnerChanged;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.6,
      height: width * 0.3,
      child:
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  spacing: 8.0,
                  children: [
                    FilledButton.tonal(
                      onPressed: onToggle,
                      child: Text('Block Full Screen'),
                    ),

                    _SpinnerInput(
                      spinner: spinner,
                      onSpinnerChanged: onSpinnerChanged,
                      isFullScreen: true,
                    ),
                  ],
                ),
              ),
            ),
          ).withIcstSpinnerOverlay(
            show: show,
            config: IcstSpinnerConfig(
              spinner: spinner,
              messageConfig: IsctSpinnerMessageConfig(
                text:
                    'This is blocking the full screen for $seconds seconds.\nYou can tap to discard it',
              ),
            ),
            onOverlayTap: onToggle,
          ),
    );
  }
}

class _ChildBlockSample extends StatelessWidget {
  const _ChildBlockSample({
    required this.show,
    required this.onToggle,
    required this.seconds,
    required this.spinner,
    this.onSpinnerChanged,
  });

  final bool show;
  final VoidCallback onToggle;
  final int seconds;
  final IcstSpinners spinner;
  final OnSpinnerChangeCallback? onSpinnerChanged;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.8,
      height: width * 0.9,
      child:
          Card(
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  spacing: 8.0,
                  children: [
                    FilledButton.tonal(
                      onPressed: onToggle,
                      child: Text('Block Child'),
                    ),
                    _SpinnerInput(
                      spinner: spinner,
                      onSpinnerChanged: onSpinnerChanged,
                      isFullScreen: false,
                    ),
                  ],
                ),
              ),
            ),
          ).withIcstSpinnerOverlay(
            show: show,
            config: IcstSpinnerConfig(
              blockEntireScreen: false,
              spinner: spinner,
              messageConfig: IsctSpinnerMessageConfig(
                text:
                    'This is blocking just the child for $seconds seconds.\nYou can tap to discard it',
              ),
            ),
            onOverlayTap: onToggle,
          ),
    );
  }
}

class _SpinnerInput extends StatelessWidget {
  const _SpinnerInput({
    required this.spinner,
    required this.onSpinnerChanged,
    required this.isFullScreen,
  });

  final IcstSpinners spinner;
  final OnSpinnerChangeCallback? onSpinnerChanged;
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<IcstSpinners>(
      value: spinner,
      onChanged: (IcstSpinners? newValue) {
        if (newValue != null) {
          onSpinnerChanged?.call(newValue, isFullScreen);
        }
      },
      items: IcstSpinners.values
          .map((s) => DropdownMenuItem(value: s, child: Text(s.name)))
          .toList(),
    );
  }
}
