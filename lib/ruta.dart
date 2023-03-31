// ignore_for_file: file_names, deprecated_member_use, unnecessary_new

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' show get;
import 'package:maps_launcher/maps_launcher.dart';

class Patrimonio {
  late final String idLugares, Nombre;

  late final double Latitud, Longitud;

  Patrimonio({
    required this.idLugares,
    required this.Nombre,
    required this.Latitud,
    required this.Longitud,
  });

  factory Patrimonio.fromJson(Map<String, dynamic> jsonData) {
    return Patrimonio(
      idLugares: jsonData['idLugares'],
      Nombre: jsonData['Nombre'],
      Latitud: double.parse(jsonData['Latitud']),
      Longitud: double.parse(jsonData['Longitud']),
    );
  }
}

List<Patrimonio> list = [];
GoogleMapController? mapController; //contrller for Google map
late Patrimonio selectedValue;

Set<Marker> markers = Set(); //markers for google map
var mymarkers = [];

LatLng loc1 = const LatLng(27.6602292, 85.308027);
LatLng loc2 = const LatLng(27.6599592, 85.3102498);

Future<List<Patrimonio>> downloadJSON() async {
  try {
    const jsonEndpoint =
        "https://centrodeinformacion-isic-itsoeh.org.mx/php/app_consultarPatrimonios.php";

    final response = await get(Uri.parse(jsonEndpoint));
    List spacecrafts = json.decode("[" + response.body + "]");
    List patrimonios = spacecrafts[0]["patrimonios"];
    list = patrimonios.map((spacecraft) {
      return new Patrimonio.fromJson(spacecraft);
    }).toList();

    return list;
  } catch (e) {
    throw Exception('error al obtener los datos.' + e.toString());
  }
}

class Ruta extends StatefulWidget {
  const Ruta({Key? key}) : super(key: key);

  @override
  _RutaState createState() => _RutaState();
}

class _RutaState extends State<Ruta> {
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
  }

  callback(value) {
    setState(() {
      _addPoint(selectedValue.Latitud, selectedValue.Longitud);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(children: <Widget>[
        Container(
          height: 650,
          child: GoogleMap(
            // ignore: prefer_const_constructors
            initialCameraPosition: CameraPosition(
              target: const LatLng(20.2699077, -99.2293205),
              zoom: 11.0,
            ),
            markers: markers,
            onMapCreated: _onMapCreated,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(242, 242, 242, 1),
          ),
          child: Column(children: [
            const Text(
              'Selecciona un lugar para trazar ruta',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromRGBO(55, 71, 79, 1)),
              textAlign: TextAlign.right,
            ),
            Container(
                height: 50,
                margin: const EdgeInsets.only(top: 5, left: 25, right: 25),
                child: FutureBuilder<List<Patrimonio>>(
                  future: downloadJSON(),
                  //we pass a BuildContext and an AsyncSnapshot object which is an
                  //Immutable representation of the most recent interaction with
                  //an asynchronous computation.
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButtonExample(callback);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    //return  a circular progress indicator.
                    return const CircularProgressIndicator();
                  },
                )),
            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 10),
              padding:
                  const EdgeInsets.only(top: 4, left: 10, right: 10, bottom: 4),
              child: new RaisedButton(
                color: Colors.green,
                elevation: 10,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0)),
                onPressed: () async {
                  _launchUrl();
                },
                child: const Center(
                    child: Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                  ),
                  child: Text("RUTA"),
                )),
              ),
            ),
          ]),
        )
      ]),
    ));
  }

  Future<void> _addPoint(lat, lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14));
    setState(() {
      markers.clear();
      markers.add(Marker(
        markerId: const MarkerId("marker2"),
        position: LatLng(lat, lng),
      ));
    });
  }

  Future<void> _launchUrl() async {
    MapsLauncher.launchCoordinates(
        selectedValue.Latitud, selectedValue.Longitud);
  }
}

class DropdownButtonExample extends StatefulWidget {
  Function(String) callback;
  DropdownButtonExample(this.callback);

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  Patrimonio dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue.Nombre,
      isExpanded: true,
      underline: Container(
        height: 2,
        color: Colors.green,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.

        setState(() {
          dropdownValue =
              list.where((element) => element.Nombre == value).first;
          selectedValue = dropdownValue;
          _RutaState()._addPoint(dropdownValue.Latitud, dropdownValue.Longitud);
          widget.callback("se cambio ");
        });
      },
      items: list.map<DropdownMenuItem<String>>((Patrimonio value) {
        return DropdownMenuItem<String>(
          value: value.Nombre,
          child: Text(value.Nombre + "/ " + value.idLugares),
        );
      }).toList(),
    );
  }
}




/*GoogleMap(
initialCameraPosition: CameraPosition(
target: LatLng(double.parse('20.2699077'),
double.parse('-99.2293205')),
zoom: 11.0,
),
markers: {
Marker(
markerId: const MarkerId("marker2"),
position: const LatLng(20.2699077, -99.2293205),
),
},
),



Center(
        child: Column(
      children: <Widget>[
        Container(
          height: 650,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: loc1,
              zoom: 11.0,
            ),
            markers: markers,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(children: [
            Text(
              'Selecciona un lugar para trazar ruta',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromRGBO(55, 71, 79, 1)),
              textAlign: TextAlign.right,
            ),
            Container(
                height: 50,
                margin: const EdgeInsets.only(top: 5, left: 25, right: 25),
                child: new FutureBuilder<List<Patrimonio>>(
                  future: downloadJSON(),
                  //we pass a BuildContext and an AsyncSnapshot object which is an
                  //Immutable representation of the most recent interaction with
                  //an asynchronous computation.
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Patrimonio>? spacecrafts = snapshot.data;
                      markers.add(Marker(
                          markerId: MarkerId("id"),
                          position: const LatLng(
                              20.2699077, -99.2293205), //move to new location
                          icon: BitmapDescriptor.defaultMarker));
                      return DropdownButtonExample();
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    //return  a circular progress indicator.
                    return const CircularProgressIndicator();
                  },
                )),
            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 10),
              padding:
                  const EdgeInsets.only(top: 4, left: 10, right: 10, bottom: 4),
              child: new RaisedButton(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: const Text("RUTA"),
                )),
                color: Colors.green,
                elevation: 10,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0)),
                onPressed: () {
                  int index =
                      mymarkers.indexWhere((item) => item["id"] == "loc2");
                  mymarkers[index] = {
                    "id": "loc2",
                    "marker": Marker(
                        markerId: MarkerId(loc2.toString()),
                        position:
                            LatLng(27.661838, 85.308543), //move to new location
                        icon: BitmapDescriptor.defaultMarker)
                  };

                  markers = {};
                  for (var i = 0; i < mymarkers.length; i++) {
                    markers.add(//repopulate markers
                        mymarkers[i]["marker"]);
                  }

                  //_launchUrl();
                },
              ),
            ),
          ]),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(242, 242, 242, 1),
          ),
        )
      ],
    ));



*/