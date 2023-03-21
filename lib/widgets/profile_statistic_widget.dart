import 'package:tanukitchen/db/mongodb.dart';
import 'package:tanukitchen/models/module_model.dart';
import 'package:tanukitchen/models/user_model.dart';
import 'package:flutter/material.dart';

class StatisticsViews extends StatefulWidget {
  const StatisticsViews({required this.user, super.key});
  final User user;
  @override
  State<StatisticsViews> createState() => _StatisticsViewsState();
}

class _StatisticsViewsState extends State<StatisticsViews> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
        future: MongoDB.getModules(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // CIRCULITO QUE DA VUELTAS XD
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(6, 190, 182, 1.0),
                backgroundColor: Color.fromRGBO(39, 47, 63, 1.0),
              ),
            );
          }
          // TAKITO MAN
          else if (snapshot.hasError) {
            return Container(
              child: Column(children: [
                Image.asset('assets/images/TakumiSeatedBlue.png'),
                const Text(
                    'Lo sentimos, ocurrió un error. Inténtalo más tarde.'),
              ]),
            );
          } else {
            // SI  SALE BIEN: SÍ SCAFOL

            return Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: _statisticsStove(Module.fromMap(snapshot.data[3])),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: _statisticsDetector(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: _statisticsExtractor(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: _statisticsGeneral(widget.user),
                  ),
                ],
              ),
            );
          }
        });
  }

  Widget _statisticsStove(Module stove) {
    return Card(
      child: Column(
        children: [Text(stove.name)],
      ),
    );
  }

  Widget _statisticsDetector() {
    return Card(
      child: Column(
        children: [Text('detecotr')],
      ),
    );
  }

  Widget _statisticsExtractor() {
    return Card(
      child: Column(
        children: [Text('Extractor')],
      ),
    );
  }

  Widget _statisticsGeneral(User user) {
    return Card(
      child: Column(
        children: [Text('General'), Text(user.name)],
      ),
    );
  }
}
