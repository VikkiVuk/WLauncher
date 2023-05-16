import 'package:flutter/material.dart';
import 'package:wlauncher/pages/main/instances/select_profile.dart';
import 'package:wlauncher/pages/main/play_game.dart';
import 'package:wlauncher/pages/main/sidebar.dart';

class MainInstance extends StatefulWidget {
  final selectedVersion;
  final selectedProfile;

  const MainInstance({Key? key, this.selectedProfile, this.selectedVersion}) : super(key: key);

  @override
  _MainInstanceState createState() => _MainInstanceState();
}

class _MainInstanceState extends State<MainInstance> {
  String _selectedVersion = "1.18.2";
  String _selectedProfile = "Vanilla";
  List<String> mods = ["Optifine", "Pure Chaos", "Cma", "Bruh", "Kruh", "Cc", "ccccccc"];

  void sidebarButtonClicked(String button) {
    if (button == "play") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlayGame(selectedProfile: _selectedProfile, selectedVersion: _selectedVersion)),
      );
    }
  }

  void addModsClicked(String version) {
    _selectedVersion = version;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectProfile(selectedVersion: _selectedVersion)),
    );
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
                    SizedBox(
                      width: 500, // Set your desired fixed container width
                      height: 300, // Set your desired fixed container height
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Expanded(child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5, // Maximum 5 items on the horizontal side
                              ),
                              itemCount: mods.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  child: Center(
                                    child: Text(mods[index]),
                                  ),
                                );
                              },
                            ))
                          ],
                        ),
                      ),
                    )]),
            )
          ],
        ),
      ),
    );
  }

}