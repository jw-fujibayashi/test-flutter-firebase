import 'package:flutter/material.dart';
import './my_flutter_app_icons.dart';

// firebase_coreをimportする
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_functions/cloud_functions.dart';

// import 'package:geolocator/geolocator.dart';

// import 'package:carousel_slider/carousel_slider.dart';

// mainをasyncにしてしまう
Future<void> main() async {
  // 初期化
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

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
        primarySwatch: Colors.green,
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
  // int _counter = 1;

  // 名前
  // String _name = '';

  // 位置情報
  // Position _position;

  // コレクション
  // final usersCollenction = FirebaseFirestore.instance.collection('users');

  // void _handleText(String e) {
  //   setState(() {
  //     _name = e;
  //   });
  // }

  // void _postFireStore() async {
  //   // とりあえずFirestoreへ書き込んで見るテストコード
  //   await usersCollenction.doc(_counter.toString()).set({
  //     'name': _name,
  //     'latitude': _position.latitude.toString(),
  //     'longitude': _position.longitude.toString()
  //   });

  //   setState(() {
  //     _counter++;
  //   });
  // }

  // void _readFireStore() async {
  //   final test = await usersCollenction.doc((_counter - 1).toString()).get();

  //   print(test.data());
  // }

  // void _getCurrentPosition() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   setState(() {
  //     _position = position;
  //   });
  // }

  // void _doCluodFunctions() async {
  //   final HttpsCallable callable =
  //       FirebaseFunctions.instanceFor(region: 'us-central1')
  //           .httpsCallable('functuion-1');
  //   final results = await callable(<String, dynamic>{'name': 'YourName'});
  //   print(results.data);
  // }

  // final List images = [
  // "images/image1.jpg",
  // "images/image2.jpg",
  // "images/image3.jpg",
  // "images/image4.jpg",
  // "images/image5.jpg",
  // "https://lh3.googleusercontent.com/p/AF1QipN7VB-ORFQ2SwUOiBbbD3I4crdBcYCHSkXPpu22=s1600-w400"
  // ];

  // final buttonImg = "images/button-img.jpg";

  @override
  Widget build(BuildContext context) {
    var scaffold = MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Sample1'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'メイン画面',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ],
                // color: Colors.green
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
                width: 80,
                height: 80,
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).accentColor, //ボタンの背景色
                  onPressed: () {}, //ボタンの関数
                  child: Icon(MyFlutterApp.button_img), //ボタンの画像
                )),
            bottomNavigationBar: BottomAppBar(
              color: Colors.white, //バーの色
              notchMargin: 0, // ボタンとバーのマージン
              shape: AutomaticNotchedShape(
                RoundedRectangleBorder(),
                StadiumBorder(
                  side: BorderSide(),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.person_outline,
                        color: Colors.green,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.green,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.green,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        color: Colors.green,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            )));
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
    return scaffold;
  }
}
