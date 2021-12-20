import 'package:flutter/material.dart';
import 'package:mybudget/src/blocs/provider.dart';
import 'package:mybudget/src/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Budget',
      debugShowCheckedModeBanner: false,
      home: Consumer<AppProvider>(
        builder: (context, provider, child) => Home(
          appProvider: provider,
        ),
      ),
    );
  }
}
