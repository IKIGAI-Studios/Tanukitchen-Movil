import 'package:tanukitchen/widgets/module_card_widget.dart';
import 'package:tanukitchen/models/module_model.dart';
import 'package:tanukitchen/db/mongodb.dart';
import 'package:flutter/material.dart';

class PanelPage extends StatefulWidget {
  const PanelPage({super.key});

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
            // SI TODO SALE BIEN: SÍ SCAFOL
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: const Color.fromRGBO(39, 47, 63, 1.0),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemBuilder: (context, index) {
                        print(snapshot.data);
                        return Padding(
                          padding: EdgeInsets.all(10.0),
                          child: ModuleCard(
                            module: Module.fromMap(snapshot.data[index]),
                          ),
                        );
                      },
                      itemCount: snapshot.data.length,
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
