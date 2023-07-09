import 'package:flutter/material.dart';
import 'package:spine_flutter/spine_flutter.dart'; // …1.

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // …2.
  await initSpineFlutter(enableMemoryDebugging: false); // …2.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SpineExamplePage(),
    );
  }
}

class SpineExamplePage extends StatelessWidget {
  const SpineExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SpineWidgetController(onInitialized: (controller) {
      controller.animationState.setAnimationByName(0, "walk", true);
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Spine Example')),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.pink,
            ),
            height: 400,
            width: 400,
            child: SpineWidget.fromAsset("assets/spineboy-pro.atlas",
                "assets/spineboy-pro.json", controller), // …3.
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                // …4.
                if (controller.animationState
                        .getCurrent(0)
                        ?.getAnimation()
                        .getName() ==
                    "walk") {
                  controller.animationState.setAnimationByName(0, "idle", true);
                } else {
                  controller.animationState.setAnimationByName(0, "walk", true);
                }
              },
              child: const Text('Toggle Animation'))
        ],
      )),
    );
  }
}
