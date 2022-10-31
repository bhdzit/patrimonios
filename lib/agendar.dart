// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hola_mundo/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';

class Spacecraft {
  late final String nombreVisita, lugar, fecha_creacion, clima, temp;
  Spacecraft(
      {required this.nombreVisita,
      required this.lugar,
      required this.fecha_creacion,
      required this.clima,
      required this.temp});

  factory Spacecraft.fromJson(Map<String, dynamic> jsonData) {
    return Spacecraft(
        nombreVisita: jsonData['nombreVisita'],
        lugar: jsonData['ubicacion'],
        fecha_creacion: jsonData['fecha'],
        clima: jsonData['clima'],
        temp: jsonData['temp']);
  }
}

class CustomListView extends StatelessWidget {
  final List<Spacecraft> spacecrafts;
  CustomListView(this.spacecrafts);

  Widget build(context) {
    return ListView.builder(
      itemCount: spacecrafts.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(spacecrafts[currentIndex], context);
      },
    );
  }

  Widget createViewItem(Spacecraft spacecraft, BuildContext context) {
    return new AgendaCard(spacecraft);
  }
}

//Future is n object representing a delayed computation.
Future<List<Spacecraft>> downloadJSON() async {
  final prefs = await SharedPreferences.getInstance();

// Intenta leer datos de la clave del contador. Si no existe, retorna 0.
  final String counter =  prefs.getString('idusuario') ?? "";
  print(counter);
  try {
    var jsonEndpoint =
        "https://centrodeinformacion-isic-itsoeh.org.mx/php/app_consultarVisitas.php?idUsuario="+counter;

    final response = await get(Uri.parse(jsonEndpoint));
    List spacecrafts = json.decode("[" + response.body + "]");
    List newJson = spacecrafts[0]["datos"];
    print(newJson);
    newJson.map((item) => {print("asdasd")});
    print(newJson);
    return newJson
        .map((spacecraft) => new Spacecraft.fromJson(spacecraft))
        .toList();
  } catch (e) {
    print("asdas");
    print(e);
    throw Exception('error al obtener los datos.');
  }
}

class agendar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return (Container(
      child: Center(
        //FutureBuilder is a widget that builds itself based on the latest snapshot
        // of interaction with a Future.
        child: new FutureBuilder<List<Spacecraft>>(
          future: downloadJSON(),
          //we pass a BuildContext and an AsyncSnapshot object which is an
          //Immutable representation of the most recent interaction with
          //an asynchronous computation.
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              List<Spacecraft>? spacecrafts = snapshot.data;
              return new CustomListView(spacecrafts!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            //return  a circular progress indicator.
            return const CircularProgressIndicator();
          },
        ),
      ),
    ));
  }
}
