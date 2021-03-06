import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indonesia/indonesia.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({
    Key key,
    this.text
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 12, color: Colors.black54));
  }
}

class TextFieldBox extends StatelessWidget {
  const TextFieldBox({
    Key key, 
    this.icon, 
    this.isObsecure = false, 
    this.textHint,
    this.validatorText = "",
    this.inputType = TextInputType.text,
    this.controller, 
    this.validator,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,
    this.textColor,
    this.inputFormatters,
    this.fontSize,
    this.inputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.enable = true,
    this.onChanged
  }) : super(key: key);

  final TextEditingController controller;
  final String textHint, validatorText;
  final IconData icon;
  final bool isObsecure;
  final bool enable;
  final TextInputType inputType;
  final FormFieldValidator<String> validator;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final int fontSize;
  final List<TextInputFormatter> inputFormatters;
  final FocusNode focusNode;
  final TextInputAction inputAction;
  final Function(String) onChanged;
  final Function(String) onFieldSubmitted;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? Colors.grey[300]),
            color: backgroundColor ?? Colors.grey[100],
            borderRadius: BorderRadius.circular(8)
          ),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            textInputAction: inputAction,
            onFieldSubmitted: onFieldSubmitted,
            inputFormatters: inputFormatters,
            cursorColor: textColor ?? Colors.black87,
            enabled: enable,
            onChanged: onChanged,
            style: TextStyle(
              color: enable ? (textColor ?? Colors.black87) : Colors.grey, 
              fontSize: fontSize ?? 16,
              fontWeight: FontWeight.w600
            ),
            obscureText: isObsecure,
            keyboardType: inputType,
            validator: validator,
            decoration: InputDecoration(
              icon: icon != null ? Icon(icon, color: iconColor ?? Colors.black12) : null,
              hintText: textHint,
              border: InputBorder.none,
              hintStyle: TextStyle(color: textColor != null ? textColor.withOpacity(0.5) : Colors.black38, fontSize: fontSize ?? 14),
              contentPadding: icon != null ? EdgeInsets.all(0) : EdgeInsets.symmetric(horizontal: 8, vertical: 0)
            ),
          ),
        ),
        validatorText != null && validatorText != "" ? Container(
          padding: EdgeInsets.only(top: 4, left: 4, right: 4),
          child: Text(validatorText, style: TextStyle(color: Colors.red, fontSize: 12)),
        ) : Container()
      ],
    );
  }
}

class TextFieldFullWidth extends StatelessWidget {
  const TextFieldFullWidth({
    Key key,
    this.icon,
    this.isObsecure = false,
    this.textHint,
    this.validatorText = "",
    this.inputType = TextInputType.text,
    this.controller, 
    this.validator,
    this.inputAction,
    this.onFieldSubmitted,
    this.focusNode
  }) : super(key: key);

  final TextEditingController controller;
  final String textHint, validatorText;
  final IconData icon;
  final bool isObsecure;
  final TextInputType inputType;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  final TextInputAction inputAction;
  final Function(String) onFieldSubmitted;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              textInputAction: inputAction,
              onFieldSubmitted: onFieldSubmitted,
              keyboardType: inputType,
              cursorColor: Colors.black54,
              style: TextStyle(color: Colors.black87),
              obscureText: isObsecure,
              validator: validator,
              decoration: InputDecoration(
                icon: icon != null ? Icon(icon, color: Colors.black54, size: 18) : null,
                hintText: textHint,
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black38),
                contentPadding: EdgeInsets.all(0)
              ),
            ),
          ),
        ),
        validatorText != null && validatorText != "" ? Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[100],
          child: Text(
            validatorText,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12
            ),
          )
        ) : Container(),
        Divider()
      ],
    );
  }
}

class TextFieldBorderBottom extends StatelessWidget {
  const TextFieldBorderBottom({
    Key key,
    this.icon,
    this.suffixIcon,
    this.maxLength,
    this.isObsecure = false,
    this.textHint,
    this.validatorText = "",
    this.inputType = TextInputType.text,
    this.controller, 
    this.validator,
    this.inputAction,
    this.fontWeight,
    this.onFieldSubmitted,
    this.enable = true,
    this.autofocus = false,
    this.focusNode,
    this.onChanged,
    this.inputFormatters
  }) : super(key: key);

