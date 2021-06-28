import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import 'dart:math' as math;

const kUrl1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';

class SlidingCardsView extends StatefulWidget {
  //AudioPlayer audioPlugin = AudioPlayer();

  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset = 0;
/*  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();*/
  String localFilePath;

  Future<void> _launched;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }
/*  Future<void> _launchUniversalLinkIos(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    }
  }*/
/*  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }*/
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String toLaunch = 'https://www.cylog.org/headers/';

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: PageView(
        controller: pageController,
        children: <Widget>[
          SlidingCard(
            name: 'Français',
            date: '4.20-30',
            assetName: 'paris.jpg',
           offset: pageOffset,
            /*   flatButton: FlatButton(onPressed:(){
              _launched = _launchInBrowser(toLaunch);
            }, child: Text("video"),
              color: Colors.blueAccent,
            ),*/
          ),
          SlidingCard(
            name: 'Anglais',
            date: '4.28-31',
            assetName: 'usa.jpg',
            offset: pageOffset - 1,
          ),
          SlidingCard(
            name: 'kissi',
            date: '4.28-31',
            assetName: 'kissi.jpg',
            offset: pageOffset - 2,
          ),
          SlidingCard(
            name: 'kpele',
            date: '4.28-31',
            assetName: 'kpele.jpg',
            offset: pageOffset - 3,
          ),
          SlidingCard(
              name: 'Malinkhé',
              date: '4.28-31',
              assetName: 'malinkhé.jpg',
              offset: pageOffset - 4),
          SlidingCard(
              name: 'Peulh',
              date: '4.28-31',
              assetName: 'peulh.jpeg',
              offset: pageOffset - 4),
          SlidingCard(
              name: 'Soussou',
              date: '4.28-31',
              assetName: 'soussou.jpg',
              offset: pageOffset - 5),
          SlidingCard(
              name: 'Toma',
              date: '4.28-31',
              assetName: 'toma.jpg',
              offset: pageOffset - 6),
        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name;
  final String date;
  final String assetName;
  final double offset;
  final FlatButton flatButton;


  const SlidingCard({
    Key key,
    @required this.name,
    @required this.date,
    @required this.assetName,
    @required this.offset,
    this.flatButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    const String toLaunch = 'https://www.cylog.org/headers/';

    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.asset(
                'assets/$assetName',
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.none,
              ),
            ),
            SizedBox(height: 6),
            Expanded(
              child: CardContent(
                name: name,
                date: date,
                offset: gauss,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;
  final double offset;
/*  var player = AudioCache();
  var player_ = AudioPlayer() ; // create this*/

/*  void _playFile() async{
    player_ = await player.play('disc.mpeg'); // assign player here
  }

  void _stopFile() {
    player_?.stop(); // stop the file like this
  }*/
  _launchUrl() async {
    final Uri uri = Uri(
      scheme: 'https',
      path: 'www.youtube.com/watch?v=XSh8CekUQ1w&feature=youtu.be',
      queryParameters: {
        'name': 'Woolha dot com',
        'about': 'Flutter Dart'
      },
    );
    final url = 'https://www.youtube.com/watch?v=XSh8CekUQ1w&feature=youtu.be';

  /*  if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }*/
  }
  CardContent(
      {Key key,
      @required this.name,
      @required this.date,
      @required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Transform.translate(
              offset: Offset(8 * offset, 0),
              child: Text(name, style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 8),
            Transform.translate(
              offset: Offset(32 * offset, 0),
              child: Text(
                date,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  color: Color(0xFF98112B),
                  iconSize: 18.0,
                    onPressed: () {
                    //_launchUrl();
                /*     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VideoApp()),
                      );*/
                    }                ),
                IconButton(
                  icon: Icon(Icons.pause_circle_filled),
                  color: Color(0xFF98112B),
                  iconSize: 18.0,
                  /*onPressed: () =>  _stopFile(),*/
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );

  }
}
