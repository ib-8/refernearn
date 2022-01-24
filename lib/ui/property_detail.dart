import 'package:flutter/material.dart';
import 'package:refer_n_earn/provider/investment_provider.dart';
import 'package:refer_n_earn/ui/widget/app_button.dart';
import 'package:refer_n_earn/ui/widget/styled_text.dart';

class PropertyDetail extends StatefulWidget {
  const PropertyDetail({Key? key}) : super(key: key);

  @override
  State<PropertyDetail> createState() => _PropertyPropertyDescriptiontate();
}

class _PropertyPropertyDescriptiontate extends State<PropertyDetail> {
  final int price = 1000000;
  bool isLoading = false;
  String status = 'Invest';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PropertyHeader(price.toString()),
            const PropertyDescription(),
            const Spacer(),
            isLoading
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : AppButton(
                    text: status,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await InvestmentProvider.invest(price);
                      setState(() {
                        status = 'Invested';
                        isLoading = false;
                      });
                    }),
          ],
        ),
      ),
    );
  }
}

class PropertyDescription extends StatelessWidget {
  const PropertyDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        StyledText(
          'Property Details',
          size: 20,
          weight: FontWeight.bold,
        ),
        SizedBox(height: 10),
        StyledText(
            '''This is one of the most vibrant office spaces in Indiranagar . This high ceiling building is the ideal example of a managed office space solution. Each floor at this Coworking has a different story to tell – while one greets you with the fresh whiff of filter coffee, the other will offer you a comfortable lounge adorned with greens.'''),
      ],
    );
  }
}

class PropertyHeader extends StatelessWidget {
  const PropertyHeader(
    this.price, {
    Key? key,
  }) : super(key: key);

  final String price;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Placeholder(fallbackHeight: 180),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: StyledText('₹ $price', size: 25, weight: FontWeight.bold),
        ),
        const Divider(),
      ],
    );
  }
}
