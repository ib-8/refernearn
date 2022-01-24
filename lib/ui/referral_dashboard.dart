import 'package:flutter/material.dart';
import 'package:refer_n_earn/data/model/referral.dart';
import 'package:refer_n_earn/provider/referral_provider.dart';
import 'package:refer_n_earn/ui/widget/styled_text.dart';

class ReferralDashboard extends StatelessWidget {
  const ReferralDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Referral Dashboard'),
      ),
      body: FutureBuilder<List<Referral>>(
        future: ReferralProvider.getReferrals(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: StyledText('No referrals!'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                RewardSummary(snapshot.data!),
                ReferralList(snapshot.data!),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RewardSummary extends StatelessWidget {
  const RewardSummary(
    this.referrals, {
    Key? key,
  }) : super(key: key);

  final List<Referral> referrals;

  @override
  Widget build(BuildContext context) {
    double reward = 0;

    for (var referral in referrals) {
      reward += referral.reward;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StyledText(
                  'Your Rewards',
                  size: 25,
                  weight: FontWeight.bold,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const StyledText(
                          'Total Cash Earned!',
                          weight: FontWeight.bold,
                        ),
                        StyledText(
                          '₹ ${reward.toStringAsFixed(0)}',
                          size: 30,
                          weight: FontWeight.bold,
                        )
                      ],
                    ),
                    const Icon(
                      Icons.emoji_events,
                      size: 100,
                      color: Colors.amberAccent,
                    )
                  ],
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -12),
            child: Column(
              children: [
                const Divider(color: Colors.black, height: 0, thickness: 1),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                      child: StyledText(
                        'View Payment History',
                        size: 20,
                      ),
                    ),
                    Center(child: Icon(Icons.keyboard_arrow_right))
                  ],
                ),
                const Divider(color: Colors.black, height: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReferralList extends StatelessWidget {
  const ReferralList(this.referrals, {Key? key}) : super(key: key);

  final List<Referral> referrals;

  @override
  Widget build(BuildContext context) {
    List<Map> dataList = [];
    List<String> column = ['Name', 'Reward', 'Investment Status'];

    for (var referral in referrals) {
      var map = referral.toMap();
      map.remove('id');
      dataList.add(map);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const StyledText(
              'Your Referrals',
              size: 25,
              weight: FontWeight.bold,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 0,
              color: Colors.amber,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: StyledText('Remind All Pending'),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: column.map((e) => DataColumn(label: Text(e))).toList(),
            rows: dataList
                .map(
                  (data) => DataRow(
                    cells:
                        data.values.map((e) => DataCell(Text('$e'))).toList(),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
