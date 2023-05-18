import 'package:flutter/material.dart';
import 'package:wlauncher/pages/main/instances/main_instance.dart';
import 'package:wlauncher/pages/main/play_game.dart';
import 'package:wlauncher/pages/main/sidebar.dart';

class SelectProfile extends StatefulWidget {
  final String selectedVersion;
  final GlobalKey<NavigatorState> navigatorKey;

  const SelectProfile({Key? key, required this.selectedVersion, required this.navigatorKey}) : super(key: key);

  @override
  _SelectProfileState createState() => _SelectProfileState();
}

class _SelectProfileState extends State<SelectProfile> {
  String _selectedProfile = "Vanilla";
  String _selectedVersion = "1.18.2";
  List<String> profiles = ["Vanilla", "Sussy baka"];

  @override
  void initState() {
    super.initState();

    _selectedVersion = widget.selectedVersion;
  }

  void sidebarButtonClicked(String button) {
    if (button == "play") {
      widget.navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => PlayGame(selectedVersion: _selectedVersion, navigatorKey: widget.navigatorKey)));
    }
  }

  void addProfileClicked() {
    print("add profile");
  }

  void selectProfileClicked(String profile) {
    _selectedProfile = profile;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainInstance(selectedProfile: _selectedProfile, selectedVersion: _selectedVersion, navigatorKey: widget.navigatorKey)),
    );
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
                            Padding(padding: const EdgeInsets.only(left: 20), child: Text(profiles[index], style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700))),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedProfile = profiles[index];
                                });
                              },
                              child: GestureDetector(
                                  onTap: () => {selectProfileClicked(profiles[index])},
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
                    }, itemCount: profiles.length),
                  ))]),
                Padding(padding: const EdgeInsets.only(left: 40, right: 40, top: 500), child: GestureDetector(
                  onTap: () => {addProfileClicked()},
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                        width: 807,
                        height: 79,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: (profiles.length >= 5) ? const Color(0xFF007BFF) : Colors.transparent,
                          border: Border.all(color: (profiles.length >= 5) ? const Color(0xff000000) : const Color(0xFF007BFF), width: 5),
                        ),
                        child: const Center(
                          child: Text("+ ADD PROFILE", style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 24, fontWeight: FontWeight.w900)),
                        )
                    ),
                  ),
                ),)
              ])))
    ])));
  }
}
