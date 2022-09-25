// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:taxidriver/screens/main_screen.dart';

import '../api/config_maps.dart';
import '../main.dart';
import 'signup_screen.dart';

class CarInfoScreen extends StatelessWidget {
  CarInfoScreen({Key? key}) : super(key: key);
  static const routeName = '/carinfo';
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController =
      TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/images/logo.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Enter Car Details',
                  style: TextStyle(fontSize: 24, fontFamily: 'Brand Bold'),
                ),
                const SizedBox(
                  height: 26,
                ),
                TextField(
                  controller: carModelTextEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Car Model',
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: carNumberTextEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Car Number',
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: carColorTextEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Car Color',
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (carModelTextEditingController.text.isEmpty) {
                      displayToastMessage('Please enter car model', context);
                    } else if (carNumberTextEditingController.text.isEmpty) {
                      displayToastMessage('Please enter car number', context);
                    } else if (carColorTextEditingController.text.isEmpty) {
                      displayToastMessage('Please enter car color', context);
                    } else {
                      saveCarInfo(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                    onPrimary: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Next',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Brand Bold',
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 26,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    ));
  }

  void saveCarInfo(context) {
    String userId = currentFirebaseUser!.uid;
    Map carInfoMap = {
      'car_model': carModelTextEditingController.text,
      'car_number': carNumberTextEditingController.text,
      'car_color': carColorTextEditingController.text,
    };
    driversRef.child(userId).child('car_details').set(carInfoMap);
    Navigator.pushNamedAndRemoveUntil(
        context, MainScreen.routeName, (route) => false);
  }
}
