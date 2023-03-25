import 'package:tanukitchen/models/user_model.dart';
import 'package:flutter/material.dart';

class ProfileBanner extends StatelessWidget {
  ProfileBanner({this.screenWidth, this.user});
  final double? screenWidth;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${user!.age} y/o',
                    style: const TextStyle(
                        color: Color.fromRGBO(217, 217, 217, 1.0),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Age',
                    style: TextStyle(
                      color: Color.fromRGBO(217, 217, 217, .5),
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/pfp.jpg',
                      height: screenWidth! * .25,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${user!.gender}',
                    style: const TextStyle(
                        color: Color.fromRGBO(217, 217, 217, 1.0),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Gender',
                    style: TextStyle(
                      color: Color.fromRGBO(217, 217, 217, .5),
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  user!.user,
                  style: const TextStyle(
                      color: Color.fromRGBO(6, 190, 182, 1.0),
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Text(
                  user!.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color.fromRGBO(217, 217, 217, 0.5),
                      fontSize: 15.0),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 25.0,
        )
      ],
    );
  }
}
