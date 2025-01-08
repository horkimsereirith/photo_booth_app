import 'package:flutter/material.dart';
import 'package:photo_booth_app/screen/configuration/configuration_screen.dart';
import 'package:photo_booth_app/widget/app_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: widget.title),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const ConfigurationScreen(title: 'Configuration')));
              },
              child: const Text('Go to configuration'),
            )
          ],
        ),
      ),
    );
  }
}
