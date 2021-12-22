import 'package:flutter/material.dart';
import 'package:mybudget/src/blocs/app_provider.dart';
import 'package:mybudget/src/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'My Budget',
        debugShowCheckedModeBanner: false,
        home: Consumer<AppProvider>(
          builder: (ctx, provider, child) => Home(appProvider: provider),
        ),
      ),
    ),
  );
}
