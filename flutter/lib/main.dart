import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'DeepLink Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platformMethodChannel =
  const MethodChannel("mainDeeplinkChannel");
  String deeplinkResult = "";

  Future<Null> _sendDeeplink() async {
    String _message = "";
    try {
      int amount = 10;
      bool editableAmount = false;
      int installmentCount = 1;
      String transactionType = "CREDIT"; //DEBIT, CREDIT, VOUCHER
      String installmentType = "MERCHANT"; //MERCHANT, ISSUER, NONE
      int orderId;
      String returnScheme = "flutterDeeplinkDemo";

      await platformMethodChannel.invokeMethod('sendDeeplink', {
        "amount": amount,
        "editableAmount": editableAmount,
        "installmentCount": installmentCount,
        "transactionType": transactionType,
        "installmentType": installmentType,
        "orderId": orderId,
        "returnScheme": returnScheme
      });
    } on PlatformException catch (e) {
      _message = "Erro ao enviar deeplink: ${e.message}.";
    }
    setState(() {
      deeplinkResult = _message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: _sendDeeplink,
                child: const Text('Enviar deeplink',
                    style: TextStyle(fontSize: 20)),
              ),
              Text(deeplinkResult),
            ],
          ),
        ));
  }
}