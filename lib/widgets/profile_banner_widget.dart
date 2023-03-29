import 'package:tanukitchen/db/mongodb.dart';
import 'package:tanukitchen/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tanukitchen/pages/home_page.dart';

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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /* TextButton(
                      child: const Text(
                        '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(89, 120, 221, 0.911),
                            fontSize: 15.0),
                      ),
                      onPressed: () {},
                    ),*/
                    TextButton(
                      child: const Text(
                        'Delete',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(219, 65, 65, 1),
                            fontSize: 15.0),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: AlertDialog(
                                title: Text('Eliminar usuario'),
                                content: Text(
                                    '¿Estás seguro de que deseas eliminar este usuario?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Eliminar'),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context, 'home');
                                      await MongoDB.updateUserState(user!);
                                    },
                                    style: TextButton.styleFrom(
                                      primary: Colors.red,
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
        SizedBox(
          height: 25.0,
        )
      ],
    );
  }
}
