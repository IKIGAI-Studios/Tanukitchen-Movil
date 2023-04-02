import 'package:tanukitchen/widgets/user_card_widget.dart';
import 'package:tanukitchen/models/user_model.dart';
import 'package:tanukitchen/pages/add_user_page.dart';
import 'package:tanukitchen/db/mongodb.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MongoDB.getUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // CIRCULITO QUE DA VUELTAS XD
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
            // SI  SALE BIEN: SÍ SCAFOL
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: const Color.fromRGBO(39, 47, 63, 1.0),
              ),
              body: Column(
                children: [
                  _createWelcome(context),
                  const Text(
                    "Who's cooking?",
                    style: TextStyle(
                        color: Color.fromRGBO(217, 217, 217, 1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 5),
                          child: UserCard(
                            user: User.fromMap(snapshot.data[index]),
                          ),
                        );
                      },
                      itemCount: snapshot.data.length,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return AddUserPage();
                      }));
                    },
                    icon: Image.asset('assets/images/add.png'),
                    tooltip: 'Add an user',
                    highlightColor: const Color.fromRGBO(6, 190, 182, .3),
                    splashColor: const Color.fromRGBO(6, 190, 182, .3),
                  )
                ],
              ),
            );
          }
        });
  }
}

// Welcome Banner
Widget _createWelcome(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 40.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage('assets/images/TakumiWinkWhite.png'),
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        const Text(
          'Welcome Back!',
          style: TextStyle(
              fontFamily: 'Somatic', color: Color.fromRGBO(217, 217, 217, 1.0)),
        ),
      ],
    ),
  );
}
