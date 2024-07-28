import 'package:e_shop/core/theme.dart';
import 'package:e_shop/models/user.dart';
import 'package:e_shop/providers/user_provider.dart';
import 'package:e_shop/screens/widgets/textfield.dart';
import 'package:e_shop/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future _handleSignUp() async {
    String? result =
        await Provider.of<UserProvider>(context, listen: false).userSignUp(
      user: UserModel(
        email: _emailController.text,
        name: _nameController.text,
        password: _passwordController.text,
        uid: '',
      ),
    );
    if (result == null) return;
    if (result != 'success') {
      showSnackbar(
        context: context,
        content: result.toString(),
        color: Colors.red,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.snow,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ThemeConstants.snow,
        foregroundColor: ThemeConstants.blueColor,
        title: Text(
          "e-shop",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<UserProvider>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textField(
                    textController: _nameController, hintText: "Name"),
              ),
              if (value.nameError)
                Text(
                  "\t\tEnter valid name",
                  style: TextStyle(color: Colors.red),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textField(
                    textController: _emailController, hintText: "Email"),
              ),
              if (value.emailError)
                Text(
                  "\t\tEnter valid email",
                  style: TextStyle(color: Colors.red),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textField(
                    textController: _passwordController, hintText: "Password"),
              ),
              if (value.passwordError)
                Text(
                  "\t\tEnter valid password",
                  style: TextStyle(color: Colors.red),
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
          height: MediaQuery.of(context).size.height * 0.2,
          color: ThemeConstants.snow,
          surfaceTintColor: ThemeConstants.snow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _handleSignUp();
                },
                child: Consumer<UserProvider>(
                  builder: (context, value, child) {
                    return value.isLoading
                        ? SizedBox(
                            height: 28,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text("Signup");
                  },
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeConstants.blueColor,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontWeight: FontWeight.w500),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                ),
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  Gap(3),
                  InkWell(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/signin'),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: ThemeConstants.blueColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