  final TextEditingController controller;
  final String textHint, validatorText;
  final IconData icon;
  final IconData suffixIcon;
  final int maxLength;
  final bool isObsecure;
  final bool enable;
  final bool autofocus;
  final FontWeight fontWeight;
  final FocusNode focusNode;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FormFieldValidator<String> validator;
  final Function(String) onFieldSubmitted;
  final Function(String) onChanged;
  final List<TextInputFormatter> inputFormatters;
  
  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> formaters = [];
    formaters.add(LengthLimitingTextInputFormatter(maxLength));
    if(inputFormatters != null) {
      formaters.addAll(inputFormatters);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 40,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    inputFormatters: formaters,
                    controller: controller,
                    focusNode: focusNode,
                    textInputAction: inputAction,
                    onFieldSubmitted: onFieldSubmitted,
                    onChanged: onChanged,
                    keyboardType: inputType,
                    cursorColor: Colors.black54,
                    enabled: enable,
                    autofocus: autofocus,
                    style: TextStyle(color: enable ? Colors.black87 : Colors.grey, fontWeight: fontWeight ?? FontWeight.w600),
                    obscureText: isObsecure,
                    validator: validator,
                    decoration: InputDecoration(
                      icon: icon != null ? Icon(icon, color: Colors.black54, size: 18) : null,
                      hintText: textHint,
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.black38),
                      contentPadding: EdgeInsets.all(0)
                    ),
                  ),
                ),
                suffixIcon != null ? Icon(suffixIcon, color: Colors.black54) : Container()
              ],
            ),
          ),
        ),
        validatorText != null && validatorText != "" ? Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[100],
          child: Text(
            validatorText,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12
            ),
          )
        ) : Container(),
        Divider()
      ],
    );
  }
}

class TextAreaBorderBottom extends StatelessWidget {
  const TextAreaBorderBottom({
    Key key,
    this.icon,
    this.suffixIcon,
    this.maxLength = 100,
    this.maxLines = 10,
    this.minLines = 1,
    this.isObsecure = false,
    this.textHint,
    this.validatorText = "",
    this.inputType = TextInputType.text,
    this.controller, 
    this.validator,
    this.inputAction,
    this.fontWeight,
    this.onFieldSubmitted,
    this.enable = true,
    this.autofocus = false,
    this.focusNode,
    this.onChanged,
    this.inputFormatters
  }) : super(key: key);

  final TextEditingController controller;
  final String textHint, validatorText;
  final IconData icon;
  final IconData suffixIcon;
  final int maxLength;
  final int maxLines;
  final int minLines;
  final bool isObsecure;
  final bool enable;
  final bool autofocus;
  final FontWeight fontWeight;
  final FocusNode focusNode;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FormFieldValidator<String> validator;
  final Function(String) onFieldSubmitted;
  final Function(String) onChanged;
  final List<TextInputFormatter> inputFormatters;
  
  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> formaters = [];
    formaters.add(LengthLimitingTextInputFormatter(maxLength));
    if(inputFormatters != null) {
      formaters.addAll(inputFormatters);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: TextFormField(
              cursorColor: Colors.black54,
              style: TextStyle(color: Colors.black87),
              maxLength: maxLength,
              inputFormatters: formaters,
              controller: controller,
              focusNode: focusNode,
              textInputAction: inputAction,
              onFieldSubmitted: onFieldSubmitted,
              onChanged: onChanged,
              enabled: enable,
              autofocus: autofocus,
              maxLines: 10,
              minLines: 3,
              obscureText: isObsecure,
              validator: validator,
              decoration: InputDecoration(
                icon: icon != null ? Icon(icon, color: Colors.black54, size: 18) : null,
                hintText: textHint,
                suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.black54, size: 18) : null,
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black38),
                contentPadding: EdgeInsets.all(0)
              ),
            ),
          )
        ),
        validatorText != null && validatorText != "" ? Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[100],
          child: Text(
            validatorText,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12
            ),
          )
        ) : Container(),
        Divider()
      ]
    );
  }
}

class SelectionBorderBottom extends StatelessWidget {
  const SelectionBorderBottom({
    Key key,
    this.child,
    this.useIcon = true,
    this.onTap
  }) : super(key: key);

  final Widget child;
  final bool useIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: child),
            useIcon ? Icon(Icons.arrow_drop_down) : Container()
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]))
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class RupiahTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: rupiah(newValue.text),
      selection: newValue.selection,
    );
  }
}