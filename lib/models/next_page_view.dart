import 'package:mohar_version/pages/google_signin.dart';
import 'package:mohar_version/pages/signup_page.dart';

enum SignupType { google, normal }

class NextPageViewModel {
  SignupType signupType;
  GoogleArguments? gogArguments;
  SignupArguments? signupArguments;

  NextPageViewModel({
    required this.signupType,
    this.gogArguments,
    this.signupArguments,
  });
}
