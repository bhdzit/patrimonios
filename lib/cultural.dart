// ignore_for_file: file_names, unused_local_variable, unnecessary_new, curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hola_mundo/utils/lugar_info.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'package:hola_mundo/utils/utils.dart';



class Spacecraft {
  late final String idlugares;
  late final String Nombre,
      Categoria,
      Subcategoria,
      Ubicacion,
      Latitud,
      Longitud,
      Clima,
      Temperatura,
      PrecipitacionPluvial,
      Uso,
      Imagen,
      Sintesis,
      Extenso,
      Recorrido,
      urlExtenso;

  Spacecraft({
    required this.idlugares,
    required this.Nombre,
    required this.Categoria,
    required this.Subcategoria,
    required this.Ubicacion,
    required this.Latitud,
    required this.Longitud,
    required this.Clima,
    required this.Temperatura,
    required this.PrecipitacionPluvial,
    required this.Uso,
    required this.Imagen,
    required this.Sintesis,
    required this.Extenso,
    required this.Recorrido,
    required this.urlExtenso,
  });

  factory Spacecraft.fromJson(Map<String, dynamic> jsonData) {
    return Spacecraft(
        idlugares: jsonData['idlugares'],
        Nombre: jsonData['Nombre'],
        Categoria: jsonData['Categoria'],
        Subcategoria: jsonData['Subcategoria'],
        Ubicacion: jsonData['Ubicacion'],
        Latitud: jsonData['Latitud'],
        Longitud: jsonData['Longitud'],
        Clima: jsonData['Clima'],
        Temperatura: jsonData['Temperatura'],
        PrecipitacionPluvial: jsonData['PrecipitacionPluvial'],
        Uso: jsonData['Uso'],
        Imagen: "https://centrodeinformacion-isic-itsoeh.org.mx/" +
            jsonData['Imagen'],
        Sintesis: jsonData['Sintesis'],
        Extenso: jsonData['Extenso'],
        Recorrido: jsonData['Recorrido'],
        urlExtenso: jsonData['urlExtenso']);
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
    return new ListTile(
        title: new Card(
          elevation: 5.0,
          child: new Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  child: Image.network(spacecraft.Imagen),
                  padding: EdgeInsets.only(bottom: 8.0),
                ),
                Row(children: <Widget>[
                  Flexible(
                    child: Padding(
                        child: Text(
                          spacecraft.Nombre,
                          style: new TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                        padding: EdgeInsets.all(1.0)),
                  ),
                  Text(" | "),
                  Padding(
                      child: Text(
                        spacecraft.Ubicacion,
                        style: new TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)),
                ]),
              ],
            ),
          ),
        ),
        onTap: () {
          //We start by creating a Page Route.
          //A MaterialPageRoute is a modal route that replaces the entire
          //screen with a platform-adaptive transition.
          var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
                new LugarInfo(value: spacecraft),
          );
          //A Navigator is a widget that manages a set of child widgets with
          //stack discipline.It allows us navigate pages.
          Navigator.of(context).push(route);

        });
  }
}

//Future is n object representing a delayed computation.
Future<List<Spacecraft>> downloadJSON() async {
  try {
    const jsonEndpoint =
        "https://centrodeinformacion-isic-itsoeh.org.mx/php/index.php";

    final response = await get(Uri.parse(jsonEndpoint));
    List spacecrafts = json.decode(response.body);
    return spacecrafts
        .map((spacecraft) => new Spacecraft.fromJson(spacecraft))
        .toList();
  } catch (e) {
    throw Exception('error al obtener los datos.');
  }
}


class Culturales extends StatelessWidget {
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

void main() {
  runApp(Culturales());
}
//end
