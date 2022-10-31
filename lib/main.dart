import 'package:brace_mate/size.config.dart';
import 'package:brace_mate/src/screens/braces_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);

            return MaterialApp(
              title: 'Brace Mate',
              home: BracesScreen(),
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }
}
