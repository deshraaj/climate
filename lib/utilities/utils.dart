import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void fieldFocus(
      BuildContext context, FocusNode currentFocus, FocusNode? nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}
