import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setEnabledSystemUIOverlays([]);
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double count = 0;
  bool gameover = false;
  late AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final heightButton = height/10;
    final donvi = (height - heightButton*2) / 20;

    return Scaffold(
        body: Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        child: Column(
          children: <Widget>[
            RotationTransition(
              turns: AlwaysStoppedAnimation(180 / 360),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (count < (height/2)-heightButton-donvi*2 && gameover == false)
                      count += donvi;
                    else {
                      if(gameover==false)count += donvi;
                      gameover = true;
                      _controller.repeat();
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.cyan,
                  width: MediaQuery.of(context).size.width,
                  height: heightButton,
                  child: Text(
                    "TAP HERE",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: (height - heightButton*2),
              child: Column(
                children: [
                  Container(
                    color: Colors.yellow,
                    width: MediaQuery.of(context).size.width,
                    height: ((height - heightButton*2) / 2 + count > 0)
                        ? ((height - heightButton*2) / 2 + count)
                        : 0,
                    child: (gameover && count > 0)
                        ? FlatButton(
                            onPressed: () {
                              setState(() {
                                reset();
                              });
                            },
                            child: RotationTransition(
                              turns: new AlwaysStoppedAnimation(180 / 360),
                              child: customRotation("YELLOW"),
                            ),
                          )
                        : Text(""),
                  ),
                  Expanded(
                      child: Container(
                    color: Colors.red,
                    width: MediaQuery.of(context).size.width,
                    height: ((height - heightButton*2) / 2 + count >= height - heightButton*2)
                        ? 0
                        : (height - heightButton*2) / 2,
                    child: (gameover && count < 0)
                        ? FlatButton(
                            onPressed: () {
                              setState(() {
                                reset();
                              });
                            },
                            child: customRotation("RED"),
                          )
                        : Text(""),
                  ))
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  if (count > ((height/2)-heightButton-donvi*2)*-1 && gameover == false)
                    count -= donvi;
                  else {
                    if(gameover==false)count -= donvi;
                    gameover = true;
                    _controller.repeat();
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.cyan,
                width: MediaQuery.of(context).size.width,
                height: heightButton,
                child: Text(
                  "TAP HERE",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  reset() {
    this.gameover = false;
    this.count = 0;
  }

  Widget customRotation(String name) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Text(
        "$name WIN\nRESTART",
        style: TextStyle(
            color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
