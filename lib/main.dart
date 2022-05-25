import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native App',
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int? _batteryLevel;
  int? _androidVersion;

  Future _getBatteryLevel() async {
    const platform = MethodChannel('myapp.flutter.dev/channel_example');
    try {
      final batteryLevel = await platform.invokeMethod('getBatteryLevel');
      final androidVersion = await platform.invokeMethod('getAndroidVersion');
      setState(() {
        _batteryLevel = batteryLevel;
        _androidVersion = androidVersion;
      });
    } on PlatformException catch (e) {
      setState(() {
        _batteryLevel = null;
        _androidVersion = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              Text('Battery level: ${_batteryLevel}'),
              Text('Android version: ${_androidVersion}'),
            ],
          ),
        ),
      ],
    ));
  }
}
