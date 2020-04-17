import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(home:MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _location = "Obteniendo ubicacion...";
  @override
  void initState() {
    super.initState();
        ////
    // 1.  Listen to events (See docs for all 12 available events).
    //

    // Fired whenever a location is recorded
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      setState(() {
        _location = location.coords.latitude.toString()+" | "+location.coords.longitude.toString();
      });
      Fluttertoast.showToast(
        msg: '[location] - $location',
        toastLength: Toast.LENGTH_SHORT,
        //gravity: ToastGravity.CENTER,
        //timeInSecForIosWeb: 1,
        //backgroundColor: Colors.red,
        //textColor: Colors.white,
        fontSize: 16.0
    );
      //print('[location] - $location');
    });

    // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
       setState(() {
        _location = location.coords.latitude.toString()+" | "+location.coords.longitude.toString();
      });
      Fluttertoast.showToast(
        msg: '[motionchange] - $location',
        toastLength: Toast.LENGTH_SHORT,
        //gravity: ToastGravity.CENTER,
        //timeInSecForIosWeb: 1,
        //backgroundColor: Colors.red,
        //textColor: Colors.white,
        fontSize: 16.0
    );
      //print('[motionchange] - $location');
    });

    // Fired whenever the state of location-services changes.  Always fired at boot
    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
      Fluttertoast.showToast(
        msg: '[providerchange] - $event',
        toastLength: Toast.LENGTH_SHORT,
        //gravity: ToastGravity.CENTER,
        //timeInSecForIosWeb: 1,
        //backgroundColor: Colors.red,
        //textColor: Colors.white,
        fontSize: 16.0
    );
      //print('[providerchange] - $event');
    });

    ////
    // 2.  Configure the plugin
    //
    bg.BackgroundGeolocation.ready(bg.Config(
        notification: bg.Notification(
          title: "Name APP",
          text: "Ubicación activada"
        ),
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        distanceFilter: 10.0,
        stopOnTerminate: true,
        startOnBoot: true,
        debug: true,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE
    )).then((bg.State state) {
      if (!state.enabled) {
        ////
        // 3.  Start the plugin.
        //
        bg.BackgroundGeolocation.start();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(_location, style: TextStyle(fontSize: 30.0)),
              )
            ],
          ),
        ),
      ),
    );
  }
}