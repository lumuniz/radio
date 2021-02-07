import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Radio Nossa Terra',
        theme: ThemeData.dark(),
        home: MyHomePage(title: 'Radio Nossa Terra'));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Icon icon;

  var iconPlay = Icon(
    Icons.play_arrow,
    size: 80,
    color: Colors.black,
  );

  var iconPause = Icon(
    Icons.pause,
    size: 80,
    color: Colors.black,
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
        color: Colors.grey[500],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              height: 50,
            ),
            Container(
              height: 200,
              width: 350,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey[700]),
              child: Center(
                child: InkWell(
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
                    child: icon),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
