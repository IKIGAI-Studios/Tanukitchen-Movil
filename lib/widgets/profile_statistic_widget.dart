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
                    child:
                        _statisticsDetector(Module.fromMap(snapshot.data[1])),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child:
                        _statisticsExtractor(Module.fromMap(snapshot.data[4])),
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
      color: const Color.fromRGBO(217, 217, 217, 1.0),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Activations: ${stove.activations}',
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(39, 47, 63, 1.0)),
            ),
            FutureBuilder(
              future: MongoDB.avgValue(stove),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Average temperature detection: ${snapshot.data} C°',
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(39, 47, 63, 1.0)),
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error');
                } else {
                  return const Text('N/A');
                }
              },
            ),
            FutureBuilder(
              future: MongoDB.electricUsage(stove),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Average cost: \$${snapshot.data} mxn',
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(39, 47, 63, 1.0)),
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error');
                } else {
                  return const Text('N/A');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _statisticsDetector(Module detector) {
    return Card(
      color: const Color.fromRGBO(217, 217, 217, 1.0),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FutureBuilder(
                future: MongoDB.avgValue(detector),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Average smoke detection: ${snapshot.data}',
                      style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(39, 47, 63, 1.0)),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return const Text('N/A');
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget _statisticsExtractor(Module extractor) {
    return Card(
      color: const Color.fromRGBO(217, 217, 217, 1.0),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Activations: ${extractor.activations}',
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(39, 47, 63, 1.0)),
            ),
            Text(
              'Last Max duration: ${(extractor.maxduration!) / 60} minutes',
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(39, 47, 63, 1.0)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statisticsGeneral(User user) {
    return Card(
      color: const Color.fromRGBO(217, 217, 217, 1.0),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Completed recipes: ${user.recipes_completed}',
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(39, 47, 63, 1.0)),
            ),
            Text(
              'Last recipe completed: ${user.last_recipe}',
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(39, 47, 63, 1.0)),
            ),
            FutureBuilder(
                future: MongoDB.getFavorite(user),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Favorite recipe: ${snapshot.data}',
                      style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(39, 47, 63, 1.0)),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return const Text('N/A');
                  }
                }),
          ],
        ),
      ),
    );
  }
}
