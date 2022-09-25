import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxidriver/api/config_maps.dart';
import 'package:taxidriver/screens/forgot_pass_screen.dart';
import 'package:taxidriver/screens/login_screen.dart';
import 'package:taxidriver/screens/main_screen.dart';
import 'package:taxidriver/screens/signup_screen.dart';
import 'package:taxidriver/screens/vehicle_info_screen.dart';

import 'data handler/app_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  currentFirebaseUser = FirebaseAuth.instance.currentUser;
  runApp(const MyApp());
}

DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('users');
DatabaseReference driversRef = FirebaseDatabase.instance.ref().child('drivers');
DatabaseReference? rideRequestRef = FirebaseDatabase.instance
    .ref()
    .child('drivers')
    .child(currentFirebaseUser!.uid)
    .child('newRide');

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Taxi Driver App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? LoginScreen.routeName
            : MainScreen.routeName,
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          SignupScreen.routeName: (context) => SignupScreen(),
          ForgotPassScreen.routeName: (context) => ForgotPassScreen(),
          MainScreen.routeName: (context) => MainScreen(),
          CarInfoScreen.routeName: (context) => CarInfoScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
