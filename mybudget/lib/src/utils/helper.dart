import 'package:flutter/material.dart';

double getFont(context, {double scaleFactor = 1}) {
  double width = MediaQuery.of(context).size.shortestSide;
  if (width > 500) {
    return (width * 0.034) * scaleFactor;
  } else if (width > 400) {
    return (width * 0.04) * scaleFactor;
  } else {
    return (width * 0.036) * scaleFactor;
  }
}
