import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(configuracion());

class configuracion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Configuracion';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // Crea una clave global que identificará de manera única el widget Form
  // y nos permita validar el formulario
  //
  // Nota: Esto es un GlobalKey<FormState>, no un GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  bool isHiddenPassword = true;
  Future userRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String emailB = emailController.text;
    String passwordUB = passwordController.text;
    // SERVER API URL
    var url = 'https://centrodeinformacion-isic-itsoeh.org.mx/php/editarI.php';

    // Store all data with Param Name.
    var data = {
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Crea un widget Form usando el _formKey que creamos anteriormente
    return new ListTile(
      title: new Card(
        elevation: 7.0,
        child: Container(
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.all(20.0),
          decoration:
              BoxDecoration(border: Border.all(color: Color(0xff00C853))),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  child: new Text('Correo'),
                  padding: const EdgeInsets.all(1.0),
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Agregar Correo';
                    }
                  },
                ),
                Padding(
                  child: new Text('Contraseña'),
                  padding: const EdgeInsets.all(1.0),
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: isHiddenPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Agregar Contraseña';
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: _togglePassView, child: Icon(Icons.visibility)),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      color: Color(0xff00C853),
                      onPressed: () {
                        // devolverá true si el formulario es válido, o falso si
                        // el formulario no es válido.
                        if (_formKey.currentState!.validate()) {
                          userRegistration();
                          // Si el formulario es válido, queremos mostrar un Snackbar
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Procesando la Información')));
                        }
                      },
                      child: Text('Cambiar Contraseña '),
                    ),
                  ),
                ),
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
