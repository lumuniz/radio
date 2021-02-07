import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
                BouncingScrollWrapper.builder(context, widget),
                maxWidth: 1920,
                minWidth: 600,
                defaultScale: true,
                breakpoints: [
                  ResponsiveBreakpoint.autoScale(
                    450,
                    name: MOBILE,
                    scaleFactor: .35,
                  ),
                  ResponsiveBreakpoint.autoScale(
                    600,
                    name: TABLET,
                    scaleFactor: .45,
                  ),
                  ResponsiveBreakpoint.autoScale(
                    800,
                    name: TABLET,
                    scaleFactor: .65,
                  ),
                  ResponsiveBreakpoint.autoScale(
                    1000,
                    name: TABLET,
                    scaleFactor: .75,
                  ),
                  ResponsiveBreakpoint.autoScale(
                    1200,
                    name: DESKTOP,
                    scaleFactor: .85,
                  ),
                  ResponsiveBreakpoint.autoScale(
                    2460,
                    name: "4K",
                    scaleFactor: .9,
                  ),
                ]),
        debugShowCheckedModeBanner: false,
        title: 'Rádio Nossa Terra',
        theme: ThemeData.dark(),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Icon icon;

  var iconPlay = Icon(
    Icons.play_arrow,
    size: 80,
    color: Colors.grey[850],
  );

  var iconPause = Icon(
    Icons.pause,
    size: 80,
    color: Colors.grey[850],
  );

  @override
  void initState() {
    // TODO: implement initState
    icon = iconPlay;
    super.initState();
  }

  final assetsAudioPlayer = AssetsAudioPlayer();
  Size get size => MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.grey[400],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/morros_linha.png'),
            SizedBox(
              height: 50,
            ),
            Text(
              'RÁDIO NOSSA TERRA 105,9FM',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              width: 280,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.alarm),
                    DigitalClock(
                      areaWidth: 200,
                      showSecondsDigit: false,
                      is24HourTimeFormat: false,
                      areaDecoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      hourMinuteDigitTextStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 50,
                          fontWeight: FontWeight.w300),
                      amPmDigitTextStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      hourMinuteDigitDecoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 250,
                  width: 400,
                  child: Image.asset('assets/images/radio_volume.png'),
                ),
                InkWell(
                  child: icon,
                  onTap: () async {
                    try {
                      await assetsAudioPlayer.open(
                        Audio.liveStream(
                            "http://198.7.58.248:11845/;stream.mp3"),
                      );
                      setState(() {
                        if (icon == iconPlay) {
                          assetsAudioPlayer.play();
                          icon = iconPause;
                        } else {
                          assetsAudioPlayer.pause();
                          icon = iconPlay;
                        }
                      });
                    } catch (t) {
                      //stream unreachable
                    }
                  },
                ),
              ],
            ),
            Icon(
              Icons.menu,
              color: Colors.grey[850],
              size: 50,
            ),
          ],
        ),
      ),
    ));
  }
}
