import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:flutter/material.dart';
class HttpInterceptor implements InterceptorContract {
  late BuildContext context;

  HttpInterceptor(BuildContext context){
    this.context=context;
  }
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print(data.toString());
    Dialogs.showLoadingDialog(context, _keyLoader);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print(data.toString());
    Navigator.of(context,rootNavigator: true).pop();
    return data;
  }

}
class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Por favor espera....",style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }
}