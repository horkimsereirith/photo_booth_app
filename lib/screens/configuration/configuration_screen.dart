import 'package:flutter/material.dart';
import 'package:photo_booth_app/providers/config_provider.dart';
import 'package:photo_booth_app/screens/camera/camera_screen.dart';
import 'package:photo_booth_app/widgets/app_bar_widget.dart';
import 'package:provider/provider.dart';

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
                    context.read<ConfigurationProvider>().setCurrentProcess();
                    context
                        .read<ConfigurationProvider>()
                        .setCaptureIntervalSecond(second: 5);
                    context
                        .read<ConfigurationProvider>()
                        .setCaptureCount(value: 2);

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
