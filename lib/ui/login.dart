import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refer_n_earn/provider/auth_provider.dart';
import 'package:refer_n_earn/ui/signup.dart';
import 'package:refer_n_earn/ui/utils/routes.dart';
import 'package:refer_n_earn/ui/widget/app_button.dart';
import 'package:refer_n_earn/ui/widget/input_field.dart';
import 'package:refer_n_earn/ui/widget/styled_text.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 70.0),
                child: Center(
                  child: StyledText(
                    "Refer 'n' Earn",
                    color: Colors.amber,
                    size: 40,
                    weight: FontWeight.w500,
                  ),
                ),
              ),
              const StyledText(
                'Log In',
                size: 25,
                weight: FontWeight.w500,
              ),
              InputField(
                controller: _emailController,
                hint: 'Enter email',
              ),
              InputField(
                controller: _passwordController,
                isPassword: true,
                hint: 'Enter password',
              ),
              authProvider.isLoading
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : AppButton(
                      text: 'Log in',
                      absorb: authProvider.isLoading,
                      onPressed: () => authProvider.signIn(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      ),
                    ),
              Center(
                child: InkWell(
                  child: StyledText(
                    "Don't have an account? Sign-up",
                    size: 13,
                    color: Colors.grey[800]!,
                    decoration: TextDecoration.underline,
                  ),
                  onTap: () {
                    AppRoute.push(context, const SignUp());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
