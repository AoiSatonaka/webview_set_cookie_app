import 'package:flutter/material.dart';
import 'package:webview_set_cookie_app/input_page.dart';
import 'package:webview_set_cookie_app/webview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WebViewSetCookieApp",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/': (context) => const InputPage(),
        '/web': (context) => WebViewPage()
      },
      initialRoute: '/',
    );
  }
}
