import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final bool loading;
  final bool disabled;
  final VoidCallback? onPressed;
  const AppButton({super.key, required this.label, required this.loading, required this.disabled, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(
        onPressed: loading || disabled ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(loading) const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: Colors.black38,
                strokeWidth: 2.5,
              ),
            ),
            if(loading) const SizedBox(width: 12,),
            Text(label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        )
      ),
    );
  }
}
