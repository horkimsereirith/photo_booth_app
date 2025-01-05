import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  final RTCVideoRenderer videoRenderer = RTCVideoRenderer();

  @override
  void initState() {
    videoRenderer.initialize();
    super.initState();
  }

  @override
  void dispose() {
    videoRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 500,
          height: 300, // Adjust height as needed
          child: RTCVideoView(videoRenderer, mirror: true)),
    );
  }
}
