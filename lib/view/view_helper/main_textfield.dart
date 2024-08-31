import 'package:flutter/material.dart';

import '../../model/services/localization/app_localization.dart';
import '../styles/app_colors.dart';


enum Validator {
  required,
  email,
  mobile,
  password,
  number,
  isMatch,
  minLength,
  maxLength,
}

class MainTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final Widget? icon;
  final bool isObscure;
  final bool isReadOnly;
  final bool isAutofocus;
  final bool isFilled;
  final Color? fillColor;
  final int maxLines;
  final double letterSpacing;
  final double borderRadius;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Validator? validator;
  final String? matchedValue;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final Function()? onTap;
  final Function(PointerDownEvent? x)? onTapOutSide;
  final Function(String? x)? onSubmit;
  final Function(String? x)? onChanged;

  const MainTextField({
    Key? key,
    this.controller,
    this.hint,
    this.label,
    this.icon,
    this.isObscure = false,
    this.isReadOnly = false,
    this.isAutofocus = false,
    this.isFilled = true,
    this.fillColor = AppColors.formFill,
    this.maxLines = 1,
    this.letterSpacing = 0,
    this.borderRadius = 10,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.matchedValue,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.contentPadding,
    this.onTap,
    this.onSubmit,
    this.onChanged,
    this. onTapOutSide
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    // var tempFocusNode;
    //  focusNode ==null? tempFocusNode = FocusNode(): tempFocusNode = focusNode;
    return TextFormField(
      onTapOutside: onTapOutSide,
      onFieldSubmitted: onSubmit,
      controller: controller,
      cursorWidth: 1.5,
      cursorColor: Colors.red,
      cursorRadius: const Radius.circular(5),
      obscureText: isObscure,
      readOnly: isReadOnly,
      keyboardType: keyboardType,
      style: TextStyle(fontFamily: "effra_Rg",fontSize: 16, letterSpacing: letterSpacing),
      maxLines: maxLines,
      autofocus: isAutofocus,
      // focusNode: tempFocusNode,
      focusNode: focusNode,
      onTap: onTap,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        filled: isFilled,
        fillColor: fillColor,
        focusColor: Colors.teal,
        icon: icon,
        hintText: hint,
        labelText: label,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintStyle: const TextStyle(fontFamily: "effra_Rg",
          fontSize: 15,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
        ),
        labelStyle: const TextStyle(fontFamily: "effra_Rg",
          // color: AppColors.primaryColor,
          //  color:   tempFocusNode.hasFocus ? AppColors.primaryColor : Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
        ),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        // enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        // focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color:  Colors.grey.shade300, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
               BorderSide(color:  Colors.grey.shade300, width: 1.2),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        // in case text field has error and focused in the same time
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        switch (validator) {
          ///============================================================================ [Required]
          case Validator.required:
            if (value!.trim().isEmpty) {
              return locale.get('Required');
            }
            return null;

          ///============================================================================ [Email]
          case Validator.email:
            RegExp regExp = RegExp(
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                r"{0,253}[a-zA-Z0-9])?)*$");
            if (value!.trim().isEmpty) {
              return locale.get('Please enter email address');
            } else if (!regExp.hasMatch(value)) {
              return locale.get('Please enter valid email address');
            }
            return null;

          ///============================================================================ [Mobile]
          case Validator.mobile:
            RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,14}$)');
            if (value!.trim().isEmpty) {
              return locale.get('Please enter mobile number');
            } else if (!regExp.hasMatch(value)) {
              return locale.get('Please enter valid mobile number');
            }
            return null;

          ///============================================================================ [Number]
          case Validator.number:
            double? number = double.tryParse(value!);
            if (value.trim().isEmpty) {
              return locale.get('Required');
            } else if (number == null) {
              return locale.get('Please enter valid number');
            }
            return null;

          ///============================================================================ [Password]
          case Validator.password:
            if (value!.trim().isEmpty) {
              return locale.get('Please enter your password');
            } else if (value.length < 8) {
              return locale.get('Password is at least 8 Char');
            }
            return null;

          ///============================================================================ [MinLength]
          case Validator.minLength:
            if (value!.trim().isEmpty) {
              return locale.get('Required');
            } else if (value.length < 8) {
              return locale.get('Minimum length is 8 characters');
            }
            return null;

          ///============================================================================ [MaxLength]
          case Validator.maxLength:
            if (value!.trim().isEmpty) {
              return locale.get('Required');
            } else if (value.length > 12) {
              return locale.get('Maximum length is 12 characters');
            }
            return null;

          ///============================================================================ [IsMatch]
          case Validator.isMatch:
            if (value!.isEmpty || value != matchedValue) {
              return locale.get('كلمة المرور غير متطابقة');
            }
            return null;

          default:
            return null;
        }
      },

      onChanged: onChanged,
    );
  }
}
