
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/register_screen.dart';
import 'package:todo/auth/user_provider.dart';

import '../firebase_utils.dart';
import '../home_screen.dart';
import '../tabs/tasks/default_elevated_button.dart';
import '../tabs/tasks/default_text_form_field.dart';
import '../theme.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Login",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: AppTheme.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.png"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back!",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 16,
                ),
                DefaultTextFormField(
                  labelText: "Email",
                  controller: emailController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Email cannott be empty';
                    }
                    return null;
                  },
                ),
                DefaultTextFormField(
                  labelText: "Password",
                  validator: (p1) {
                    if (p1 == null || p1.isEmpty) {
                      return 'Password cannott be empty';
                    } else if (p1.length < 6) {
                      return 'should be at least 6 charcters';
                    }
                    return null;
                  },
                  controller: passwordController,
                  isPassword: true,
                ),
                SizedBox(
                  height: 16,
                ),
                DefaultElevatedButton(
                    onPress: login,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Log In",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: AppTheme.white, fontSize: 14),
                          ),
                        ),
                        const Spacer(
                          flex: 8,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: AppTheme.white,
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(RegisterScreen.routeName);
                    },
                    child: Text(
                      'Or Create My Account',
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState?.validate() == true) {
      FirebaseUtils.logIn(
        email: emailController.text,
        password: passwordController.text,
      ).then((user) {
        Provider.of<UserProvider>(context, listen: false).updateUser(user);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }).catchError((error) {
        if (error is FirebaseAuthException && error.message != null) {
          Fluttertoast.showToast(
              msg: error.message!, toastLength: Toast.LENGTH_LONG);
        } else {
          Fluttertoast.showToast(
              msg: 'something went wrong $error',
              toastLength: Toast.LENGTH_LONG);
        }
      });
    }
  }
}
