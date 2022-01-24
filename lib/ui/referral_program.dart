import 'package:flutter/material.dart';
import 'package:refer_n_earn/provider/user_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'widget/styled_text.dart';

class ReferralProgram extends StatelessWidget {
  ReferralProgram({Key? key}) : super(key: key);

  final List<String> faqs = [
    'What are the incentives for referring a friend?',
    'Is there any eligibility criteria for me to send to out invites ?',
    'When will I get my referral bonus?',
    'Where will I receive this bonus?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Referral Program'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Refer(),
            FAQ(faqs: faqs),
          ],
        ),
      ),
    );
  }
}

class Refer extends StatelessWidget {
  Refer({
    Key? key,
  }) : super(key: key);

  final String referText =
      "Hey, have you tried BHIVE.fund? I've been Investing with them and thought you'd love it too! \n\nBHIVE.fund is one of India's largest and fastest-growing investment platforms.\n\nInvesting with them is fast & easy.Click on the link to start Investing.\nhttps://www.refernearn.com/?${UserProvider.currentUser.referralCode}";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyledText(
          'Hey ${UserProvider.currentUser.name},',
          size: 30,
          weight: FontWeight.bold,
        ),
        const StyledText(
          'Refer Your Friend,',
          size: 25,
          weight: FontWeight.bold,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: InkWell(
              child: const Icon(
                Icons.share,
                size: 120,
              ),
              onTap: () {
                Share.share(referText);
              },
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
          thickness: 1,
        ),
      ],
    );
  }
}

class FAQ extends StatelessWidget {
  const FAQ({
    Key? key,
    required this.faqs,
  }) : super(key: key);

  final List<String> faqs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StyledText(
          'FAQ',
          size: 30,
          weight: FontWeight.bold,
        ),
        ...faqs
            .map((question) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: StyledText(
                    question,
                    align: TextAlign.center,
                    size: 18,
                  ),
                ))
            .toList(),
      ],
    );
  }
}
