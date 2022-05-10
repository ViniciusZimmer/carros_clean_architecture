import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool showProgress;

  const AppButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.showProgress = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const backgroundColor1 = Colors.orange;
    const backgroundColor2 = Colors.red;
    const textColor = Colors.white;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            colors: [backgroundColor1, backgroundColor2],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          ),
        ),
        child: showProgress
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: textColor,
                ),
              ),
      ),
    );
  }
}
