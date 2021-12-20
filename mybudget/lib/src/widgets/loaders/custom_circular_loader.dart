import 'package:flutter/material.dart';

class CustomCircularLoader extends StatelessWidget {
  const CustomCircularLoader({
    Key? key,
    this.size = 20.0,
    this.color = const Color(0xff387aff),
    this.strokeWidth = 2.0,
  }) : super(key: key);

  final double size, strokeWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ),
    );
  }
}
