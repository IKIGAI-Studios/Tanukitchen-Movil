import 'package:tanukitchen/db/mongodb.dart';
import 'package:tanukitchen/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:tanukitchen/pages/modify_user_page.dart';

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
                      'assets/images/pfp.png',
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
                const SizedBox(
                  height: 7.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/images/edit.png'),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ModifyUserPage(user: user);
                        }));
                      },
                    ),
                    const SizedBox(width: 30.0),
                    IconButton(
                      icon: Image.asset('assets/images/delete.png'),
                      onPressed: () {
                        showDialog(
                          barrierColor: const Color.fromRGBO(39, 47, 63, .5),
                          context: context,
                          builder: (BuildContext context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: AlertDialog(
                                backgroundColor:
                                    const Color.fromRGBO(39, 47, 63, .7),
                                title: const Text(
                                  'Delete this user?',
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(217, 217, 217, 1.0)),
                                ),
                                content: const Text(
                                  'Everything about this user will be removed, including statistics',
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(217, 217, 217, 1.0)),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text(
                                      'Uh, never mind',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(6, 190, 182, 1.0),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context, 'home');
                                      await MongoDB.updateUserState(user!);
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 25.0,
        )
      ],
    );
  }
}
