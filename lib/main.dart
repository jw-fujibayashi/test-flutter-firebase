import 'package:flutter/material.dart';

// firebase_coreをimportする
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'package:geolocator/geolocator.dart';

// mainをasyncにしてしまう
Future<void> main() async {
  // 初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

// 以降はデフォルトのコード
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ドキュメントid
  int _counter = 1;

  // 名前
  String _name = '';

  // 位置情報
  Position _position;

  // コレクション
  final usersCollenction = FirebaseFirestore.instance.collection('users');

  void _handleText(String e) {
    setState(() {
      _name = e;
    });
  }

  void _postFireStore() async {
    // とりあえずFirestoreへ書き込んで見るテストコード
    await usersCollenction.doc(_counter.toString()).set({
      'name': _name,
      'latitude': _position.latitude.toString(),
      'longitude': _position.longitude.toString()
    });

    setState(() {
      _counter++;
    });
  }

  void _readFireStore() async {
    final test = await usersCollenction.doc((_counter - 1).toString()).get();

    print(test.data());
  }

  void _getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _position = position;
    });
  }

  void _doCluodFunctions() async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('helloWorld');
    final results = await callable();
    print(results.data);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var scaffold = Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   'You have pushed the button this many times:',
            // ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "$_name",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w300),
            ),
            new TextField(
              enabled: true,
              // 入力数
              maxLength: 10,
              maxLengthEnforced: false,
              style: TextStyle(color: Colors.red),
              obscureText: false,
              maxLines: 1,
              //パスワード
              onChanged: _handleText,
            ),
            Text(
              "$_position",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w300),
            ),
            FlatButton(
              onPressed: _postFireStore,
              color: Colors.blue,
              child: Text(
                '追加',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
            FlatButton(
              onPressed: _readFireStore,
              color: Colors.blue,
              child: Text(
                '読みとり',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
            FlatButton(
              onPressed: _getCurrentPosition,
              color: Colors.blue,
              child: Text(
                '位置情報',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
            FlatButton(
              onPressed: _doCluodFunctions,
              color: Colors.blue,
              child: Text(
                'cloud func',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );

    return scaffold;
  }
}
