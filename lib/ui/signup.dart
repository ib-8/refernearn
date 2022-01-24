import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:refer_n_earn/provider/auth_provider.dart';
import 'package:refer_n_earn/provider/referral_provider.dart';
import 'package:refer_n_earn/ui/widget/app_button.dart';
import 'package:refer_n_earn/ui/widget/input_field.dart';
import 'package:refer_n_earn/ui/widget/styled_text.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _signUp(AuthProvider authProvider) async {
    if (_emailController.text.trim().isNotEmpty &&
        _nameController.text.trim().isNotEmpty &&
        _passwordController.text.trim().isNotEmpty) {
      await authProvider.signUp(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        referralCode: _referralCodeController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      Fluttertoast.showToast(msg: 'Enter required details');
    }
  }

  @override
  Widget build(BuildContext context) {
    _referralCodeController.text = ReferralProvider.referralCode ?? '';
    var authProvider = Provider.of<AuthProvider>(context);

    return WillPopScope(
      onWillPop: () async => !authProvider.isLoading,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
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
                  'Sign Up',
                  size: 25,
                  weight: FontWeight.w500,
                ),
                InputField(
                  controller: _nameController,
                  hint: 'Name',
                ),
                InputField(
                  controller: _emailController,
                  hint: 'Email',
                ),
                InputField(
                  controller: _passwordController,
                  isPassword: true,
                  hint: 'Password',
                ),
                InputField(
                  controller: _referralCodeController,
                  hint: 'Referral Code',
                ),
                authProvider.isLoading
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : AppButton(
                        text: 'Sign Up',
                        onPressed: () => _signUp(authProvider),
                        absorb: authProvider.isLoading,
                      ),
                Center(
                  child: InkWell(
                    child: StyledText(
                      "Already have an account? Log-in",
                      size: 13,
                      color: Colors.grey[800]!,
                      decoration: TextDecoration.underline,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
