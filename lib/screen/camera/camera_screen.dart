import 'package:flutter/material.dart';
import 'package:photo_booth_app/screen/camera/widget/camera_widget.dart';
import 'package:photo_booth_app/widget/app_bar_widget.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
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
                child: CameraWidget(),
              ),
            ),
          ),
          SizedBox(height: 20), // Space between the container and button
          ElevatedButton(
            onPressed: () {
              // Button action here
              print('Button Pressed');
            },
            child: Text('Click Me'),
          ),
        ],
      )),
    );
  }
}
