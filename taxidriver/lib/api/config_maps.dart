import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxidriver/models/all_users.dart';

String mapKey = "AIzaSyAVzHRpu-fHMIGB2qXloAJi2chRJpGqSJU";

User? firebaseUser;

Users userCurrentInfo = Users();

User? currentFirebaseUser;

StreamSubscription<Position>? homeStreamSubscription;
