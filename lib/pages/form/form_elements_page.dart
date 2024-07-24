import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flareline/pages/layout.dart';
import 'package:video_player_web/video_player_web.dart'; // Import the video_player_web package

class FormElementsPage extends LayoutWidget {
  FormElementsPage({Key? key}) : super(key: key);

  @override
  String breakTabTitle(BuildContext context) {
    return AppLocalizations.of(context)!.formElements;
  }

  @override
  Widget contentDesktopWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text(
            'Form Elements',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          // Description
          Text(
            'Explore various form elements and components.',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 20.0),
          // Video Player
          VideoPlayerWidget(videoUrl: 'assets/video.mp4'), // Add your video file here
          SizedBox(height: 20.0),
          // Preventive Measures Section
          Text(
            'Preventive Measures',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Here are some preventive measures for asthma:',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            '1. Avoid triggers such as smoke, dust, and pollen.',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Text(
            '2. Use allergen-proof bedding covers.',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Text(
            '3. Keep indoor humidity levels low.',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Text(
            '4. Maintain a clean and dust-free environment.',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 20.0),
          // Asthma Pump Usage Section
          Text(
            'Asthma Pump Usage',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Here are some important facts and preventive measures for using asthma pumps:',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            '1. Always carry your asthma pump with you, especially when engaging in physical activities or traveling.',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Text(
            '2. Follow the prescribed dosage and instructions provided by your healthcare provider.',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Text(
            '3. Keep your asthma pump clean and store it in a cool, dry place.',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Text(
            '4. Monitor your asthma symptoms regularly and seek medical attention if they worsen.',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({required this.videoUrl, Key? key}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoElement _videoElement;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    _videoElement = VideoElement()
      ..src = widget.videoUrl
      ..style.border = 'none'
      ..style.width = '100%'; // Adjust video width as needed
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9, // Adjust aspect ratio as needed
      child: HtmlElementView(viewType: 'video-player', key: UniqueKey()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (kIsWeb) {
      // Append the video element to the body when the widget is added to the tree
      _videoElement.addEventListener('loadedmetadata', (_) {
        setState(() {});
      });
      _videoElement.play();
    }
  }
}
