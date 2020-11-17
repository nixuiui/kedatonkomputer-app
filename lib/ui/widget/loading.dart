import 'package:flutter/material.dart';

class LoadingCustom extends StatelessWidget {
  const LoadingCustom({
    Key key,
    this.color = Colors.white,
    this.size = 20
  }) : super(key: key);

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: Center(
          child: SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              backgroundColor: color,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.withOpacity(0.5)),
            ),
          ),
        ),
    );
  }
}