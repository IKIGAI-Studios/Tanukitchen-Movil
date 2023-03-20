import 'package:tanukitchen/widgets/module_card_widget.dart';
import 'package:tanukitchen/models/user_model.dart';
import 'package:tanukitchen/pages/profile_page.dart';
import 'package:tanukitchen/models/module_model.dart';
import 'package:tanukitchen/db/mongodb.dart';
import 'package:flutter/material.dart';

class PanelPage extends StatefulWidget {
  final String user;
  const PanelPage({Key? key, required this.user}) : super(key: key);

  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MongoDB.getModules(),
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
            return Container(
              child: Column(children: [
                Image.asset('assets/images/TakumiSeatedBlue.png'),
                const Text(
                    'Lo sentimos, ocurrió un error. Inténtalo más tarde.'),
              ]),
            );
          } else {
            // SI SALE BIEN: SÍ SCAFOL
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: const Color.fromRGBO(39, 47, 63, 1.0),
                title: const Text(
                  'tanukitchen',
                  style: TextStyle(
                      fontFamily: 'Somatic',
                      color: Color.fromRGBO(217, 217, 217, 1.0)),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => MyProfile()),
                      );
                    },
                    child: Row(
                      children: [
                        Text(widget.user),
                        const Padding(
                          padding: EdgeInsets.only(left: 15, right: 16),
                          child: CircleAvatar(
                            backgroundColor: Color.fromRGBO(217, 217, 217, 1.0),
                            backgroundImage: AssetImage(
                              'assets/images/TakumiSeated.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Text(
                    'Control Panel',
                    style: TextStyle(
                        color: Color.fromRGBO(217, 217, 217, 1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        print(snapshot.data[index]);
                        return ModuleCard(
                          module: Module.fromMap(snapshot.data[index + 1]),
                        );
                      },
                      itemCount: snapshot.data.length - 1,
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
