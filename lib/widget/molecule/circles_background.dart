import 'package:flutter/material.dart';

import '../../app/theme/app_sizes.dart';
import '../atom/app_image.dart';

class CirclesBackground extends StatelessWidget {
  final Widget body;

  const CirclesBackground({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        body,
        Positioned(
          right: 1136,
          bottom: 483,
          child: bigCircle(),
        ),
        Positioned(
          left: 1236,
          top: 123,
          child: bigCircle(),
        ),
        Positioned(
          left: 1136,
          top: 263,
          child: photosBackground(),
        ),
      ],
    );
  }

  Widget bigCircle() {
    return Container(
      width: 600,
      height: 600,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(55, 114, 255, 0.05),
      ),
    );
  }

  Widget photosBackground() {
    return backgroundReferral();
  }

  Widget backgroundReferral() {
    const double gapImage = AppSizes.padding * 3;

    return const SizedBox(
      width: 450,
      height: 400,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AppImage(
            image: randomImage,
            width: 150,
            height: 150,
            borderRadius: 100,
          ),
          Positioned(
            bottom: 296,
            left: 278 + gapImage,
            child: AppImage(
              image: randomImage,
              width: 95,
              height: 95,
              borderRadius: 100,
            ),
          ),
          Positioned(
            top: 257,
            left: 278 + gapImage,
            child: AppImage(
              image: randomImage,
              width: 112,
              height: 112,
              borderRadius: 100,
            ),
          ),
          Positioned(
            bottom: 54,
            right: 255 + gapImage,
            child: AppImage(
              image: randomImage,
              width: 70,
              height: 70,
              borderRadius: 100,
            ),
          ),
          Positioned(
            right: 278 + gapImage,
            bottom: 285,
            child: AppImage(
              image: randomImage,
              width: 89,
              height: 89,
              borderRadius: 100,
            ),
          ),
          Positioned(
            bottom: 329,
            left: 183 + gapImage,
            child: AppImage(
              image: randomImage,
              width: 36,
              height: 36,
              borderRadius: 100,
            ),
          ),
          Positioned(
            bottom: 195,
            left: 278 + gapImage,
            child: AppImage(
              image: randomImage,
              width: 48,
              height: 48,
              borderRadius: 100,
            ),
          ),
          Positioned(
            bottom: 48,
            right: 107 + gapImage,
            child: AppImage(
              image: randomImage,
              width: 48,
              height: 48,
              borderRadius: 100,
            ),
          )
        ],
      ),
    );
  }
}
