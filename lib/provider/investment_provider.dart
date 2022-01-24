import 'package:refer_n_earn/data/repository/investment_repository.dart';
import 'package:refer_n_earn/provider/referral_provider.dart';
import 'package:refer_n_earn/provider/user_provider.dart';

class InvestmentProvider {
  static final InvestmentRepository _investmentRepository =
      InvestmentRepository();
  static Future invest(int price) async {
    var data = {
      'propertyName': 'Myntra',
      'price': price,
    };
    await _investmentRepository.invest(UserProvider.currentUser.id, data);
    if (UserProvider.currentUser.referralCode != null) {
      await ReferralProvider.updateReferral(price);
    }
  }
}
