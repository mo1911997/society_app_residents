import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:societyappresidents/ui/MainPage.dart';

class Walkthrough extends StatefulWidget {
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => MainPage()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'images/$assetName.jpg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = const PageDecoration(
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.cyan,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Fractional shares",
          body:
          "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('img1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Learn as you go",
          body:
          "Download the Stockpile app and master the market with our mini-lesson.",
          image: _buildImage('img2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Kids and teens",
          body:
          "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          image: _buildImage('img3'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Another title page",
          body: "Another beautiful body text for this example onboarding",
          image: _buildImage('img2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Title of last page",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Click on "),
              Icon(Icons.edit),
              Text(
                " to edit a post",
              ),
            ],
          ),
          image: _buildImage('img1'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      globalBackgroundColor: Colors.cyan,
      curve: Curves.easeInToLinear,

      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text(
        'Done',
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.black,
        activeColor: Colors.black26,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
