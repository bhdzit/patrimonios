import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http_interceptor/http/http.dart';
import 'package:hola_mundo/HttpInterceptor.dart';

late BuildContext buildContext;
void main() => runApp(registro());
final http =
    InterceptedHttp.build(interceptors: [HttpInterceptor(buildContext)]);
String email = '';

class registro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Registrarse';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          backgroundColor: const Color(0xff00C853),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Crea un Widget Form
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Crea una clase State correspondiente. Esta clase contendrá los datos relacionados con
// el formulario.
class MyCustomFormState extends State<MyCustomForm> {
  bool visible = false;

  // Getting value from TextField widget.
  final nameController = TextEditingController();
  final apellidoPcontroller = TextEditingController();
  final apellidoMcontroller = TextEditingController();
  final nombreUcontroller = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String nombreB = nameController.text;
    String apellidoPaternoB = apellidoPcontroller.text;
    String apellidoMaternoB = apellidoMcontroller.text;
    String nombreUsuarioB = nombreUcontroller.text;
    String emailB = emailController.text;
    String passwordUB = passwordController.text;
    // SERVER API URL
    var url = 'https://centrodeinformacion-isic-itsoeh.org.mx/php/agregarI.php';

    // Store all data with Param Name.
    var data = {
      "nombre": nombreB,
      "apellidoPaterno": apellidoPaternoB,
      "apellidoMaterno": apellidoMaternoB,
      "nombreUsuario": nombreUsuarioB,
      "email": emailB,
      "passwordU": passwordUB,
    };

    // Starting Web API Call.
    var response = await http.post(Uri.parse(url), body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }

    // Showing Alert Dialog with Response JSON Message.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => registro()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  bool isHiddenPassword = true;
  // Crea una clave global que identificará de manera única el widget Form
  // y nos permita validar el formulario
  //
  // Nota: Esto es un GlobalKey<FormState>, no un GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Crea un widget Form usando el _formKey que creamos anteriormente
    return ListTile(
      title: Card(
        elevation: 7.0,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(20.0),
          decoration:
              BoxDecoration(border: Border.all(color: const Color(0xff00C853))),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 30,
                  padding: const EdgeInsets.only(
                      top: 4, left: 10, right: 10, bottom: 4),
                  child: const Text('Nombre'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50,
                  padding: const EdgeInsets.only(
                      top: 4, left: 16, right: 16, bottom: 4),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'No Puede Dejar Campos Vacios';
                      }
                    },
                    //decoration: InputDecoration(hintText: 'Nombre'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 30,
                  padding: const EdgeInsets.only(
                      top: 4, left: 10, right: 10, bottom: 4),
                  child: const Text('Apellido Paterno'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50,
                  padding: const EdgeInsets.only(
                      top: 4, left: 16, right: 16, bottom: 4),
                  child: TextFormField(
                    controller: apellidoPcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'No Puede Dejar Campos Vacios';
                      }
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 30,
                  padding: const EdgeInsets.only(
                      top: 4, left: 10, right: 10, bottom: 4),
                  child: const Text('Apellido Materno'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 30,
                  padding: const EdgeInsets.only(
                      top: 4, left: 10, right: 10, bottom: 4),
                  child: TextFormField(
                    controller: apellidoMcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'No Puede Dejar Campos Vacios';
                      }
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 30,
                  padding: const EdgeInsets.only(
                      top: 4, left: 10, right: 10, bottom: 4),
                  child: const Text('Usuario'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 30,
                  padding: const EdgeInsets.only(
                      top: 4, left: 10, right: 10, bottom: 4),
                  child: TextFormField(
                    controller: nombreUcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'No Puede Dejar Campos Vacios';
                      }
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 30,
                  padding: const EdgeInsets.only(
                      top: 4, left: 10, right: 10, bottom: 4),
                  child: const Text('Correo'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 30,
                  padding: const EdgeInsets.only(
                      top: 4, left: 10, right: 10, bottom: 4),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'No Puede Dejar Campos Vacios';
                      }
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 30,
                  padding: const EdgeInsets.only(
                      top: 4, left: 10, right: 10, bottom: 4),
                  child: const Text('Contraseña'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 30,
                  padding: const EdgeInsets.only(
                      top: 4, left: 10, right: 10, bottom: 4),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'No Puede Dejar Campos Vacios';
                      }
                    },
                    controller: passwordController,
                    obscureText: isHiddenPassword,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: _togglePassView,
                          child: const Icon(Icons.visibility)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 30,
                      padding: const EdgeInsets.only(
                          top: 4, left: 10, right: 10, bottom: 4),
                      child: RaisedButton(
                        color: const Color(0xff00C853),
                        onPressed: () {
                          // devolverá true si el formulario es válido, o falso si
                          // el formulario no es válido.
                          if (_formKey.currentState!.validate()) {
                            // Si el formulario es válido, queremos mostrar un Snackbar
                            userRegistration();
                          }
                        },
                        child: const Text('Registrarse '),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 30,
                      padding: const EdgeInsets.only(
                          top: 4, left: 10, right: 10, bottom: 4),
                      child: RaisedButton(
                        color: const Color(0xff00C853),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginApp()),
                          );
                        },
                        child: const Text('Volver '),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _togglePassView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}
