import 'package:flutter/rendering.dart';
import 'package:partirecept/services/authService.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late VideoPlayerController _controller;
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/Cooking.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.setLooping(true);
          _controller.play();
        });
      });
  }

  renderVideoPlayer() {
    return _controller.value.isInitialized
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ))
        : Container();
  }

  renderButtons() {
    return Column(
      children: [
        FractionallySizedBox(
            widthFactor: 1.5,
            child: FloatingActionButton.extended(
              heroTag: "FAB1",
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              backgroundColor: secondaryYellow,
              icon: const Icon(Icons.create),
              label: Text("Register"),
              extendedPadding: const EdgeInsets.all(16.0),
            )),
        SizedBox(height: 10),
        FractionallySizedBox(
            widthFactor: 1.5,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              heroTag: "FAB2",
              backgroundColor: secondaryYellow,
              icon: const Icon(Icons.login),
              label: Text("Login"),
              extendedPadding: const EdgeInsets.all(16.0),
            )),
        SizedBox(height: 10),
        FractionallySizedBox(
            widthFactor: 1.5,
            child: FloatingActionButton.extended(
              heroTag: "FAB3",
              onPressed: () async {
                await _auth.signInAnonymously();
              },
              backgroundColor: primaryOrange,
              icon: const Icon(Icons.navigate_next),
              label: Text("Continue as a guest"),
              extendedPadding: const EdgeInsets.all(16.0),
            )),
      ],
    );
  }

  renderLogoAndTitle() {
    return Column(
      children: [
        SizedBox(height: 50),
        Center(
          child: Text(
            'PartiRecept',
            style: TextThemeOswald(Colors.white).headline2,
          ),
        ),
        Center(
            child: Image(
          image: AssetImage('assets/images/logo.png'),
          width: 150,
          height: 150,
        )),
        SizedBox(height: 30),
        Center(
          child: Text(
            'Woensel welcomes you!',
            style: GoogleFonts.kalam(fontSize: 30, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landing page video',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: renderVideoPlayer(),
            ),
            renderLogoAndTitle()
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FractionallySizedBox(
          widthFactor: 0.5,
          child: SizedBox(
            width: 350,
            height: 200,
            child: renderButtons(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //_controller.dispose();
  }
}
