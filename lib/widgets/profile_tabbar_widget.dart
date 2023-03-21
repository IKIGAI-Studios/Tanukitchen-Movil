import 'package:tanukitchen/models/user_model.dart';
import 'package:tanukitchen/widgets/profile_statistic_widget.dart';
import 'package:tanukitchen/db/mongodb.dart';
import 'package:flutter/material.dart';

class ProfileTabBar extends StatefulWidget {
  const ProfileTabBar({required this.user, super.key});
  final User user;
  @override
  State<ProfileTabBar> createState() => _ProfileTabBarState();
}

class _ProfileTabBarState extends State<ProfileTabBar> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * .5,
      child: DefaultTabController(
        length: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TabBar(
                labelColor: const Color.fromRGBO(6, 190, 182, 1.0),
                indicatorColor: const Color.fromRGBO(6, 190, 182, 1.0),
                dividerColor: const Color.fromRGBO(6, 190, 182, 1.0),
                unselectedLabelColor: const Color.fromRGBO(217, 217, 217, 1),
                indicatorPadding: EdgeInsets.only(
                    left: _screenSize.width * .1,
                    right: _screenSize.width * .1),
                indicatorWeight: 3.0,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.normal),
                tabs: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tab(
                          icon: Image.asset(
                            'assets/images/stove_white.png',
                            width: _screenSize.width * .10,
                          ),
                          text: 'Stove',
                        ),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tab(
                          icon: Image.asset(
                            'assets/images/smoke_detector_white.png',
                            width: _screenSize.width * .10,
                          ),
                          text: 'S. Detector',
                        ),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tab(
                          icon: Image.asset(
                            'assets/images/extractor_white.png',
                            width: _screenSize.width * .10,
                          ),
                          text: 'S. Extractor',
                        ),
                      ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Tab(
                        icon: Image.asset(
                          'assets/images/recipes_white.png',
                          width: _screenSize.width * .10,
                        ),
                        text: 'General',
                      ),
                    ],
                  ),
                ]),
            StatisticsViews(user: widget.user),
          ],
        ),
      ),
    );
  }
}
