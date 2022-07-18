import 'package:flutter/material.dart';
import 'package:mohar_version/models/next_page_view.dart';
import 'package:mohar_version/pages/google_signin.dart';
import 'package:mohar_version/pages/home_page.dart';
import 'package:mohar_version/pages/login_page.dart';
import 'package:mohar_version/pages/next_page.dart';
import 'package:mohar_version/pages/selfie_page.dart';
import 'package:mohar_version/pages/signup_page.dart';

class RouteHandler {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Object? arguments = settings.arguments;
    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (context) => const LoginPage());
         case HomePage.routeName:
        return MaterialPageRoute(builder: (context) => const HomePage());
         case SelfieClick.routeName:
        return MaterialPageRoute(builder: (context) =>  SelfieClick(ar: arguments as NextArgument,));
         case NextPage.routeName:
        return MaterialPageRoute(builder: (context) =>  NextPage(arguments:arguments as NextPageViewModel));
         case SignupPage.routeName:
        return MaterialPageRoute(builder: (context) => const SignupPage());
        case GoogleSignin.routeName:
        return MaterialPageRoute(builder: (context) =>  GoogleSignin(
          arguments: arguments as ScreenArguments,
        ));
        default:
        return MaterialPageRoute(builder: (context) => const LoginPage());
    }
  }
}
