import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:photo_booth_app/providers/config_provider.dart';
import 'package:photo_booth_app/screens/camera/widget/camera_widget.dart';
import 'package:photo_booth_app/widgets/app_bar_widget.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  RTCVideoRenderer? _renderer;
  String? _appPath;
  p.Context? _platformContext;

  String? _currentProcessId;
  int? _captureIntervalSecond;
  int? _captureCount;

  int _currentCountdown = 0;

  @override
  void initState() {
    super.initState();
    _initializeAppDocumentsDirectory();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var configProvider =
          Provider.of<ConfigurationProvider>(context, listen: false);
      _currentProcessId = configProvider.currentProcessId;
      _captureIntervalSecond = configProvider.captureIntervalSecond;
      _captureCount = configProvider.captureCount;
    });
  }

  void _initializeAppDocumentsDirectory() {
    var context = p.Context(style: p.Style.platform);
    final directory = context.join(
      'C:',
      'Users',
      'Dell',
      'Desktop',
      'photo_booth_img',
    );
    setState(() {
      _platformContext = context;
      _appPath = directory;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBarWidget(title: widget.title),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: screenWidth * 0.7, // 50% of the screen width
              height: screenHeight * 0.5, // 30% of the screen height
              color: Colors.blue,
              child: Center(
                child: CameraWidget(
                  onAction: (renderer) {
                    _renderer = renderer; // Capture the renderer
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 20), // Space between the container and button
          ElevatedButton(
            onPressed: () async {
              if (_captureCount != null && _captureIntervalSecond != null) {
                setState(() {
                  _currentCountdown = _captureIntervalSecond!;
                });

                for (int i = 0; i <= _captureCount!; i++) {
                  // Countdown logic
                  for (int second = _captureIntervalSecond!;
                      second > 0;
                      second--) {
                    setState(() {
                      _currentCountdown = second;
                    });
                    await Future.delayed(Duration(seconds: 1));
                  }

                  final videoTrack =
                      _renderer?.srcObject!.getVideoTracks().first;
                  final frame = await videoTrack!.captureFrame();

                  final filePath = _platformContext!
                      .join(_appPath!, "${_currentProcessId}__$i.png");

                  print("Capture$filePath");

                  final file = File(filePath);
                  await file.writeAsBytes(frame.asUint8List());

                  setState(() {
                    _currentCountdown = 0;
                  });
                }
              }
            },
            child: Text('Take Picture'),
          ),
          SizedBox(height: 20),
          Text(
            "Next capture in: $_currentCountdown seconds",
            style: TextStyle(fontSize: 18),
          )
        ],
      )),
    );
  }
}
