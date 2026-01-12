import 'dart:ui';

import 'generated/assets.gen.dart';

/// Best duration for circleFade: 3000 milliseconds
///
/// Best duration for cog01: 4000 milliseconds
///
/// Best duration for cog02: 4000 milliseconds
///
/// Best duration for cog03: 4000 milliseconds
///
/// Best duration for cog04: 4000 milliseconds
///
/// Best duration for cog05: 4000 milliseconds (***)
///
/// Best duration for cog06: 4000 milliseconds
///
/// Best duration for cog07: 4000 milliseconds
///
/// Best duration for cog08: 4000 milliseconds
///
/// Best duration for cog09: 4000 milliseconds
///
/// Best duration for dotssRotate6: 2000 milliseconds
///
/// Best duration for dotsScaleRotate12: 3000 milliseconds (***)
///
/// Best duration for eclipse: 1500 milliseconds (***)
///
/// Best duration for eclipseHalf: 1500 milliseconds
///
/// Best duration for loader3: 1500 milliseconds (***)
///
/// Best duration for tadpole: 1000 milliseconds (***)
///
/// Best duration for windToy: 2500 milliseconds
enum IcstSpinners {
  // audio,
  // ballTriangle,
  // bars,
  // barsFade,
  // barsScale,
  // barsScaleFade,
  // barsScaleMiddle,
  // blocksScale,
  // blocksShuffle2,
  // blocksShuffle3,
  // blocksShuffle4,
  // blocksShuffle5,
  // blocksWave,
  /// Best duration for circleFade: 3000 milliseconds
  circleFade(Duration(milliseconds: 3000)),
  // circles,
  // clock01,
  // clock02,
  /// Best duration for cog01: 4000 milliseconds
  cog01(Duration(milliseconds: 4000)),

  /// Best duration for cog02: 4000 milliseconds
  cog02(Duration(milliseconds: 4000)),

  /// Best duration for cog03: 4000 milliseconds
  cog03(Duration(milliseconds: 4000)),

  /// Best duration for cog04: 4000 milliseconds
  cog04(Duration(milliseconds: 4000)),

  /// Best duration for cog05: 4000 milliseconds (***)
  cog05(Duration(milliseconds: 4000)),

  /// Best duration for cog06: 4000 milliseconds
  cog06(Duration(milliseconds: 4000)),

  /// Best duration for cog07: 4000 milliseconds
  cog07(Duration(milliseconds: 4000)),

  /// Best duration for cog08: 4000 milliseconds
  cog08(Duration(milliseconds: 4000)),

  /// Best duration for cog09: 4000 milliseconds
  cog09(Duration(milliseconds: 4000)),

  /// Best duration for dotssRotate6: 2000 milliseconds
  dotssRotate6(Duration(milliseconds: 2000)),
  // dotsScaleMiddle6,
  /// Best duration for dotsScaleRotate12: 3000 milliseconds (***)
  dotsScaleRotate12(Duration(milliseconds: 3000)),

  /// Best duration for eclipse: 1500 milliseconds (***)
  eclipse(Duration(milliseconds: 1500)),

  /// Best duration for eclipseHalf: 1500 milliseconds
  eclipseHalf(Duration(milliseconds: 1500)),

  /// Best duration for loader3: 1500 milliseconds (***)
  loader3(Duration(milliseconds: 1500)),
  // spinningCircles,
  /// Best duration for tadpole: 1000 milliseconds (***)
  tadpole(Duration(milliseconds: 1000)),
  // wifi,
  // wifiFade,
  /// Best duration for windToy: 2500 milliseconds
  windToy(Duration(milliseconds: 2500));

  final Duration defaultDuration;
  const IcstSpinners(this.defaultDuration);

  SvgGenImage get image => switch (this) {
    // IcstSpinners.audio => Assets.spinnerSvgs.audio,
    // IcstSpinners.ballTriangle => Assets.spinnerSvgs.ballTriangle,
    // IcstSpinners.bars => Assets.spinnerSvgs.bars,
    // IcstSpinners.barsFade => Assets.spinnerSvgs.barsFade,
    // IcstSpinners.barsScale => Assets.spinnerSvgs.barsScale,
    // IcstSpinners.barsScaleFade => Assets.spinnerSvgs.barsScaleFade,
    // IcstSpinners.barsScaleMiddle => Assets.spinnerSvgs.barsScaleMiddle,
    // IcstSpinners.blocksScale => Assets.spinnerSvgs.blocksScale,
    // IcstSpinners.blocksShuffle2 => Assets.spinnerSvgs.blocksShuffle2,
    // IcstSpinners.blocksShuffle3 => Assets.spinnerSvgs.blocksShuffle3,
    // IcstSpinners.blocksShuffle4 => Assets.spinnerSvgs.blocksShuffle4,
    // IcstSpinners.blocksShuffle5 => Assets.spinnerSvgs.blocksShuffle5,
    // IcstSpinners.blocksWave => Assets.spinnerSvgs.blocksWave,
    IcstSpinners.circleFade => Assets.spinnerSvgs.circleFade,
    // IcstSpinners.circles => Assets.spinnerSvgs.circles,
    // IcstSpinners.clock01 => Assets.spinnerSvgs.clock01,
    // IcstSpinners.clock02 => Assets.spinnerSvgs.clock02,
    IcstSpinners.cog01 => Assets.spinnerSvgs.cog01,
    IcstSpinners.cog02 => Assets.spinnerSvgs.cog02,
    IcstSpinners.cog03 => Assets.spinnerSvgs.cog03,
    IcstSpinners.cog04 => Assets.spinnerSvgs.cog04,
    IcstSpinners.cog05 => Assets.spinnerSvgs.cog05,
    IcstSpinners.cog06 => Assets.spinnerSvgs.cog06,
    IcstSpinners.cog07 => Assets.spinnerSvgs.cog07,
    IcstSpinners.cog08 => Assets.spinnerSvgs.cog08,
    IcstSpinners.cog09 => Assets.spinnerSvgs.cog09,
    IcstSpinners.dotssRotate6 => Assets.spinnerSvgs.dotsRotate6,
    // IcstSpinners.dotsScaleMiddle6 => Assets.spinnerSvgs.dotsScaleMiddle6,
    IcstSpinners.dotsScaleRotate12 => Assets.spinnerSvgs.dotsScaleRotate12,

    IcstSpinners.eclipse => Assets.spinnerSvgs.eclipse,
    IcstSpinners.eclipseHalf => Assets.spinnerSvgs.eclipseHalf,
    IcstSpinners.loader3 => Assets.spinnerSvgs.loader3,
    // IcstSpinners.spinningCircles => Assets.spinnerSvgs.spinningCircles,
    IcstSpinners.tadpole => Assets.spinnerSvgs.tadpole,
    // IcstSpinners.wifi => Assets.spinnerSvgs.wifi,
    // IcstSpinners.wifiFade => Assets.spinnerSvgs.wifiFade,
    IcstSpinners.windToy => Assets.spinnerSvgs.windToy,
  };

  String get path => image.path;

  String get key => image.keyName;

  Size? get size => image.size;

  Set<String> get flavors => image.flavors;
}
