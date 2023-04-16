import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hola_mundo/utils/calendar_event.dart';
import 'package:hola_mundo/utils/pdf_screen.dart';
import 'package:hola_mundo/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class LugarInfo extends StatefulWidget {
  final value;

  const LugarInfo({Key? key, required this.value}) : super(key: key);

  @override
  _LugarInfo createState() => _LugarInfo();
}

class _LugarInfo extends State<LugarInfo> {
  String remotePDFpath = "";
  @override
  void initState() {
    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      final url = '${widget.value.Extenso}';
      print(url);
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  late GoogleMapController mapController;
  static const platform = MethodChannel('samples.flutter.dev/battery');
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
                                      _launchUrl('${widget.value.Recorrido}');
                                    }, // button pressed
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons
                                            .threed_rotation), // icon// text
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(10.0)),
                            SizedBox.fromSize(
                              size: Size(60, 60), // button width and height
                              child: ClipOval(
                                child: Material(
                                  color: Color.fromRGBO(
                                      3, 218, 197, 1), // button color
                                  child: InkWell(
                                    splashColor: Colors.green, // splash color
                                    onTap: () {
                                      var route = new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new CalendarEvent(
                                                value: widget.value),
                                      );
                                      //A Navigator is a widget that manages a set of child widgets with
                                      //stack discipline.It allows us navigate pages.
                                      Navigator.of(context).push(route);
                                    }, // button pressed
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
                  if (widget.value?.Clima != null)
                    TituloYSubTitulo("Clima", widget.value?.Clima),
                  if (widget.value?.Temperatura != null)
                    TituloYSubTitulo("Temperatura", widget.value.Temperatura),
                  if (widget.value?.PrecipitacionPluvial != null)
                    TituloYSubTitulo("Precipitacion Pluvial",
                        widget.value.PrecipitacionPluvial),
                  TituloYSubTitulo("Sintesis", widget.value.Sintesis),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 25),
                    padding: const EdgeInsets.only(
                        top: 4, left: 10, right: 10, bottom: 4),
                    child: new RaisedButton(
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                        ),
                        child: const Text("DESCARGAR EXTENSO"),
                      )),
                      color: Colors.yellow,
                      elevation: 10,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                      onPressed: () {
                        print('${this.remotePDFpath}');
                        _launchPDF('${this.remotePDFpath}');
                      },
                    ),
                  ),
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

  Future<void> _launchPDF(_extenso) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFScreen(path: remotePDFpath),
      ),
    );
    print("->extendo" + _extenso);
  }

  Future<void> _launchUrl(_extenso) async {
    final Uri _url = Uri.parse(_extenso);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
