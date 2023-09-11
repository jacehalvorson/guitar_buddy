import 'package:flutter/material.dart';
import 'dart:ui';

class BlurredOverlay extends StatelessWidget {
  const BlurredOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter:
          ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Adjust blur intensity
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent, // Color with reduced opacity
      ),
    );
  }
}
