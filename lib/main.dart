import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tanuktchen/pages/home_page.dart';
import 'package:tanuktchen/pages/panel_page.dart';
import 'package:flutter/material.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tanukitchen Movil',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('es', 'ES'),
      ],
      //home: HomePage(),
      initialRoute: 'home',
      routes: <String, WidgetBuilder>{
        'home': (BuildContext context) => HomePage(),
        'panel': (BuildContext context) => PanelPage(),
      },
    );
  }
}
