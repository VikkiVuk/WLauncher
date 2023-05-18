import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:window_manager/window_manager.dart';
import 'package:wlauncher/main.dart';
import 'package:wlauncher/pages/main/play_game.dart';

import 'login.dart';

class LoadingScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const LoadingScreen({Key? key, required this.navigatorKey}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _showShimmer = false;

  void setWindowSize(Size size) async {
    WindowManager.instance.setSize(size, animate: true);
    WindowManager.instance.center();
    WindowManager.instance.setMinimumSize(size);
    WindowManager.instance.setMaximumSize(size);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setWindowSize(const Size(250, 150));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0c0c0c),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('powered by', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.white)),
            const SizedBox(height: 8.0),
            Stack(
              children: [
                Visibility(
                  visible: !_showShimmer,
                  maintainSize: false,
                  child: SizedBox(
                    width: 250.0,
                    child: TypewriterAnimatedTextKit(
                      repeatForever: false,
                      speed: const Duration(milliseconds: 200),
                      totalRepeatCount: 1,
                      text: const ['Wulfco'],
                      textStyle: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFF4444),
                      ),
                      textAlign: TextAlign.center,
                      onFinished: () {
                        setState(() {
                          _showShimmer = true;

                          Future.delayed(const Duration(seconds: 3), () {
                            widget.navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) {
                              return PlayGame(navigatorKey: navigatorKey);
                            })).then((_) {
                              Future.delayed(const Duration(milliseconds: 200), () {
                                setState(() {});
                              });
                            });
                          });
                        });
                      },
                    ),
                  ),
                ),
                Visibility(
                    visible: _showShimmer,
                    maintainSize: false,
                    child: Container(
                      margin: const EdgeInsets.only(right: 2.0),
                      child: Center(
                        child: Shimmer.fromColors(
                            baseColor: const Color(0xFFFF4444),
                            highlightColor: const Color(0xFFFF2344),
                            child: const Text('Wulfco', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white))
                        ),
                      )
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
