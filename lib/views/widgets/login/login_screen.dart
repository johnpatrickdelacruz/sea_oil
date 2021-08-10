import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sea_oil/blocs/login/login.export.dart';
import 'package:sea_oil/blocs/login/login_bloc.dart';
import 'package:sea_oil/blocs/navigation/navigation_bloc.dart';
import 'package:sea_oil/blocs/navigation/navigation_event.dart';
import 'package:sea_oil/views/generic/base_page.dart';
import 'package:sea_oil/views/generic/dialogs/generic_dialog.dart';
import 'package:sea_oil/views/widgets/app_button.dart';

import 'package:sea_oil/views/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameField = TextEditingController();

  TextEditingController _passwordField = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameField.dispose();
    _passwordField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginProgress) {
          GenericDialog.showLoadingDialog(context);
        } else if (state is LoginUserSuccess) {
          BlocProvider.of<NavigationBloc>(context).add(
            NavigationToLanding(),
          );
        } else if (state is LoginFailure) {
          GenericDialog.showDialog(context, error: state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BasePage(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Center(
                      child:
                          Image.asset('assets/price_locq_logo.png', height: 50),
                    ),
                    const SizedBox(height: 50),
                    InputField(
                      controller: _usernameField,
                      hintText: 'Enter your username',
                      icon: Icon(
                        Icons.person,
                        color: Colors.purple,
                      ),
                      labelText: 'Username',
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      controller: _passwordField,
                      hintText: 'Enter your password',
                      icon: Icon(
                        Icons.lock,
                        color: Colors.purple,
                      ),
                      labelText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 50),
                    Container(
                      width: size.width,
                      child: AppButton(
                          label: 'Log in',
                          onPress: () {
                            BlocProvider.of<LoginBloc>(context).add(
                              LoginUser(
                                  username: _usernameField.text.trim(),
                                  password: _passwordField.text.trim(),
                                  context: context),
                            );
                          },
                          height: 50,
                          type: ButtonType.withBackground,
                          disabled: false),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
