import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings(
      {super.key,
      required this.height,
      required this.width,
      required this.closeCallback});

  final double height;
  final double width;
  final void Function() closeCallback;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final titleTextStyle = Theme.of(context).textTheme.displayMedium!.copyWith(
          color: colorScheme.onSecondary,
          fontWeight: FontWeight.bold,
        );
    final bodyTextStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: colorScheme.onSecondary,
        );

    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Stack(
        children: [
          Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Settings title
              Container(
                padding: const EdgeInsets.only(
                    top: 32, bottom: 32), // Adjust top and bottom padding
                child: Center(
                  child: Text(
                    'Settings',
                    style: titleTextStyle,
                  ),
                ),
              ),

              // Settings content
              Align(
                alignment: Alignment.center,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: 5, // Number of Text widgets
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8), // Add vertical spacing
                  itemBuilder: (context, index) {
                    return Text(
                      'This is where the settings will go.',
                      textAlign: TextAlign.center,
                      style: bodyTextStyle,
                    );
                  },
                ),
              ),
            ],
          )),

          // Close button
          Positioned(
            top: 32, // Adjust the top positioning as needed
            right: 28, // Adjust the right positioning as needed
            child: FloatingActionButton(
              onPressed: widget.closeCallback,
              backgroundColor: Colors.transparent,
              elevation: 0,
              hoverElevation: 0,
              shape: const CircleBorder(),
              child: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
