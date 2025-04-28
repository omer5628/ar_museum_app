import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fontSize = 16,
    this.icon,                           // ⬅️ אייקון אופציונלי חדש
    this.iconSize = 20,
    this.iconColor,
  });

  final String label;
  final VoidCallback onPressed;
  final double fontSize;  
  final IconData? icon;                  // יכול להיות null
  final double iconSize; 
  final Color? iconColor;   

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            backgroundColor: const Color.fromARGB(255, 38, 2, 102),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: icon == null
              ? Text(label, style: TextStyle(fontSize: fontSize))
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 8),
                    Text(label, style: TextStyle(fontSize: fontSize)),
                    Icon(
                      icon,
                      size: iconSize,
                      color: iconColor ?? Colors.white, // ⬅️ צבע מפורש
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

