import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hola_mundo/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LugarInfo extends StatefulWidget {
  final  value;

  const LugarInfo({Key? key, required this.value}) : super(key: key);

  @override
  _LugarInfo createState() => _LugarInfo();
}

class _LugarInfo extends State<LugarInfo> {
  late GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      final marker = Marker(
        markerId: MarkerId('${widget.value.Nombre}'),
        position: LatLng(double.parse('${widget.value.Latitud}'),
            double.parse('${widget.value.Longitud}')),
        infoWindow: InfoWindow(
          title: 'Nombre:${widget.value.Nombre}',
          snippet: 'Ubicacion : ${widget.value.Ubicacion}',
        ),
      );
      _markers['${widget.value.Nombre}'] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Culturales"),
        backgroundColor: const Color(0xff00C853),
      ),
      body: new Container(
        decoration:
        const BoxDecoration(color: Color.fromRGBO(204, 204, 204, 1)),
        child: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(

                margin: const EdgeInsets.all(10.0),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        child: new Text(
                          '${widget.value.Nombre}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                              color: Color.fromRGBO(55, 71, 79, 1)),
                          textAlign: TextAlign.left,
                        ),
                        padding: const EdgeInsets.only(top: 20.0, left: 20),
                      ),
                    ),
                    Container(
                      height: 200,
//                      child: Image.network(widget.value.Imagen,fit:BoxFit.cover,height: 100,),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.value.Imagen),
                              fit: BoxFit.cover)),
                    ),
                    TituloYSubTitulo("Ubicación", widget.value.Ubicacion),
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(top: 20.0, right: 20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox.fromSize(
                              size: Size(60, 60), // button width and height
                              child: ClipOval(
                                child: Material(
                                  color: Color.fromRGBO(
                                      3, 218, 197, 1), // button color
                                  child: InkWell(
                                    splashColor: Colors.green, // splash color
                                    onTap: () {

                                    }, // button pressed
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.threed_rotation), // icon// text
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                                padding:
                                EdgeInsets.all(10.0)),
                            SizedBox.fromSize(
                              size: Size(60, 60), // button width and height
                              child: ClipOval(
                                child: Material(
                                  color: Color.fromRGBO(
                                      3, 218, 197, 1), // button color
                                  child: InkWell(
                                    splashColor: Colors.green, // splash color
                                    onTap: () {}, // button pressed
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons
                                            .calendar_today_outlined), // icon// text
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    )
                  ],
                ),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(242, 242, 242, 1),
                ),
              ),
              Container(

                margin: const EdgeInsets.all(10.0),
                alignment: Alignment.topLeft,
                child: Column(children: [
                  TituloYSubTitulo("Clima", widget.value.Clima),
                  TituloYSubTitulo("Temperatura", widget.value.Temperatura),
                  TituloYSubTitulo("Precipitacion Pluvial",
                      widget.value.PrecipitacionPluvial),
                  TituloYSubTitulo("Sintesis", widget.value.Sintesis),
                ]),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(242, 242, 242, 1),
                ),
              ),
              Container(
                height: 500,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse('${widget.value.Latitud}'),
                        double.parse('${widget.value.Longitud}')),
                    zoom: 11.0,
                  ),
                  markers: _markers.values.toSet(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
