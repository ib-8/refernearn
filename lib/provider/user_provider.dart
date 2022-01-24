import 'package:refer_n_earn/data/model/user.dart';
import 'package:refer_n_earn/data/repository/user_repository.dart';

class UserProvider {
  final UserRepository userRepository;
  static late User currentUser;

  UserProvider({required this.userRepository});

  Future getCurrentUser(String uid) async {
    currentUser = await userRepository.getUser(uid);
  }

  Future createUser(User user) async {
    currentUser = user;
    await userRepository.createUser(user);
  }
}
