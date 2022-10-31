import 'package:flutter/material.dart';

class TituloYSubTitulo extends StatefulWidget {
  @override
  _TituloYSubTitulo createState() => _TituloYSubTitulo();

  String titulo;
  String subtitulo;

  TituloYSubTitulo(this.titulo, this.subtitulo);
}

class _TituloYSubTitulo extends State<TituloYSubTitulo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              child: new Text(
                '${widget.titulo}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromRGBO(55, 71, 79, 1)),
                textAlign: TextAlign.left,
              ),
              padding: const EdgeInsets.only(top: 20.0, left: 20),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              child: new Text(
                '${this.widget.subtitulo}',
                style: const TextStyle(
                    color: Color.fromRGBO(153, 153, 153, 1), fontSize: 18),
                textAlign: TextAlign.left,
              ),
              padding: const EdgeInsets.only(top: 10.0, left: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class AgendaCard extends StatefulWidget {
  @override
  _AgendaCard createState() => _AgendaCard();
  AgendaCard(this.data);

  var data;
  Object titulo = "asdasd";
  String subtitulo = "adsasd";
}

class _AgendaCard extends State<AgendaCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Card(
            // Con esta propiedad modificamos la forma de nuestro card
            // Aqui utilizo RoundedRectangleBorder para proporcionarle esquinas circulares al Card
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

            // Con esta propiedad agregamos margen a nuestro Card
            // El margen es la separación entre widgets o entre los bordes del widget padre e hijo
            margin: EdgeInsets.all(15),

            // Con esta propiedad agregamos elevación a nuestro card
            // La sombra que tiene el Card aumentará
            elevation: 10,

            // La propiedad child anida un widget en su interior
            // Usamos columna para ordenar un ListTile y una fila con botones
            child: Column(
              children: <Widget>[
                Padding(
                  child: Row(children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                        size: 40.0,
                      ),
                    ),
                    Expanded(
                      child: Column(children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            child: new Text(
                              this.widget.data.nombreVisita,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromRGBO(55, 71, 79, 1)),
                              textAlign: TextAlign.left,
                            ),
                            padding: const EdgeInsets.only(top: 0.0, left: 20),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            child: new Text(
                              'Lugar :${this.widget.data.lugar}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(55, 71, 79, 1)),
                              textAlign: TextAlign.left,
                            ),
                            padding: const EdgeInsets.only(top: 0.0, left: 20),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            child: new Text(
                              'Fecha de Creacion :${this.widget.data.fecha_creacion}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(55, 71, 79, 1)),
                              textAlign: TextAlign.left,
                            ),
                            padding: const EdgeInsets.only(top: 0.0, left: 20),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            child: new Text(
                              'Clima :${this.widget.data.clima}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(55, 71, 79, 1)),
                              textAlign: TextAlign.left,
                            ),
                            padding: const EdgeInsets.only(top: 0.0, left: 20),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            child: new Text(
                              'Temperatura :${this.widget.data.temp}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(55, 71, 79, 1)),
                              textAlign: TextAlign.left,
                            ),
                            padding: const EdgeInsets.only(top: 0.0, left: 20),
                          ),
                        ),
                      ]),
                    ),
                  ]),
                  padding: const EdgeInsets.all(10.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
