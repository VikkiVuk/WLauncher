import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wlauncher/pages/main/instances/select_version.dart';
import 'package:wlauncher/pages/main/play_game.dart';
import 'package:wlauncher/pages/main/sidebar.dart';

import 'get_resourcepacks.dart';

class GetModpacks extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const GetModpacks({Key? key, required this.navigatorKey}) : super(key: key);

  @override
  _GetModpacksState createState() => _GetModpacksState();
}

class Modpack {
  final String image;
  final String name;
  final String version;
  final String description;
  final String downloadUrl;
  final String author;

  Modpack(this.image, this.name, this.version, this.description, this.downloadUrl, this.author);
}

class _GetModpacksState extends State<GetModpacks> {
  String _searchQuery = "";
  List<Modpack> modpacks = [
    Modpack("https://play.teleporthq.io/static/svg/default-img.svg", "Optifine", "1.18.2", "Optifine is a mod that makes Minecraft run faster and look better.", "https://optifine.net/download", "sp614x"),
    Modpack("https://play.teleporthq.io/static/svg/default-img.svg", "Optifine", "1.18.2", "Optifine is a mod that makes Minecraft run faster and look better.", "https://optifine.net/download", "sp614x"),
    Modpack("https://play.teleporthq.io/static/svg/default-img.svg", "Optifine", "1.18.2", "Optifine is a mod that makes Minecraft run faster and look better.", "https://optifine.net/download", "sp614x"),
    Modpack("https://play.teleporthq.io/static/svg/default-img.svg", "Optifine", "1.18.2", "Optifine is a mod that makes Minecraft run faster and look better.", "https://optifine.net/download", "sp614x"),
    Modpack("https://play.teleporthq.io/static/svg/default-img.svg", "Optifine", "1.18.2", "Optifine is a mod that makes Minecraft run faster and look better.", "https://optifine.net/download", "sp614x"),
    Modpack("https://play.teleporthq.io/static/svg/default-img.svg", "Optifine", "1.18.2", "Optifine is a mod that makes Minecraft run faster and look better.", "https://optifine.net/download", "sp614x"),
  ];

  @override
  void initState() {
    super.initState();
  }

  void sidebarButtonClicked(String button) {
    if (button == "play") {
      widget.navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => PlayGame(navigatorKey: widget.navigatorKey)));
    } else if (button == "instances") {
      widget.navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => SelectVersion(navigatorKey: widget.navigatorKey)));
    } else if (button == "resourcepacks") {
      widget.navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => GetResourcepacks(navigatorKey: widget.navigatorKey)));
    }
  }

  void search(String query) {
    print("search");
  }

  void uploadMod() {
    print("upload");
  }

  void exportProfile() {
    print("export");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            Sidebar(onSidebarButtonPressed: sidebarButtonClicked, selected: 2),
            Container(
              color: const Color(0xFF000000),
              child: Stack(
                children: [
                  SizedBox(
                      width: 879,
                      height: 460,
                      child: ListView.builder(itemCount: modpacks.length, itemBuilder: (context, index) {
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
                                      Text(modpacks[index].name, style: const TextStyle(color: Colors.white, fontSize: 32)),
                                      Text(modpacks[index].description, style: const TextStyle(color: Color(0xFF595959), fontSize: 16)),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(modpacks[index].author, style: const TextStyle(color: Color(0xFF595959), fontSize: 16, overflow: TextOverflow.ellipsis)),
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
                  ),
                  Center(child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF0c0c0c),
                    ),
                    width: 840,
                    height: 134,
                    margin: const EdgeInsets.only(top: 460, left: 20),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(padding: EdgeInsets.only(top: 20), child: Text("SEARCH MODPACKS", style: TextStyle(color: Color(0xFF4c4c4c), fontSize: 16, fontWeight: FontWeight.w900)),),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: 700,
                                    height: 40,
                                    child: TextField(
                                      onChanged: (text) => {_searchQuery = text},
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xFF1c1c1c),
                                        hintText: "Search for modpacks",
                                        hintStyle: const TextStyle(color: Color(0xFF4c4c4c), fontSize: 16),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                                        ),
                                        contentPadding: const EdgeInsets.only(left: 10, right: 10),
                                      ),
                                      style: const TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: GestureDetector(
                                    onTap: () => {search(_searchQuery)},
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF1c1c1c),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: const Center(child: Icon(Icons.search, color: Colors.white)),
                                      ),
                                    ),
                                  ),
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
        ),
      ),
    );
  }
}