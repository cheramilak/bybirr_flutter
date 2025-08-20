import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bybirr_flutter/main.dart';
import 'package:flutter/material.dart';

void showErrorSnackbar(String message) {
  if (scaffoldMessengerKey.currentState != null) {
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  } else {
    print('ScaffoldMessengerState is not available.');
  }
}

void showSuccessSnackbar(String message) {
  if (scaffoldMessengerKey.currentState != null) {
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  } else {
    print('ScaffoldMessengerState is not available.');
  }
}

void showErrorMessage(String? title, String message) {
  if (scaffoldMessengerKey.currentState != null) {
    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,

      content: AwesomeSnackbarContent(
        title: title ?? 'Error',
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    ));
  } else {
    print('ScaffoldMessengerState is not available.');
  }
}

void showSuccessMessage(String title, String message) {
  if (scaffoldMessengerKey.currentState != null) {
    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,

      content: AwesomeSnackbarContent(
        title: title,
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
      ),
    ));
  } else {
    print('ScaffoldMessengerState is not available.');
  }
}
