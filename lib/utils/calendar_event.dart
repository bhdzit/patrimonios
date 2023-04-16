// ignore_for_file: deprecated_member_use, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:hola_mundo/HttpInterceptor.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarEvent extends StatefulWidget {
  final value;

  const CalendarEvent({Key? key, required this.value}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CalendarEvent createState() => _CalendarEvent();
}

late BuildContext buildContext;
final http =
    InterceptedHttp.build(interceptors: [HttpInterceptor(buildContext)]);

class _CalendarEvent extends State<CalendarEvent> {
  String _selectedDate = '';
  TextEditingController tituloTextController = new TextEditingController();
  TextEditingController dateTextController = new TextEditingController();
  TextEditingController descripcionTextController = new TextEditingController();
  TextEditingController lugarTextController = new TextEditingController();

  Future agendarVisita() async {
    final prefs = await SharedPreferences.getInstance();
    final String idUsuario = prefs.getString('idusuario') ?? "";
    setState(() {});

    //

    var url =
        // ignore: prefer_interpolation_to_compose_strings
        "${"https://centrodeinformacion-isic-itsoeh.org.mx/php/app_VisitasUsuario.php?id_agenda_usuario=$idUsuario&id_agenda_lugar=" + widget.value.idlugares}&nombre_visita=${tituloTextController.text}&fecha_visita=$_selectedDate";
    try {
      print(url);
      var response = await http.get(Uri.parse(url));
      List data = json.decode("[${response.body}]");

      // If the Response Message is Matched.
      if (data.isNotEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    } catch (e) {}

    // If the Response Message is Matched.
  }

  @override
  void initState() {
    super.initState();
    var fecha = DateTime.now();
    tituloTextController.text = 'Visita a ${widget.value.Nombre}';
    lugarTextController.text = '${widget.value.Nombre}';
    dateTextController.text =
        '${fecha.day}/${fecha.month}/${fecha.year}  ${fecha.hour}:${fecha.minute}';
  }

  //Method for showing the date picker
  void _pickDateDialog() {
    showDatePicker(
      context: context,
      locale: const Locale("es"),
      initialDate: DateTime.now(),
      //which date will display when user open the picker
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
      //what will be the previous supported year in picker
    ) //what will be the up to supported date in picker
        .then((pickedDate) async {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }

      var time =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      time ??= TimeOfDay.now();
      setState(() {
        //for rebuilding the ui
        _selectedDate =
            '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}  ${time?.hour}:${time?.minute}';
        dateTextController.text = _selectedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Agendar Visita"),
          backgroundColor: const Color(0xff00C853),
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
            color: const Color(0xff00C853),
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.all(25.0),
                child: Column(children: [
                  Container(
                    height: 200,
//                      child: Image.network(widget.value.Imagen,fit:BoxFit.cover,height: 100,),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.value.Imagen),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: tituloTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Titulo',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    onTap: _pickDateDialog,
                    readOnly: true,
                    controller: dateTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Fecha de visita:",
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    readOnly: true,
                    controller: lugarTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Lugar de visita:",
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    onTap: _pickDateDialog,
                    readOnly: true,
                    controller: descripcionTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Descripción:",
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 60,
                    margin: const EdgeInsets.only(top: 25),
                    padding: const EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 4),
                    child: new RaisedButton(
                      color: const Color(0xff00C853),
                      elevation: 20,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                      onPressed: () async {
                        final Event event = Event(
                          title: tituloTextController.text,
                          description: descripcionTextController.text,
                          location: lugarTextController.text,
                          startDate: DateTime.now(),
                          endDate: DateTime(2023),
                        );
                        var res = await Add2Calendar.addEvent2Cal(event);
                        if (res == true) agendarVisita();
                      },
                      child: const Center(
                          child: Padding(
                        padding: EdgeInsets.only(
                          top: 5,
                        ),
                        child: Text(
                          "Agendar",
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w100),
                        ),
                      )),
                    ),
                  ),
                ]))));
  }
}
