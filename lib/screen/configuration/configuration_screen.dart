import 'package:flutter/material.dart';
import 'package:photo_booth_app/screen/camera/camera_screen.dart';
import 'package:photo_booth_app/widget/app_bar_widget.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key, required this.title});
  final String title;

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(title: widget.title),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const CameraScreen(title: 'Camera')));
                  },
                  child: const Text('Go to Camera'),
                )
              ],
            ),
          ),
        ));
  }
}
