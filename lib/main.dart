import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohar_version/bloc/app_bloc.dart';
import 'package:mohar_version/pages/home_page.dart';
import 'package:mohar_version/pages/login_page.dart';
import 'package:mohar_version/route.dart';

void main() async {
  // it initalize the native code
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    String? cid = _auth.currentUser?.uid;
    return BlocProvider(
        create: (context) => AppBloc()..add(InitialEvent()),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteHandler.generateRoute,
          home: InitPage(),
        ));
  }
}

class InitPage extends StatelessWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      if (state is MoharLoggedinState) {
        return const HomePage();
      }
      return const LoginPage();
    });
  }
}
