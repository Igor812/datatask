import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Сохранение в SharedPreferences',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class SharedPreferencesUtil {
  static saveData<T>(String key, T value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value as String);
  }

  static Future<String> getData<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String res = prefs.getString(key)!;
    return res;
  }
}

class _MyHomePageState extends State<MyHomePage> {

  String _savedValue = "";


  late String _currentInputValue;

  @override
  void initState() {
    super.initState();
    SharedPreferencesUtil.getData<String>("myData").then((value) {
      setState(() {
        _savedValue = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(

          children: <Widget>[

            Text(
              _savedValue == "" ? "Новый пользователь" : ("Добро пожаловать: " + _savedValue),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),


            TextField(


              onChanged: (value) {
                _currentInputValue = value;
              },

              decoration: InputDecoration(

                  hintText: _savedValue == "" ? "Login" : _savedValue,
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),

                  )),
            ),
            const SizedBox(height: 20,),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                labelText: "Password",

              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text("Войти"),
                  onPressed: () {

                    SharedPreferencesUtil.saveData<String>(
                        "myData", _currentInputValue);


                    setState(() {
                      _savedValue = _currentInputValue;
                    });
                  },
                ),
                SizedBox(width: 30,),
                ElevatedButton(
                  child: Text("Очистить данные"),
                  onPressed: () {

                    SharedPreferencesUtil.saveData<String>("myData","");

                    setState(() {
                      _savedValue = "";
                    }

                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
