import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projects/cart_page.dart';
import 'package:projects/app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: const MyApp(),
    ),
  );
}