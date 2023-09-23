// App Sizes

import 'dart:ui';

class AppSizes {
  // This class is not meant to be instatiated or extended; this constructor
  // prevents instantiation and extension.
  AppSizes._();

  static Size screenSize = (PlatformDispatcher.instance.implicitView?.physicalSize ?? const Size(0, 0)) /
      PlatformDispatcher.instance.views.first.devicePixelRatio;

  static const padding = 18.0;
  static const height = 12.0;
  static const icon = 26.0;
  static const radius = 8.0;

  static double xxlExpand() {
    return screenSize.width - 268;
  }

  static double xlExpand() {
    return 1200 - 268;
  }

  static double lgExpand() {
    return 992 - 268;
  }

  static double mdExpand() {
    return 768 - 268;
  }
  

  static double smExpand() {
    return 576 - 268;
  }
}
