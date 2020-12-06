import 'package:flutter/material.dart';

// firebase_coreをimportする
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'package:geolocator/geolocator.dart';

import 'package:carousel_slider/carousel_slider.dart';

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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
    final HttpsCallable callable =
        FirebaseFunctions.instanceFor(region: 'us-central1')
            .httpsCallable('functuion-1');
    final results = await callable(<String, dynamic>{'name': 'YourName'});
    print(results.data);
  }

  final List images = [
    "images/image1.jpg",
    "images/image2.jpg",
    "images/image3.jpg",
    "images/image4.jpg",
    "images/image5.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: CarouselSlider.builder(
        options: CarouselOptions(
          height: 600.0,
          initialPage: 0,
          viewportFraction: 1,
          enableInfiniteScroll: false,
        ),
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            images[index],
          );
        },
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      // children: <Widget>[
      // Text(
      //   'You have pushed the button this many times:',
      // ),
      // Text(
      //   '$_counter',
      //   style: Theme.of(context).textTheme.headline4,
      // ),
      // Text(
      //   "$_name",
      //   style: TextStyle(
      //       color: Colors.blueAccent,
      //       fontSize: 30.0,
      //       fontWeight: FontWeight.w300),
      // ),
      // new TextField(
      //   enabled: true,
      //   // 入力数
      //   maxLength: 10,
      //   maxLengthEnforced: false,
      //   style: TextStyle(color: Colors.red),
      //   obscureText: false,
      //   maxLines: 1,
      //   //パスワード
      //   onChanged: _handleText,
      // ),
      // Text(
      //   "$_position",
      //   style: TextStyle(
      //       color: Colors.blueAccent,
      //       fontSize: 30.0,
      //       fontWeight: FontWeight.w300),
      // ),
      // FlatButton(
      //   onPressed: _postFireStore,
      //   color: Colors.blue,
      //   child: Text(
      //     '追加',
      //     style: TextStyle(color: Colors.white, fontSize: 20.0),
      //   ),
      // ),
      // FlatButton(
      //   onPressed: _readFireStore,
      //   color: Colors.blue,
      //   child: Text(
      //     '読みとり',
      //     style: TextStyle(color: Colors.white, fontSize: 20.0),
      //   ),
      // ),
      // FlatButton(
      //   onPressed: _getCurrentPosition,
      //   color: Colors.blue,
      //   child: Text(
      //     '位置情報',
      //     style: TextStyle(color: Colors.white, fontSize: 20.0),
      //   ),
      // ),
      // FlatButton(
      //   onPressed: _doCluodFunctions,
      //   color: Colors.blue,
      //   child: Text(
      //     'cloud func',
      //     style: TextStyle(color: Colors.white, fontSize: 20.0),
      //   ),
      // ),
      // ],
      //   ),
      // ),
    );
    return scaffold;
  }
}
