import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int batteryLevel = 0;
  Future<void> geyBatteryLevel() async {
    const platform = MethodChannel('course.flutter.dev/battery');
    try {
      final getBatteryLevel = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        batteryLevel = getBatteryLevel;
      });
    } on PlatformException catch (error) {
      setState(() {
        batteryLevel = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    geyBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native code'),
      ),
      body: Center(
        child: Text('Battery level:$batteryLevel'),
      ),
    );
  }
}
