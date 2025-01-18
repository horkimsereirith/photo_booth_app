import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key, this.onAction});

  final Function(RTCVideoRenderer renderer)? onAction;

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  MediaStream? _localStream;

  @override
  void initState() {
    super.initState();
    initRenderers();
    _connect(context);
  }

  initRenderers() async {
    await _localRenderer.initialize();
  }

  void _connect(BuildContext context) async {
    try {
      var cameraDevices = await navigator.mediaDevices.enumerateDevices();
      if (cameraDevices.any((device) => device.kind == 'videoinput')) {
        // Request the video stream
        _localStream = await navigator.mediaDevices.getUserMedia({
          'video': {'facingMode': 'environment'},
          'audio': false
        });

        // Assign the stream to the renderer
        _localRenderer.srcObject = _localStream;
        setState(() {});
      } else {
        print("No camera available");
      }
    } catch (e) {
      print("Error accessing camera: $e");
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    _disposeCamera();
  }

  Future<void> _disposeCamera() async {
    // Dispose of the renderer
    _localRenderer.srcObject = null;
    await _localStream?.dispose(); // Dispose of the MediaStream
    _localRenderer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.onAction!(_localRenderer);

    return RTCVideoView(_localRenderer);
  }
}
