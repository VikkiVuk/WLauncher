import 'package:flutter/material.dart';
import 'package:wlauncher/pages/main/instances/select_profile.dart';
import 'package:wlauncher/pages/main/play_game.dart';
import 'package:wlauncher/pages/main/sidebar.dart';

import '../get_modpacks.dart';
import '../get_resourcepacks.dart';

class SelectVersion extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const SelectVersion({Key? key, required this.navigatorKey}) : super(key: key);

  @override
  _SelectVersionState createState() => _SelectVersionState();
}

class _SelectVersionState extends State<SelectVersion> {
  String _selectedVersion = "1.18.2";
  List<String> versions = ["1.18.2", "1.16.4", "1.12.2"];

  void sidebarButtonClicked(String button) {
    if (button == "play") {
      widget.navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => PlayGame(navigatorKey: widget.navigatorKey)));
    } else if (button == "modpacks") {
      widget.navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => GetModpacks(navigatorKey: widget.navigatorKey)));
    } else if (button == "resourcepacks") {
      widget.navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => GetResourcepacks(navigatorKey: widget.navigatorKey)));
    }
  }

  void addVersionClicked() {
    print("add version");
  }

  void selectVersionClicked(String version) {
    _selectedVersion = version;

    widget.navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => SelectProfile(selectedVersion: _selectedVersion, navigatorKey: widget.navigatorKey)));
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Directionality(textDirection: TextDirection.ltr, child: Row(children: [
      Sidebar(onSidebarButtonPressed: sidebarButtonClicked, selected: 1),
      Container(
          color: const Color(0xFF000000),
          width: 879,
          height: 655,
          child: Padding(padding: const EdgeInsets.only(top: 10), child: Stack(
              children: [
                Column(children: [
                  Expanded(child: SizedBox(
                    height: 761,
                    child: ListView.builder(itemBuilder: (BuildContext ctx, int index) {
                      return Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 40, right: 40, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF0c0c0c),
                        ),
                        height: 79,
                        width: 761,
                        child: Row(
                          children: [
                            Padding(padding: const EdgeInsets.only(left: 20), child: Text(versions[index], style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700))),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedVersion = versions[index];
                                });
                              },
                              child: GestureDetector(
                                  onTap: () => {selectVersionClicked(versions[index])},
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Container(
                                        width: 166,
                                        height: 58,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: const Color(0xFF007BFF),
                                        ),
                                        child: const Center(
                                          child: Text("SELECT", style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 24, fontWeight: FontWeight.w900)),
                                        )
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      );
                    }, itemCount: versions.length),
                  ))]),
                Padding(padding: const EdgeInsets.only(left: 40, right: 40, top: 500), child: GestureDetector(
                  onTap: () => {addVersionClicked()},
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                        width: 807,
                        height: 79,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: (versions.length >= 5) ? const Color(0xFF007BFF) : Colors.transparent,
                          border: Border.all(color: (versions.length >= 5) ? const Color(0xff000000) : const Color(0xFF007BFF), width: 5),
                        ),
                        child: const Center(
                          child: Text("+ ADD VERSION", style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 24, fontWeight: FontWeight.w900)),
                        )
                    ),
                  ),
                ),)
              ])))
    ])));
  }
}
