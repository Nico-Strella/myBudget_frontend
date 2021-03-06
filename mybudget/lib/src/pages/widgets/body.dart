import 'package:flutter/material.dart';
import 'package:mybudget/src/blocs/app_provider.dart';
import 'package:mybudget/src/pages/widgets/custom_list_item.dart';
import 'package:mybudget/src/utils/colors.dart';
import 'package:mybudget/src/widgets/expandable/expandable.dart';
import 'package:mybudget/src/widgets/loaders/custom_circular_loader.dart';

class Body extends StatefulWidget {
  final AppProvider appProvider;
  const Body({Key? key, required this.appProvider}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      widget.appProvider.init();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CustomCircularLoader(size: 20)
        : Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              color: ThemeColors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Expandable(
                    text: 'Income',
                    appProvider: widget.appProvider,
                    child: widget.appProvider.incomeList.isNotEmpty
                        ? Center(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext ctxt, int index) {
                                return CustomListItem(item: widget.appProvider.incomeList[index], index: index, type: "income");
                              },
                              itemCount: widget.appProvider.incomeList.length,
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                              child: Text('No Incomes', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expandable(
                    text: 'Outcome',
                    appProvider: widget.appProvider,
                    child: widget.appProvider.outcomeList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext ctxt, int index) {
                              return CustomListItem(item: widget.appProvider.outcomeList[index], index: index, type: "outcome");
                            },
                            itemCount: widget.appProvider.outcomeList.length,
                          )
                        : const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                              child: Text('No Outcomes', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
  }
}
