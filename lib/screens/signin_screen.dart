import 'package:e_shop/core/theme.dart';
import 'package:e_shop/models/user.dart';
import 'package:e_shop/providers/user_provider.dart';
import 'package:e_shop/screens/widgets/textfield.dart';
import 'package:e_shop/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future _handleSignUp() async {
    String? result =
        await Provider.of<UserProvider>(context, listen: false).userSignIn(
      user: UserModel(
        email: _emailController.text,
        password: _passwordController.text,
        name: "",
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
                      : Text("Login");
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
                  "New here?",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                Gap(3),
                InkWell(
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, '/signup'),
                  child: Text(
                    "Signup",
                    style: TextStyle(
                      color: ThemeConstants.blueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
