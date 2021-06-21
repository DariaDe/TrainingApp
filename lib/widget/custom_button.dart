import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    this.buttonSize = 40.0,
    this.iconSize = 15.0,
    this.onButtonTap,
    @required this.icon,
    this.padding,
  }) : super(key: key);

  final double buttonSize;
  final double iconSize;
  final VoidCallback onButtonTap;
  final IconData icon;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: buttonSize, minWidth: buttonSize),
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFBEBAB3), width: 1.0),
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(100.0),
          onTap: onButtonTap,
          child: Padding(
            padding: padding == null
                ? const EdgeInsets.all(4.0)
                : const EdgeInsets.all(15.0),
            child: Icon(
              icon,
              size: iconSize,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
