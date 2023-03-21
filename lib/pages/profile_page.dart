import 'package:tanukitchen/widgets/profile_statistic_widget.dart';
import 'package:tanukitchen/widgets/profile_banner_widget.dart';
import 'package:tanukitchen/widgets/profile_tabbar_widget.dart';
import 'package:tanukitchen/models/user_model.dart';
import 'package:tanukitchen/db/mongodb.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  final User user;
  const MyProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
        future: MongoDB.getUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(6, 190, 182, 1.0),
                backgroundColor: Color.fromRGBO(39, 47, 63, 1.0),
              ),
            );

            // TAKITO MAN
          } else if (snapshot.hasError) {
            return Column(children: [
              Image.asset('assets/images/TakumiSeatedBlue.png'),
              const Text('Lo sentimos, ocurrió un error. Inténtalo más tarde.'),
            ]);
          } else {
            // SI SALE BIEN: SÍ SCAFOL
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: const Color.fromRGBO(39, 47, 63, 1.0),
                title: const Text(
                  'Go back',
                  style: TextStyle(
                      fontFamily: 'Somatic',
                      color: Color.fromRGBO(217, 217, 217, 1.0)),
                ),
              ),
              body: Column(children: [
                const SizedBox(
                  height: 25.0,
                ),
                const Text(
                  'My profile',
                  style: TextStyle(
                    color: Color.fromRGBO(217, 217, 217, 1.0),
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
                ProfileBanner(
                    screenWidth: _screenSize.width, user: widget.user),
                ProfileTabBar(user: widget.user),
              ]),
            );
          }
        });
  }
}
