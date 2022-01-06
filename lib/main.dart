import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final StreamController _streamController = StreamController();

  // addData() async {
  //   for (int i = 1; i <= 20; i++) {
  //     await Future.delayed(Duration(seconds: 2));
  //     _streamController.sink.add(i);
  //   }
  // }
  Stream<int> numberStream() async* {
    for (int i = 1; i <= 20; i++) {
      await Future.delayed(Duration(seconds: 2));
      yield i;
    }
  }

  @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _streamController.close();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //addData();
    numberStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
                stream: numberStream().where((number) => number % 2 == 0),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Text('the data has a error');
                  else if (snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();
                  return Text(
                    '${snapshot.data}',
                    style: TextStyle(fontSize: 100),
                  );
                })
          ],
        ),
      ),
    );
  }
}
