import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late String _counter="";

  getString(String login){
    return login;
  }



  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start
  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getString("key"))!;
    });
  }

  //Incrementing counter after click
  void _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getString(_counter)!;
      prefs.setString('key', _counter);
    });
  }


  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Login",
              labelText: login,
            ),

          ),
          const SizedBox(height: 20,),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: login,


            ),
          ),

       const SizedBox(height: 15),

          ElevatedButton(
            style: style,
            onPressed: _incrementCounter,
            child: const Text('Enabled'),
          ),
          Row(
              children: <Widget>[
                new Container(padding:EdgeInsets.all(10.0),child: new Text('Ширина (мм):')),
                new Expanded(child: Container(padding:EdgeInsets.all(10.0),child:
                new TextFormField(

                    validator: (value){


                })
                )),
              ]
          )
        ],

      ),
    );
  }
}
