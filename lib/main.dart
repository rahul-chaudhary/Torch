import 'package:flutter/material.dart';
import 'package:flashlight/flashlight.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColorLight: Colors.white70,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFlashOn = false;
  bool isDeviceHasFlash = false;
  Color flashIconColor = Colors.red;
  IconData flashIcon = Icons.flash_off_outlined;
  // IconData flashOnIcon = Icons.flash_on;

  void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message, //message to show toast
      toastLength: Toast.LENGTH_SHORT, //duration for message to show
      gravity: ToastGravity.BOTTOM, //where you want to show, top, bottom
      // timeInSecForIosWeb: 1, //for iOS only
      //backgroundColor: Colors.red, //background Color for message
      // textColor: Colors.white, //message text color
      // fontSize: 16.0 //message font size
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      //we use Future.delayed because there is async function inside it.
      bool isThereLight = await Flashlight.hasFlashlight;
      setState(() {
        isDeviceHasFlash = isThereLight;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Torch",
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: Colors.black54,
      ),
      body: Center(
        child: TextButton.icon(
            label: const Text(""),
            icon: Icon(
              flashIcon,
              color: flashIconColor,
              size: 200,
            ),
            onPressed: () {
              if (isDeviceHasFlash == true) {
                if (isFlashOn == false) {
                  setState(() {
                    Flashlight.lightOn();
                    flashIcon = Icons.flash_on;
                    flashIconColor = Colors.green;
                    isFlashOn = true;
                  });
                } else {
                  setState(() {
                    Flashlight.lightOff();
                    flashIcon = Icons.flash_off_outlined;
                    flashIconColor = Colors.red;
                    isFlashOn = false;
                  });
                }
              } else {
                showToastMessage("Device has no flash!");
              }
            }),
      ),
    );
  }
}
