import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  var _channel = MethodChannel("paymentChannel");
  TextEditingController merchantIdTextEditing = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController serverURLTextEditing = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: merchantIdTextEditing,
                ),
                TextFormField(
                  controller: region,
                ),
                TextFormField(
                  controller: serverURLTextEditing,
                ),
                OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _invokeMethodChannelPayment("payment");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: Text("Payment")),
              ],
            ),
          )),
        ),
      ),
    );
  }

  _invokeMethodChannelPayment(String name) async {
    try {
      print("nethod channel flutter ");
      var result = await _channel.invokeMethod(name, <String, dynamic>{
        "merchantIdTextEditing": merchantIdTextEditing.text.toString(),
        // "region": region.text.toString(),
        // "serverURLTextEditing": serverURLTextEditing.text.toString()
      });
      if (result == null) {
        print("----------null------");
      } else {
        print(result.toString());
      }
    } on PlatformException catch (e) {
      print("khaled : ${e.message}");
    }
  }
}
