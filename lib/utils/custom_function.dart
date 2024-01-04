import 'package:flutter/material.dart';

class CustomFunction{

  /// Custom EditTextView We are using for this particular product
  /// Here we need required parameters like editController,hintText.prefixIcon,formKey,headerText,isFieldEmpty,onFocusChange
  /// optional parameters validation,isPasswordType,suffixIcon
  ///
  /// on focus changed return true value when TextFormField is focused and unfocused
  static customEditText(
      {TextEditingController? editController,
        String? labelText,
        Key? formKey,
        bool? isFieldEmpty,
        String? Function(dynamic value)? validation,
        TextInputAction? textInputAction,
        TextInputType? inputType,
        bool? isPasswordType,
        String? hintText,
        bool? isRead,
        Widget? suffixIcon,
        String? prefixIcon,
        Null Function(bool)? onFocusChange,
        Null Function(dynamic value)? onChanged,
        String? initialValue}) {
    return Form(
      key: formKey,
      child: Focus(
        onFocusChange: onFocusChange,
        child: Container(
          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(16)),
          child: TextFormField(
            initialValue: initialValue,
            validator: validation,
            obscureText: isPasswordType ?? false,
            onChanged: onChanged,
            readOnly: isRead ?? false,
            cursorColor: Colors.black,
            cursorHeight: 15,
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
                hintText: hintText ?? "",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                suffix: suffixIcon,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                prefixIcon: prefixIcon != null
                    ? Padding(
                  padding: EdgeInsets.only(left: 15, right: 5),
                  child: Image.asset(
                    prefixIcon,
                    width: 24,
                    height: 24,
                    color: Colors.grey,
                  ),
                )
                    : null,
                prefixIconConstraints: BoxConstraints(maxWidth: 50),
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}