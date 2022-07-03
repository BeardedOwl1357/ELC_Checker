import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/sheets/user_sheets_api.dart';
import 'package:flutter_application_1/model/user.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '                            ELC Activity'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<User> _futureUser;
  final formKey = GlobalKey<FormState>();
  TextEditingController _RNOController = TextEditingController();
  String _rollNumber = '';

  Future<User> fetch(String _rno) async {
    final _temp;
    print("Called");
    try {
      _temp = await UserSheetsApi.getByRno(_rno);
      return _temp;
    } catch (e) {
      throw e;
    }
  }

  @override
  void initState() {
    super.initState();
    _futureUser = fetch('');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 15),
              Text("Developed by\n",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  )),
              Text("Sanchay Joshi (101903099)",
                  style: TextStyle(
                    color: Color.fromARGB(255, 67, 54, 244),
                  )),
              Text("Yuvraj Sidhu (101903110)",
                  style: TextStyle(
                    color: Color.fromARGB(255, 67, 54, 244),
                  )),
              Text("Jashandeep Singh (101903563)",
                  style: TextStyle(
                    color: Color.fromARGB(255, 67, 54, 244),
                  )),
              Text("Hardiljit Singh (101903111)",
                  style: TextStyle(
                    color: Color.fromARGB(255, 67, 54, 244),
                  )),
              SizedBox(height: 20),
              TextFormField(
                controller: _RNOController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter TIET Roll Number",
                  hintText: "TIET Roll number",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.length != 9)
                    return "Invalid Roll number";
                  else
                    return null;
                },
              ),
              OutlinedButton(
                child: Text("Submit"),
                onPressed: () {
                  if (formKey.currentState!.validate() == false) return null;
                  setState(() {
                    _rollNumber = _RNOController.text;
                    _futureUser = fetch(_rollNumber);
                  });
                },
              ),
              SizedBox(height: 30),
              Text(
                'Details\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
              FutureBuilder<User?>(
                  future: _futureUser,
                  builder: (context, snapshot) {
                    print("Future Builder-------");

                    if (snapshot.hasData) {
                      final _user = snapshot.data;
                      return Table(
                        defaultColumnWidth: FixedColumnWidth(200.0),
                        border: TableBorder.all(
                            color: Colors.blueGrey,
                            style: BorderStyle.solid,
                            width: 2),
                        children: [
                          // Text(
                          //   'Details\n',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 18.0,
                          //     color: Colors.black,
                          //   ),
                          // ),
                          TableRow(children: [
                            Column(children: [
                              Text(
                                'Name\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              )
                            ]),
                            Column(children: [
                              FittedBox(
                                child: Text(
                                  _user!.toJson()['Name'],
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            ]),
                          ]),

                          TableRow(children: [
                            Column(children: [
                              Text(
                                'Roll Number\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              )
                            ]),
                            Column(children: [
                              Text(
                                _user.toJson()['Rno'],
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.blue,
                                ),
                              )
                            ]),
                          ]),

                          TableRow(children: [
                            Column(children: [
                              Text(
                                'ELC 1\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              )
                            ]),
                            Column(children: [
                              Text(
                                _user.toJson()['ELC1'],
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.blue,
                                ),
                              )
                            ]),
                          ]),

                          TableRow(children: [
                            Column(children: [
                              Text(
                                'ELC 2\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              )
                            ]),
                            Column(children: [
                              Text(
                                _user.toJson()['ELC2'],
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.blue,
                                ),
                              )
                            ]),
                          ]),

                          TableRow(children: [
                            Column(children: [
                              Text(
                                'ELC 3\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              )
                            ]),
                            Column(children: [
                              Text(
                                _user.toJson()['ELC3'],
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.blue,
                                ),
                              )
                            ]),
                          ]),

                          TableRow(children: [
                            Column(children: [
                              Text(
                                'ELC 4\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              )
                            ]),
                            Column(children: [
                              Text(
                                _user.toJson()['ELC4'],
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.blue,
                                ),
                              )
                            ]),
                          ]),

                          TableRow(children: [
                            Column(children: [
                              Text(
                                'ELC 5\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              )
                            ]),
                            Column(children: [
                              Text(
                                _user.toJson()['ELC5'],
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.blue,
                                ),
                              )
                            ]),
                          ]),
                          // Text('Name: ' + _user!.toJson()['Name']),
                          // Text('Roll No.: ' + _user.toJson()['Rno']),
                          // Text('ELC 1: ' + _user.toJson()['ELC1']),
                          // Text('ELC 2: ' + _user.toJson()['ELC2']),
                          // Text('ELC 3: ' + _user.toJson()['ELC3']),
                          // Text('ELC 4: ' + _user.toJson()['ELC4']),
                          // Text('ELC 5: ' + _user.toJson()['ELC5']),
                        ],
                      );
                    } else {
                      return Text('Data not found',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.red,
                          ));
                    }
                  }),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
