// ignore_for_file: file_names

import 'package:flutter/material.dart';

class contacto extends StatelessWidget {
  const contacto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              // ignore: unnecessary_new
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 200,
                  margin: const EdgeInsets.only(top: 25),
                  padding: const EdgeInsets.only(
                      top: 4, left: 16, right: 16, bottom: 4),
                  child: new SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundColor: Color(0x0f81f7f3),
                            child: Image(
                              image: AssetImage("assets/images/Logo.png"),
                            ),
                          ),
                        ),
                        Padding(
                          child: new Text(
                            'Cristy Elizabeth Aguilar Ojeda',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          padding: const EdgeInsets.all(10.0),
                        ),
                        Padding(
                          child: new Text(
                            'correo:caguilar@itsoeh.edu.mx',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          padding: const EdgeInsets.all(10.0),
                        ),
                        Padding(
                          child: new Text(
                            'tel:	(738) 73 54 000 ext. 240',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          padding: const EdgeInsets.all(10.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 200,
                  margin: const EdgeInsets.only(top: 25),
                  padding: const EdgeInsets.only(
                      top: 4, left: 16, right: 16, bottom: 4),
                  child: new SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0x0f81f7f3),
                          child: Image(
                            image: AssetImage("assets/images/Logo.png"),
                          ),
                        ),
                      ),
                      Padding(
                        child: new Text(
                          'Rolando Porras Muñoz',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        padding: const EdgeInsets.all(10.0),
                      ),
                      Padding(
                        child: new Text(
                          'correo:rporras@itsoeh.edu.mx',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        padding: const EdgeInsets.all(10.0),
                      ),
                      Padding(
                        child: new Text(
                          'tel:	(738) 73 54 000 ext. 240',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        padding: const EdgeInsets.all(10.0),
                      ),
                    ]),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 200,
                  margin: const EdgeInsets.only(top: 25),
                  padding: const EdgeInsets.only(
                      top: 4, left: 16, right: 16, bottom: 4),
                  child: new SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0x0f81f7f3),
                          child: Image(
                            image: AssetImage("assets/images/Logo.png"),
                          ),
                        ),
                      ),
                      Padding(
                        child: new Text(
                          'DocJorge',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        padding: const EdgeInsets.all(10.0),
                      ),
                      Padding(
                        child: new Text(
                          'correo:jorge@itsoeh.edu.mx',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        padding: const EdgeInsets.all(10.0),
                      ),
                      Padding(
                        child: new Text(
                          'tel:	(738) 73 54 000 ext. 240',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        padding: const EdgeInsets.all(10.0),
                      ),
                    ]),
                  ),
                ),
              ),
              Spacer(),
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 10,
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(10.0),
                  child: new SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Padding(
                        child: new Text(
                          'Copyright ©2021 Todos los derechos reservados  03-2021-050712355400-01',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        padding: const EdgeInsets.all(10.0),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
