import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    Key? key,
    required this.title,
    required this.body,
    required this.actions,
    this.icon,
  }) : super(key: key);

  final String title;
  final String body;
  final List<Widget> actions;
  final String? icon;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: null,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(17),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (icon != null)
                  if (icon == 'success')
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/success_check_green.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                if (icon != null)
                  if (icon == 'email_sent')
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 70,
                        width: 110,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/email_sent.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                if (title.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    body,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: actions,
                )
              ],
            ),
          ),
        ),
      );

  static Future show(
    BuildContext context, {
    Key? key,
    required String title,
    required String body,
    String? icon,
    List<Widget>? actions,
  }) {
    bool barrierDismissible;

    if (actions == null || actions.isEmpty) {
      barrierDismissible = false;
    } else {
      barrierDismissible = true;
    }

    final AppDialog dialog = AppDialog(
      key: key,
      title: title,
      body: body,
      actions: actions!,
      icon: icon,
    );

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => dialog,
    );
  }
}
