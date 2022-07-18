import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mohar_version/animation/profile.dart';
import 'package:mohar_version/models/data_model.dart';
import 'package:mohar_version/pages/landing_scrren.dart';
import 'package:mohar_version/pages/price_screen.dart';
import 'package:mohar_version/pages/profile_screen.dart';
import 'package:mohar_version/pages/status_screen.dart';
import 'package:http/http.dart' as http;
import 'package:mohar_version/widget/stream_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = "/Home-Page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  String? stored;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Data? recieveData;
  bool showData = false;
  bool hasData = false;
  Future<String> getJsonFromFirebaseAPI() async {
    String url =
        "https://mohar-dae91-default-rtdb.asia-southeast1.firebasedatabase.app//users.json";
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  int selectedIndex = 0;
  late final PageController _pageController = PageController();
  List<Widget> screen(Data aa) => [
        LandingScreen(receivedData: aa),
        PriceScreen(receivedData: aa),
        StatusScreen(receivedData: aa),
        ProfilePage(receivedData: aa)
      ];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await getJsonFromFirebaseAPI();

    setState(() {
      hasData = true;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String uid = _auth.currentUser!.uid;
    return Scaffold(
      key: _bottomNavigationKey,
      extendBody: true,
      body: !hasData
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder(
              stream: FirebaseDatabase.instance.ref("users/$uid").onValue,
              //initialData: 0,

              builder: (
                BuildContext context,
                AsyncSnapshot<DatabaseEvent> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: const Text('waiting'));
                } else if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    recieveData = Data.fromDatabaseEvent(snapshot.data!);

                    return PageView(
                      physics: const NeverScrollableScrollPhysics(),

                      controller: _pageController,
                      children: screen(recieveData!),
                      onPageChanged: (index) {
                        selectedIndex = index;
                     
                      },
                   
                    );
                  }
                }
                return Center(
                    child: const Text('Kina bigriyo malai ni thaha chaina'));
              }),
      bottomNavigationBar: CurvedNavigationBar(
        index: selectedIndex,
        color: const Color.fromRGBO(224, 224, 224, 1),
        height: 65.0,
        buttonBackgroundColor: Colors.blue[400],
        backgroundColor: Colors.transparent,
        items: const [
          Icon(
            Icons.home,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            Icons.compost_outlined,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            Icons.stacked_line_chart_sharp,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            Icons.account_circle_outlined,
            size: 25,
            color: Colors.black,
          ),
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
     
        },
      ),
    );
  }
}
