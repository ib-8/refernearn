import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refer_n_earn/provider/auth_provider.dart';
import 'package:refer_n_earn/provider/user_provider.dart';
import 'package:refer_n_earn/ui/property_detail.dart';
import 'package:refer_n_earn/ui/referral_program.dart';
import 'package:refer_n_earn/ui/referral_dashboard.dart';
import 'package:refer_n_earn/ui/utils/routes.dart';
import 'package:refer_n_earn/ui/widget/app_button.dart';
import 'package:refer_n_earn/ui/widget/styled_text.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _authProvider = Provider.of<AuthProvider>(context);
    var _currentUser = UserProvider.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Refer 'n' Earn"),
        actions: [
          IconButton(
            onPressed: () {
              AppRoute.push(context, const PropertyDetail());
            },
            icon: const Icon(Icons.location_city),
          ),
          IconButton(
            onPressed: () {
              _authProvider.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledText(
                  'Hey ${_currentUser.name},',
                  size: 30,
                  weight: FontWeight.bold,
                ),
                const SizedBox(height: 20),
                const StyledText(
                  "Why don't you introduce us to your friends?",
                  size: 22,
                ),
                const SizedBox(height: 20),
                const StyledText(
                  "Invite a friend to invest on BHive.fund and get a cashback equal to 1% of their investment",
                  size: 22,
                ),
              ],
            ),
            Column(
              children: [
                AppButton(
                  text: 'Refer a Friend',
                  onPressed: () {
                    AppRoute.push(context, ReferralProgram());
                  },
                ),
                AppButton(
                  text: 'Referral Dashboard',
                  onPressed: () {
                    AppRoute.push(context, const ReferralDashboard());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
