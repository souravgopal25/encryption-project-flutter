import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final msgController = TextEditingController();
  final passController = TextEditingController();
  final encryptedMsg = TextEditingController();

  @override
  void initState() {
    encryptedMsg.text = "Encrypted Text";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Encryption"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: msgController,
                    minLines: 2,
                    maxLines: 5,
                    maxLength: 250,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Message",
                      labelText: "Message",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: passController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Key",
                      labelText: "Key",
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      encryptedMsg.text,
                      style: TextStyle(fontSize: 20),
                    )),
                RaisedButton(
                  onPressed: () async {
                    print(msgController.text);
                    fencrypt();
                    setState(() {});
                  },
                  child: Text(
                    "Encrypt",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            )),
      ),
    );
  }

  void fencrypt() {
    final key = encrypt.Key.fromUtf8(passController.text);
    final iv = encrypt.IV.fromUtf8(passController.text);
    final encrypter = encrypt.Encrypter(encrypt.Salsa20(key));

    final encrypted = encrypter.encrypt(msgController.text.trim(), iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    print(encrypted.base64);
  }
}
