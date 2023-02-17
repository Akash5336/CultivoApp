import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/onboarding_screen.dart';
import './screens/predict_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PredictionScreen(),
    );
  }
}
