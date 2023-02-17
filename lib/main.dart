import 'package:cultivoapp/screens/faq.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/onboarding_screen.dart';
import './screens/predict_screen.dart';
import './screens/best_value.dart';

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
      debugShowCheckedModeBanner: false,
      home: PredictionScreen(),
    );
  }
}
