import 'package:flutter/material.dart';
import 'package:unsplashgallery/constants.dart';

import 'pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      home: MainPage(title: APP_NAME),
    );
  }
}