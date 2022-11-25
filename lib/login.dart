// ignore_for_file: unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hola_mundo/HttpInterceptor.dart';
import 'package:hola_mundo/Inicio.dart';
import 'package:hola_mundo/home.dart';
import 'package:hola_mundo/main.dart';
import 'package:http_interceptor/http/http.dart';
//import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'registro.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

late BuildContext buildContext;
void main() => runApp(LoginApp());
final http =
    InterceptedHttp.build(interceptors: [HttpInterceptor(buildContext)]);
String email = '';

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Centro de informacion',
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/LoginPage': (BuildContext context) => const LoginPage(),
      },
    );
  }
}

Future<bool> _willPopCallback() async {
  // await showDialog or Show add banners or whatever
  // then
  return Future.value(true);
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SharedPreferences prefs;
  bool visible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String mensaje = '';
  bool isHiddenPassword = true;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Cargando el valor del contador en el inicio
  _loadCounter() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  Future login() async {
    setState(() {
      visible = true;
    });
    String emailB = emailController.text;
    String passwordUB = passwordController.text;
    //
    var url =
        "https://centrodeinformacion-isic-itsoeh.org.mx/php/app_login.php?email=${emailB}&passwordU=${passwordUB}";

    var response = await http.get(Uri.parse(url));
    List data = json.decode("[" + response.body + "]");

    // If the Response Message is Matched.
    if (data.length != 0) {
      prefs.setString('idusuario', data[0]["datos"][0]["idusuario"]);

      Fluttertoast.showToast(
          msg: "Bienvenido",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        visible = false;
      });

      // Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(
                "Usuario o Contrase\u00f1a Incorrectos por favor intente de nuevo"),
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
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    print("Holaasdasdasd");
    print( MediaQuery.of(context).size.height );
    buildContext = context;
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Centro de Información"),
          centerTitle: false,
          backgroundColor: const Color(0xff00C853),
        ),
        body: Center(
          child: Form(
            child: Flexible(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/Dianav2.png"),
                  fit: BoxFit.cover,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // ignore: unnecessary_new
                    new Container(
                      padding: const EdgeInsets.only(top: 60.0),
                      // ignore: prefer_const_constructors
                      alignment: Alignment.bottomCenter,

                      width: 290.0,
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(shape: BoxShape.circle),
                    ),
                    Container(

                      width: MediaQuery.of(context).size.width,
                      // ignore: prefer_const_constructors
                      padding: EdgeInsets.only(top: 93,bottom: 30),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            // ignore: prefer_const_constructors
                            padding: EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            // ignore: prefer_const_constructors
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                // ignore: prefer_const_literals_to_create_immutables
                                boxShadow: [
                                  const BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  )
                                ]),
                            child: TextFormField(
                              controller: emailController,
                              // ignore: prefer_const_constructors
                              decoration: InputDecoration(
                                  // ignore: prefer_const_constructors
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  hintText: 'email'),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 50,
                            margin: const EdgeInsets.only(top: 32),
                            padding: const EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5)
                                ]),
                            child: TextField(
                              controller: passwordController,
                              obscureText: isHiddenPassword,
                              // ignore: prefer_const_constructors
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.vpn_key,
                                  color: Colors.black,
                                ),
                                hintText: 'Password',
                                suffixIcon: InkWell(
                                    onTap: _togglePassView,
                                    child: Icon(Icons.visibility)),
                              ),
                            ),
                          ),
                          // ignore: prefer_const_constructors

                          // ignore: deprecated_member_use
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 50,
                            margin: const EdgeInsets.only(top: 25),
                            padding: const EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            child: new RaisedButton(
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                ),
                                child: const Text("Ingresar"),
                              )),
                              color: Color(0xff00C853),
                              elevation: 10,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0)),
                              onPressed: () {
                                login();
                              },
                            ),
                          ),
                          Text(
                            mensaje,
                            style: TextStyle(fontSize: 25.0, color: Colors.red),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 40,
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            child: new RaisedButton(
                              child: const Text("Registrarse"),
                              color: Color(0xff00C853),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => registro()),
                                );
                              },
                            ),
                          ),

                          Center(
                            child: Container(
                              child: new InkWell(
                                  child: new Text('Recuperar Contraseña',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.blue)),
                                  onTap: () => launch(
                                      'https://centrodeinformacion.host/recuperarContra.php')),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
