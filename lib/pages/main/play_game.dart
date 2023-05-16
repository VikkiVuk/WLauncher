import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:window_manager/window_manager.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:wlauncher/pages/main/instances/select_version.dart';
import 'package:wlauncher/pages/main/sidebar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1123, 655),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    minimumSize: Size(1123, 655),
    maximumSize: Size(1123, 655),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.center();
  });

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PlayGame(),
  ));
}

class PlayGame extends StatefulWidget {
  final selectedVersion;
  final selectedProfile;

  const PlayGame({Key? key, this.selectedProfile, this.selectedVersion}) : super(key: key);

  @override
  _PlayGameState createState() => _PlayGameState();
}

class _PlayGameState extends State<PlayGame> {
  String _selectedVersion = "1.18.2";
  String _selectedProfile = "Vanilla";

  void setWindowSize(Size size) async {
    await windowManager.setSize(size, animate: true);
    await windowManager.setMinimumSize(size);
    await windowManager.setMaximumSize(size);

    await windowManager.center();
  }

  @override
  void initState() {
    super.initState();

    setWindowSize(const Size(1123, 655));

    if (widget.selectedVersion != null) {
      _selectedVersion = widget.selectedVersion;
    }

    if (widget.selectedProfile != null) {
      _selectedProfile = widget.selectedProfile;
    }
  }

  void sidebarButtonClicked(String button) {
    if (button == "instances") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SelectVersion()),
      );
    }
  }

  void play() {
    print("play");
  }

  @override
  Widget build(BuildContext context) {
    setWindowSize(const Size(1123, 655));

    return Material(
        child: Directionality(textDirection: TextDirection.ltr, child: Row(
          children: [
            Sidebar(onSidebarButtonPressed: sidebarButtonClicked, selected: 0),
            Container(
              width: 879,
              height: 655,
              color: const Color(0xFF000000),
              child: Stack(
                children: [
                  Image.asset("assets/minecraft.png", width: 879, height: 505),
                  Center(child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF0c0c0c),
                    ),
                    width: 830,
                    height: 134,
                    margin: const EdgeInsets.only(top: 420),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(padding: EdgeInsets.only(top: 15), child: Text("PLAY MINECRAFT", style: TextStyle(color: Color(0xFF4c4c4c), fontSize: 16, fontWeight: FontWeight.w900)),),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(padding: const EdgeInsets.only(top: 10), child:
                                        Text(_selectedVersion, style: const TextStyle(color: Color(0xFF969696), fontSize: 32, fontWeight: FontWeight.w600)),
                                      ),
                                      if (_selectedProfile != "Vanilla") Padding(padding: const EdgeInsets.only(left: 8, top: 10), child:
                                          Text(_selectedProfile, style: const TextStyle(color: Color(0xFF6f6f6f), fontSize: 24, fontWeight: FontWeight.w600)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 18),
                                child: GestureDetector(
                                    onTap: () => {play()},
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Container(
                                          width: 187,
                                          height: 79,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: const Color(0xFF007BFF),
                                          ),
                                          child: const Center(
                                            child: Text("PLAY", style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 24, fontWeight: FontWeight.w900)),
                                          )
                                      ),
                                    )
                                ),
                              ),
                            ]
                        )
                    ),
                  ))
                ],
              ),
            )
          ],
        )
        )
    );
  }
}

