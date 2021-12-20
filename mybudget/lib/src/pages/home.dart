import 'package:flutter/material.dart';
import 'package:mybudget/src/blocs/Provider.dart';
import 'package:mybudget/src/pages/widgets/action_buttons.dart';
import 'package:mybudget/src/pages/widgets/body.dart';
import 'package:mybudget/src/utils/colors.dart';
import 'package:provider/src/provider.dart';

class Home extends StatelessWidget {
  final appProvider;
  const Home({Key? key, required this.appProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          color: ThemeColors.yellow,
          child: Column(
            children: [
              ActionButtons(appProvider: appProvider),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Body(appProvider: appProvider),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
