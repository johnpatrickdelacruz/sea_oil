import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sea_oil/networks/helpers/errors.dart';
import 'package:sea_oil/views/generic/dialogs/app_dialog.dart';
import 'package:sea_oil/views/generic/dialogs/app_loading.dart';
import 'package:sea_oil/views/widgets/app_button.dart';

import '../../../values/strings.dart' as strings;

/// The ErrorDialog class holds all error-related dialogs that may be triggered when the user encounters an error at any point
/// within the app.

class GenericDialog {
  static Future showDialog(
    BuildContext context, {
    Errors? error,
    VoidCallback? onPopModal,
  }) async {
    onPopModal ??= () async {
      Navigator.pop(context);
    };

    switch (error) {
      case Errors.NoNetwork:
        return _showErrorDialog(
          context,
          onPress: onPopModal,
          title: strings.dialogTitleUhoh,
          body: strings.errorNoInternet,
        );
      case Errors.UserNotRegistered:
        return _showErrorDialog(
          context,
          onPress: onPopModal,
          title: strings.dialogTitleUhoh,
          body: strings.userNotRegistered,
        );

      default:
        return _showErrorDialog(
          context,
          onPress: onPopModal,
          title: strings.dialogTitleUhoh,
          body: strings.errorGeneric,
        );
    }
  }

  static Future showLoadingDialog(BuildContext context) {
    return _showLoading(context);
  }

  static Future _showErrorDialog(
    BuildContext context, {
    Key? key,
    required VoidCallback onPress,
    required String title,
    required String body,
  }) async {
    return AppDialog.show(
      context,
      key: key,
      title: title,
      body: body,
      actions: [
        Expanded(
          child: AppButton(
            type: ButtonType.text,
            height: 40,
            label: strings.alertOk,
            onPress: onPress,
            textSize: 12,
            disabled: false,
          ),
        ),
      ],
    );
  }

  static Future _showLoading(
    BuildContext context, {
    Key? key,
  }) async =>
      AppLoading.showLoading(
        context,
        key: key,
      );
}
