import 'package:flutter/material.dart';

Color hexToColor({required String colorCode}) {
  return Color(
    int.parse(colorCode.substring(0, 6), radix: 16) + 0xFF000000,
  );
}

num calculateDiscount({required num discountPercentage, required num price}) {
  num percentage = discountPercentage ?? 0;
  num discountedPrice = price * (1 - (percentage / 100));
  return discountedPrice;
}

void showSnackbar({
  required BuildContext context,
  required String content,
  required Color color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
  ));
}

final RegExp emailRegex = RegExp(
  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
);
