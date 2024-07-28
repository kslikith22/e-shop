import 'package:e_shop/core/theme.dart';
import 'package:flutter/material.dart';

Widget textField({required TextEditingController textController,required String hintText}) {
  return TextField(
    controller: textController,
    autofocus: false,
    style: TextStyle(fontSize: 14.0, color: ThemeConstants.grayDark),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
