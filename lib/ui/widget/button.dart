import 'package:flutter/material.dart';

import 'loading.dart';

class RaisedButtonPrimary extends StatelessWidget {
  const RaisedButtonPrimary({
    Key key,
    this.text,
    this.onPressed,
    this.padding,
    this.fontSize,
    this.icon,
    this.radius,
    this.isLoading = false
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double padding;
  final double fontSize;
  final double radius;
  final IconData icon;
  final isLoading;

  @override
  Widget build(BuildContext context) {
    return RaisedButtonCustom(
      onPressed: onPressed,
      padding: padding,
      fontSize: fontSize,
      icon: icon,
      text: text,
      color: Colors.blue,
      iconColor: Colors.white,
      radius: radius,
      isLoading: isLoading
    );
  }
}

class RaisedButtonAccent extends StatelessWidget {
  const RaisedButtonAccent({
    Key key,
    this.text,
    this.onPressed,
    this.padding,
    this.fontSize,
    this.icon,
    this.isLoading = false
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double padding;
  final double fontSize;
  final IconData icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return RaisedButtonCustom(
      onPressed: onPressed,
      padding: padding,
      fontSize: fontSize,
      icon: icon,
      text: text,
      color: Colors.green,
      isLoading: isLoading
    );
  }
}

class OutlineButtonPrimary extends StatelessWidget {
  const OutlineButtonPrimary({
    Key key,
    this.text,
    this.onPressed,
    this.padding,
    this.fontSize,
    this.icon,
    this.radius,
    this.isLoading = false
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double padding;
  final double fontSize;
  final double radius;
  final IconData icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return RaisedButtonCustom(
      onPressed: onPressed,
      padding: padding,
      fontSize: fontSize,
      icon: icon,
      text: text,
      color: Colors.transparent,
      textColor: Colors.blue,
      borderColor: Colors.blue,
      radius: radius,
      isLoading: isLoading,
    );
  }
}

class RaisedButtonCustom extends StatelessWidget {
  const RaisedButtonCustom({
    Key key,
    this.text,
    this.onPressed,
    this.padding,
    this.fontSize,
    this.color,
    this.iconColor,
    this.borderColor,
    this.textColor = Colors.white,
    this.icon,
    this.elevation = 0,
    this.radius,
    this.isLoading = false
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double padding;
  final double fontSize;
  final Color color;
  final Color iconColor;
  final Color textColor;
  final Color borderColor;
  final IconData icon;
  final double elevation;
  final double radius;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 8),
        side: BorderSide(
          color: onPressed != null ? (borderColor ?? Colors.transparent) : Colors.transparent,
          width: 1
        ),
      ),
      disabledElevation: 0,
      padding: EdgeInsets.all(padding ?? 12),
      disabledColor: color == Colors.transparent ? Colors.grey[200] : Colors.grey[300],
      disabledTextColor: Colors.white,
      color: color ?? Colors.green,
      textColor: Colors.white,
      elevation: elevation,
      hoverElevation: elevation,
      focusElevation: elevation,
      highlightElevation: elevation,
      child: isLoading ? LoadingCustom(
        size: fontSize != null ? fontSize + 4 : 16
      ) : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon != null ? Container(
            margin: EdgeInsets.only(right: text != null ? 8 : 0),
            child: Icon(icon, color: iconColor ?? Colors.white, size: fontSize != null ? fontSize + 4 : 16),
          ) : Container(height: 0),
          Text(
            text ?? "", 
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: fontSize ?? 16,
              color: onPressed != null ? textColor : Colors.grey[700]
            )
          ),
        ],
      ),
    );
  }
}