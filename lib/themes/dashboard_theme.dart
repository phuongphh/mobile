import 'package:Adte/models/app_theme.dart';
import 'package:flutter/material.dart';

class DashboardTheme {
  DashboardTheme._();

  static dashboardPadding(BuildContext context) {
    return EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.03,
        right: MediaQuery.of(context).size.width * 0.03,
        top: MediaQuery.of(context).size.width * 0.02,
        bottom: MediaQuery.of(context).size.width * 0.02);
  }

  static const dashboardBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(8.0),
      bottomLeft: Radius.circular(8.0),
      bottomRight: Radius.circular(8.0),
      topRight: Radius.circular(68.0));

  static BoxShadow dashboardBoxShadow = BoxShadow(
      color: AppTheme.grey.withOpacity(0.2),
      offset: Offset(1.1, 1.1),
      blurRadius: 10.0);
}
