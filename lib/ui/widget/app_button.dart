import 'package:flutter/material.dart';
import 'package:refer_n_earn/ui/widget/styled_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.absorb = false,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final bool absorb;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: AbsorbPointer(
        absorbing: absorb,
        child: MaterialButton(
          color: Colors.amber,
          padding: const EdgeInsets.symmetric(vertical: 13),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StyledText(
                text,
                size: 20,
              ),
            ],
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
