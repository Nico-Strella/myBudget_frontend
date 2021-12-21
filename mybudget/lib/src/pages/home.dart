import 'package:flutter/material.dart';
import 'package:mybudget/src/pages/widgets/action_buttons.dart';
import 'package:mybudget/src/pages/widgets/body.dart';
import 'package:mybudget/src/pages/widgets/sub_action_buttons.dart';
import 'package:mybudget/src/utils/colors.dart';

class Home extends StatelessWidget {
  final appProvider;
  final BuildContext ctx;
  Home({Key? key, required this.appProvider, required this.ctx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(20),
          color: ThemeColors.yellow,
          child: Column(
            children: [
              ActionButtons(appProvider: appProvider),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Body(appProvider: appProvider),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    SubActionButtons(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
