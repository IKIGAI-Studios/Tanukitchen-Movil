import 'package:flutter/material.dart';
import 'package:tanukitchen/models/user_model.dart';
import 'package:tanukitchen/pages/panel_page.dart';

class UserCard extends StatelessWidget {
//  const UserCard({super.key});
  UserCard({required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15.0,
      shadowColor: Color.fromRGBO(22, 36, 44, 1),
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.70,
                    child: Image(
                      image: AssetImage('assets/images/TakumiWinkWhite.png'),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.user,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Text(
                          user.name,
                          style: const TextStyle(fontSize: 10),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return PanelPage(user: user);
                          }));
                        },
                        color: Color.fromRGBO(6, 190, 182, 1.0),
                        icon: const ImageIcon(
                          AssetImage('assets/images/enter.png'),
                        ),
                        tooltip: 'Enter',
                        highlightColor: const Color.fromRGBO(6, 190, 182, .3),
                        splashColor: const Color.fromRGBO(6, 190, 182, .3),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
