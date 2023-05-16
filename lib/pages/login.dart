import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(672, 358),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    minimumSize: Size(672, 358),
    maximumSize: Size(672, 358),
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const Login());
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  bool isButton1Selected = true;
  late AnimationController _controller;
  late Animation<double> _animation;
  late ImageProvider _image;
  double _containerPosition = 16.0;

  void setWindowSize(Size size) async {
    await windowManager.setSize(size, animate: true);
    await windowManager.setMinimumSize(size);
    await windowManager.setMaximumSize(size);

    await windowManager.center();
  }

  @override
  void initState() {
    super.initState();

    setWindowSize(const Size(672, 358));

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _animation = Tween<double>(begin: 16.0, end: 166.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _containerPosition = _animation.value;
        });
      });
    _image = const AssetImage('assets/microsoft_button.png');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onButton1Pressed() {
    if (!isButton1Selected) {
      isButton1Selected = true;
      _controller.reverse();
      _image = const AssetImage('assets/microsoft_button.png');
    }
  }

  void _onButton2Pressed() {
    if (isButton1Selected) {
      isButton1Selected = false;
      _controller.forward();
      _image = const AssetImage('assets/wulfco_button.png');
    }
  }

  void _onImageButtonPressed() async {
    late String url;
    if (isButton1Selected) {
      url = 'https://microsoft.com';
    } else {
      url = 'https://id.wulfco.xyz';
    }

    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    setWindowSize(const Size(672, 358));

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0XFF0c0c0c),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: 320,
                    height: 72,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF3a3a3a),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: _containerPosition,
                            top: 9,
                            child: Container(
                              width: 136,
                              height: 55,
                              decoration: BoxDecoration(
                                color: const Color(0XFF232323),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            top: 9,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: _onButton1Pressed,
                                child: SizedBox(
                                  width: 136,
                                  height: 55,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Premium',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ),
                          Positioned(
                            right: 16,
                            top: 9,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: _onButton2Pressed,
                                child: SizedBox(
                                  width: 136,
                                  height: 55,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Cracked',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                      onTap: _onImageButtonPressed,
                      child: Container(
                        margin: const EdgeInsets.only(top: 14.0),
                        width: 454,
                        height: 94,
                        child: Image(
                          image: _image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
