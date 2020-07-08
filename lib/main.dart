import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'dart:async';


_launchURL() async {
  const url = 'https://en.wikipedia.org/wiki/5G';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '5g Radiation Protection',
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
      home: MyHomePage(title: '5g Radiation Protection'),
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
  bool _protected = false;
  double _progress = 0.0;

  final snackbarText = ['finding illuminati', 'finding the moon landing movie set', 'calling E.T.', 'distrusting mainstream media', 'applying tinfoil to hat', 'finding out who built the pyramids', 'removing chemtrails', 'scanning area 51', 'cropping circle', 'believing my uncle at thanksgiving', 'overlooking scientific reports'];
  int snackBarIndex = 0;

  void _updateProgress(t, context) {
    // print(context);


    var snackBar = new SnackBar(
                content: Text(snackbarText[snackBarIndex]),
                duration: Duration(milliseconds : 1000),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
                behavior: SnackBarBehavior.floating,
              );

    snackBarIndex = snackBarIndex + 1 >= snackbarText.length ? 0 : snackBarIndex + 1;

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);

    // print('updating');
    // print(_progress);
    if (_progress >= 1.0) {
      _progress = 1.0;
      // print('canceling');
      t.cancel();
      setState(() {
        _protected = true;
      });
    } else {
      setState(() {
        _progress += 0.05;
      });
    }
  }

  void _incrementCounter(context) {
    if (!_protected) {
      // const twentyMillis = const Duration(milliseconds:100);
      const second = const Duration(seconds:1);
      new Timer.periodic(second, (Timer t) => _updateProgress(t, context));
    }
    setState(() {
      if (_protected) {
        _progress = 0.0;
        _protected = false;
      }
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _protected = !_protected;
    });
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
         actions: <Widget>[
            // action button
            RaisedButton(
              onPressed: _launchURL,
              textColor: Colors.white,
              color: Colors.blue,
              child: Text(
                'Click here first!',
                style: TextStyle(fontSize: 20)
              ),
            ),
          ],
      ),
      body: Builder(
          // Create an inner BuildContext so that the onPressed methods
          // can refer to the Scaffold with Scaffold.of().
          builder: (BuildContext context) {
            return Center(
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
                  Image.network(
                    _protected ? 'https://cdn2.iconfinder.com/data/icons/flat-design-basic-set-9/24/secure-shield-verfied-protected-checked-512.png' : 'https://99percentinvisible.org/app/uploads/2018/01/bio99pi.jpg,', height: 200,
                  ),
                  Text(
                    _protected ? 'You are now completely safe from 5g radiation' : 'Warning: You are as exposed to 5g radiation as everybody else!',
                  ),
                  RaisedButton(
                    onPressed: () => _incrementCounter(context),
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text(
                      _protected ? 'deProtect...' : 'Enable automatic 5g protection!',
                      style: TextStyle(fontSize: 20)
                    ),
                  ),
                  FAProgressBar(
                    currentValue: (_progress * 100.0).round(),
                    displayText: '%',
                  ),
                ],
              ),
            );
          },
        ),
      );
  }
}
