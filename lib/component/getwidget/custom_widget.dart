import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomWidget {

  void showToast({required BuildContext context, required String message, required Color backgroundColor, required IconData trailingIcon, GFToastPosition toastPosition = GFToastPosition.BOTTOM, double toastBorderRadius = 15.0, double fontSize = 20.0 }){
    GFToast.showToast(
        message,
        context,
        backgroundColor: backgroundColor,
        toastPosition: toastPosition,
        toastBorderRadius: toastBorderRadius,
        trailing: Icon(
          trailingIcon,
          color: Theme.of(context).colorScheme.primaryFixed,
          size: 35,
        ),
        textStyle: TextStyle(
          fontSize: fontSize,
          color: Theme.of(context).colorScheme.primaryFixed,
          fontWeight: FontWeight.bold
        )
    );
  }
}
