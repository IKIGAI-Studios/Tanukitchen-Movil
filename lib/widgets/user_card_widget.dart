import 'package:flutter/material.dart';
import 'package:tanukitchen/models/user_model.dart';

class UserCard extends StatelessWidget {
//  const UserCard({super.key});
  UserCard({required this.user, required this.onTapDelete});
  final User user;
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
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
                    children: [
                      Text(
                        '${user.name}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        '${user.type}',
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const ImageIcon(
                          AssetImage('assets/images/enter.png'),
                        ),
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
