import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'app.dart';
import 'simple_bloc_observer.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  // Ensure the app runs in portrait mode only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Initialize Bloc observer
  Bloc.observer = SimpleBlocObserver();
  // Run the main app with the Firebase user repository
  runApp(MainApp(FirebaseUserRepository()));
}
