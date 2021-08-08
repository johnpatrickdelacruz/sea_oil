import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Colors.transparent,
        child: Container(
          margin: EdgeInsets.all(16.0),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                ),
                SizedBox(
                  width: 25.0,
                ),
                Text(
                  'Loading...',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future showLoading(
    BuildContext context, {
    Key? key,
  }) {
    final AppLoading dialog = AppLoading(
      key: key,
    );

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => dialog,
    );
  }
}
