import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payment/core/injection/injection_session.dart';
import 'package:payment/model/session_model.dart';
import 'package:payment/usecase/usecase_session.dart';

class SessionScreen extends StatelessWidget {
  UseCaseSession useCaseSession = UseCaseSession(getIt());
  var _channel = MethodChannel("com.example.payment/payment/channel");
  TextEditingController merchantIdEditing = TextEditingController();
  TextEditingController versionIdEditing = TextEditingController();
  TextEditingController correlationIdEditing = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _textField(merchantIdEditing, 'merchantId'),
                  _textField(versionIdEditing, 'versionId'),
                  _textField(correlationIdEditing, 'correlationId'),
                  _buttonCreateSession(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonCreateSession() {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await useCaseSession
                  .callCreateSession(SessionModel(
                      merchantId: int.parse(merchantIdEditing.text),
                      versionId: int.parse(versionIdEditing.text),
                      correlationId: int.parse(correlationIdEditing.text)))
                  .then(
                    (response) => _invokeMethodChannelPayment(
                        "payment", response.session.id),
                  );
            } else {}
          },
          child: const Text("create Session"),
        ),
      ],
    );
  }

  _textField(TextEditingController controller, String label) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          validator: (value) =>
              (value == null) ? "this field is required" : null,
          decoration: InputDecoration(
            label: Text(label),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
          ),
        ),
      );

  _invokeMethodChannelPayment(String name, String sessionId) async {
    try {
      print("method channel flutter ");
      var result = await _channel.invokeMethod(name, <String, dynamic>{
        'sessionId': sessionId,
      });
      if (result == null) {
        print("----------null------");
      } else {
        print('----------result ${result.toString()} ------');
      }
    } on PlatformException catch (e) {
      print("khaled : ${e.message}");
    }
  }
}
