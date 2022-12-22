import 'package:flutter/material.dart';
import 'package:partirecept/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final String? hint;
  final bool? obscure;
  final String? label;
  final FormFieldValidator<String>? validator;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final TextStyle? inputTextStyle;
  final Color? backgroundColor;

  CustomTextField(
      {Key? key,
      this.hint,
      this.obscure,
      this.validator,
      this.label,
      this.onSaved,
      this.onChanged,
      this.hintTextStyle,
      this.labelTextStyle,
      this.inputTextStyle,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(children: [
        TextFormField(
          onSaved: onSaved,
          onChanged: onChanged,
          validator: validator,
          autofocus: false,
          obscureText: obscure ?? false,
          style: inputTextStyle,
          decoration: InputDecoration(
            fillColor: backgroundColor,
            filled: true,
            hintStyle: hintTextStyle,
            hintText: hint,
            labelText: label,
            labelStyle: labelTextStyle,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: secondaryYellow, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ]),
    );
  }
}
