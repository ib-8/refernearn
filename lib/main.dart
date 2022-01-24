import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refer_n_earn/data/repository/auth_repository.dart';
import 'package:refer_n_earn/data/repository/user_repository.dart';
import 'package:refer_n_earn/provider/auth_provider.dart';
import 'package:refer_n_earn/provider/referral_provider.dart';
import 'package:refer_n_earn/provider/user_provider.dart';
import 'package:refer_n_earn/ui/home.dart';
import 'package:refer_n_earn/ui/login.dart';
import 'package:refer_n_earn/ui/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late UserProvider userProvider;
  late AuthProvider authProAuthProvider;
  final UserRepository userRepository = UserRepository();

  @override
  void initState() {
    userProvider = UserProvider(userRepository: userRepository);
    authProAuthProvider = AuthProvider(
        authRepository: AuthRepository(), userProvider: userProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProAuthProvider),
        Provider(create: (_) => userProvider),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: "Refer 'n' Earn",
          theme: ThemeData(
            primarySwatch: Colors.amber,
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onGenerateRoute: (RouteSettings settings) {
            if (settings.name != null && settings.name != '/') {
              ReferralProvider.referralCode = settings.name!.split('?').last;
            }
            return MaterialPageRoute(
                builder: (_) => AppEntry(authProAuthProvider));
          },
        );
      },
    );
  }
}

class AppEntry extends StatefulWidget {
  const AppEntry(
    this.authProAuthProvider, {
    Key? key,
  }) : super(key: key);

  final AuthProvider authProAuthProvider;

  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (ReferralProvider.referralCode != null &&
            authProvider.authState == AuthState.unauthenticated) {
          return SignUp();
        }

        switch (authProvider.authState) {
          case AuthState.authenticated:
            return const Home();

          case AuthState.unauthenticated:
            return Login();

          case AuthState.loading:
          default:
            return const Material(
                child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
