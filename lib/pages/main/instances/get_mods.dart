import 'package:flutter/material.dart';
import 'package:wlauncher/pages/main/instances/main_instance.dart';
import 'package:wlauncher/pages/main/play_game.dart';
import 'package:wlauncher/pages/main/sidebar.dart';

class GetMods extends StatefulWidget {
  final String selectedVersion;
  final String selectedProfile;
  final GlobalKey<NavigatorState> navigatorKey;

  const GetMods({Key? key, required this.selectedVersion, required this.selectedProfile, required this.navigatorKey}) : super(key: key);

  @override
  _GetModsState createState() => _GetModsState();
}

class Mod {
  final String image;
  final String name;
  final String version;
  final String description;
  final String downloadUrl;
  final String author;

  Mod(this.image, this.name, this.version, this.description, this.downloadUrl, this.author);
}

class _GetModsState extends State<GetMods> {
  String _selectedProfile = "Vanilla";
  String _selectedVersion = "1.18.2";
  List<Mod> mods = [
    Mod("https://play.teleporthq.io/static/svg/default-img.svg", "Optifine", "1.18.2", "Optifine is a mod that makes Minecraft run faster and look better.", "https://optifine.net/download", "sp614x"),
    Mod("https://play.teleporthq.io/static/svg/default-img.svg", "Optifine", "1.18.2", "Optifine is a mod that makes Minecraft run faster and look better.", "https://optifine.net/download", "sp614x"),
    Mod("https://play.teleporthq.io/static/svg/default-img.svg", "Optifine", "1.18.2", "Optifine is a mod that makes Minecraft run faster and look better.", "https://optifine.net/download", "sp614x"),
    Mod("https://play.teleporthq.io/static/svg/default-img.svg", "Optifine", "1.18.2", "Optifine is a mod that makes Minecraft run faster and look better.", "https://optifine.net/download", "sp614x"),
    Mod("https://play.teleporthq.io/static/svg/default-img.svg", "Optifine", "1.18.2", "Optifine is a mod that makes Minecraft run faster and look better.", "https://optifine.net/download", "sp614x"),
    Mod("https://play.teleporthq.io/static/svg/default-img.svg", "Optifine", "1.18.2", "Optifine is a mod that makes Minecraft run faster and look better.", "https://optifine.net/download", "sp614x"),
  ];

  @override
  void initState() {
    super.initState();

    _selectedVersion = widget.selectedVersion;
    _selectedProfile = widget.selectedProfile;
  }

  void sidebarButtonClicked(String button) {
    if (button == "play") {
      widget.navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => PlayGame(selectedVersion: _selectedVersion, navigatorKey: widget.navigatorKey)));
    }
  }

  void search(String query) {
    print("search");
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
              child: Column(
                children: [
                  SizedBox(
                      width: 879,
                      height: 500,
                      child: ListView.builder(itemCount: mods.length, itemBuilder: (context, index) {
                        return Container(
                          height: 135,
                          width: 879,
                          decoration: const BoxDecoration(
                            color: Color(0xFF060606),
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          ),
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 120,
                                  height: 135,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      // image: Image.network(mods[index].image).image,
                                      image: Image.asset("assets/placeholder.png").image,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), bottomLeft: Radius.circular(14)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(mods[index].name, style: const TextStyle(color: Colors.white, fontSize: 32)),
                                        Text(mods[index].description, style: const TextStyle(color: Color(0xFF595959), fontSize: 16)),
                                      ],
                                  ),
                                ),
                                const Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(mods[index].author, style: const TextStyle(color: Color(0xFF595959), fontSize: 16, overflow: TextOverflow.ellipsis)),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        print("download");
                                      },
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Container(
                                          width: 80,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF000000),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Center(child: Text("install", style: TextStyle(color: Colors.white, fontSize: 16))),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      })
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}