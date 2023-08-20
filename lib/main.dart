import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tanukitchen/pages/loading_page.dart';
import 'package:tanukitchen/db/mongodb.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDB.connect();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(39, 47, 63, 1.0),
        fontFamily: 'Manrope',
      ),
      title: 'Tanukitchen Movil',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      //home: HomePage(),
      initialRoute: 'home',
      routes: <String, WidgetBuilder>{
        'home': (BuildContext context) => LoadingScreen(),
      },
    );
  }
}
