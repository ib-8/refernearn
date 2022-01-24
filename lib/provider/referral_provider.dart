import 'package:refer_n_earn/data/model/referral.dart';
import 'package:refer_n_earn/data/model/user.dart';
import 'package:refer_n_earn/data/repository/referral_repository.dart';
import 'package:refer_n_earn/provider/user_provider.dart';

class ReferralProvider {
  static final ReferralRepository _referralRepository = ReferralRepository();
  static String? referralCode;

  static Future<List<Referral>> getReferrals() async {
    return await _referralRepository.getReferrals(UserProvider.currentUser.id);
  }

  static Future<User?> getReferrar(code) async {
    return await _referralRepository.checkReferralCode(code);
  }

  static Future<void> addReferral(User referrar) async {
    var referral = Referral(
      name: UserProvider.currentUser.name,
      id: UserProvider.currentUser.id,
      reward: 0,
    );
    await _referralRepository.addReferral(
        referrarId: referrar.id, referral: referral);
    referralCode = null;
  }

  static Future<void> updateReferral(int price) async {
    await _referralRepository.updateReferral(
      referrarId: UserProvider.currentUser.referrarId!,
      currentUserId: UserProvider.currentUser.id,
      data: {
        'reward': price / 100,
        'investmentStatus': 'Myntra',
      },
    );
  }
}
