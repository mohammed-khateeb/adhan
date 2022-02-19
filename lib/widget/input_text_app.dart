import 'package:flutter/material.dart';

class InputTextApp extends StatelessWidget {
  final TextInputType? keyboardType;
  final Color? borderColor;
  final String? prefixText;
  final String? errorText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;

  final TextEditingController? controller;

  final EdgeInsets? margin;

  final double? width;
  final double? borderRadius;

  final String? hintText;

  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Function? onTap;
  final Function? onComplete;

  final FormFieldValidator<String>? validator;

  final bool? readOnly;

  final bool obscureText;

  const InputTextApp({
    Key? key,
    this.keyboardType,
    this.borderColor,
    this.prefixText,
    this.suffixIcon,
    this.controller,
    this.margin,
    this.width,
    this.hintText,
    this.textAlign,
    this.textDirection,
    this.onTap,
    this.readOnly , this.obscureText = false, this.validator, this.errorText, this.onChanged, this.onComplete, this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius??4.0),
        elevation: 3,
        child: TextFormField(
          onEditingComplete:()=> onComplete,
          onTap:()=> onTap,
          keyboardType: keyboardType,
          controller: controller,
          readOnly: readOnly ?? false,
          autofocus: false,
          validator: validator,
          obscureText: obscureText,
          onChanged: onChanged,
          textAlign: textAlign ?? TextAlign.start,
          maxLines: keyboardType == TextInputType.multiline? null : 1,
          textDirection: textDirection ?? TextDirection.ltr,
          decoration:  InputDecoration(
            labelText: hintText,
            border:  OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(borderRadius??8.0),
            ),
            enabledBorder:  OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1
              ),
              borderRadius: BorderRadius.circular(borderRadius??4.0),
            ),
            filled: true,
            hintText: hintText,
            fillColor: Colors.white,
            errorText: errorText,
            prefixText: prefixText,
            contentPadding: const EdgeInsets.only(left: 10.0,bottom: 4.0,top: 4.0,right: 8.0),
            suffixIcon: suffixIcon,
          ),
        ),
      ),

    );

  }
}
