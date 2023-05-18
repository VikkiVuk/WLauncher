import 'package:flutter/material.dart';
import 'package:wlauncher/main.dart';
import 'package:wlauncher/pages/main/instances/get_mods.dart';
import 'package:wlauncher/pages/main/instances/select_profile.dart';
import 'package:wlauncher/pages/main/play_game.dart';
import 'package:wlauncher/pages/main/sidebar.dart';

class MainInstance extends StatefulWidget {
  final selectedVersion;
  final selectedProfile;
  final GlobalKey<NavigatorState> navigatorKey;

  const MainInstance({Key? key, this.selectedProfile, this.selectedVersion, required this.navigatorKey}) : super(key: key);

  @override
  _MainInstanceState createState() => _MainInstanceState();
}

class _MainInstanceState extends State<MainInstance> {
  String _selectedVersion = "1.18.2";
  String _selectedProfile = "Vanilla";
  List<String> mods = ["Optifine", "Pure Chaos", "Cma", "Bruh", "Kruh", "Cc", "ccccccc", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "ccccccc", "ccccccc", "ccccccc", "ccccccc", "ccccccc", "ccccccc", "ccccccc", "ccccccc", "ccccccc", "ccccccc", "ccccccc", "ccccccc", "ccccccc"];

  @override
  void initState() {
    super.initState();

    _selectedVersion = widget.selectedVersion;
    _selectedProfile = widget.selectedProfile;
  }

  void sidebarButtonClicked(String button) {
    if (button == "play") {
      widget.navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => PlayGame(selectedVersion: _selectedVersion, selectedProfile: _selectedProfile, navigatorKey: widget.navigatorKey)));
    }
  }

  void addModsClicked() {
    widget.navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => GetMods(selectedVersion: _selectedVersion, selectedProfile: _selectedProfile, navigatorKey: widget.navigatorKey)));
  }

  void removeModClicked(String mod) {
    print("remove mod");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            Sidebar(onSidebarButtonPressed: sidebarButtonClicked, selected: 1),
            Container(
              color: const Color(0xFF000000),
              width: 879,
              height: 655,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.only(top: 30, left: 30), child: Text(_selectedProfile, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700))),
                    Stack(
                        children: [
                          Container(
                            width: 879,
                            height: 400,
                            margin: const EdgeInsets.only(top: 10, left: 20, right: 30),
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5, // Maximum 5 items on the horizontal side
                              ),
                              itemCount: mods.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xFF0c0c0c),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20), child: Text(mods[index], style: const TextStyle(color: Colors.white, overflow: TextOverflow.ellipsis, fontSize: 16, fontWeight: FontWeight.w700))),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: GestureDetector(
                                          onTap: () => removeModClicked(mods[index]),
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: Container(
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: const Color(0xFF000000),
                                              ),
                                              child: const Center(child: Text("uninstall", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal), textAlign: TextAlign.center)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: GestureDetector(
                                          onTap: () => removeModClicked(mods[index]),
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: Container(
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: const Color(0xFF000000),
                                              ),
                                              child: const Center(child: Text("disable", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal), textAlign: TextAlign.center)),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(left: 40, right: 40, top: 440), child: GestureDetector(
                            onTap: () => {addModsClicked()},
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                  width: 807,
                                  height: 79,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.transparent,
                                    border: Border.all(color: const Color(0xFF007BFF), width: 5),
                                  ),
                                  child: const Center(
                                    child: Text("+ ADD MODS", style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 24, fontWeight: FontWeight.w900)),
                                  )
                              ),
                            ),
                          ),)
                        ])
                  ]),
            )
          ],
        ),
      ),
    );
  }

}