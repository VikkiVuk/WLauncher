import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Sidebar extends StatefulWidget {
  final Function onSidebarButtonPressed;
  final int selected;

  const Sidebar({Key? key, required this.onSidebarButtonPressed, required this.selected}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  late Function onSidebarButtonPressed;
  var _selected = 0;
  var _hovering = -1;

  @override
  void initState() {
    super.initState();

    onSidebarButtonPressed = widget.onSidebarButtonPressed;
    _selected = widget.selected;
  }

  void onSidebarButtonPressedInternal(int button) {
    if (button == 0) {
      onSidebarButtonPressed("play");
    } else if (button == 1) {
      onSidebarButtonPressed("instances");
    } else if (button == 2) {
      onSidebarButtonPressed("modpacks");
    } else if (button == 3) {
      onSidebarButtonPressed("resource_packs");
    } else if (button == 4) {
      launchUrlString("https://discord.gg/vtJr7RBfZd");
      return;
    } else if (button == 5) {
      launchUrlString("https://github.com/VikkiVuk/WLauncher");
      return;
    } else if (button == 6) {
      launchUrlString("https://vikkivuk.com/donate");
      return;
    } else if (button == 7) {
      onSidebarButtonPressed("updates");
    } else if (button == 8) {
      onSidebarButtonPressed("settings");
    }

    setState(() {
      _selected = button;
    });
  }

  void onSidebarButtonHover(int button) {
    setState(() {
      _hovering = button;
    });
  }

  void onSidebarButtonHoverExit(int button) {
    setState(() {
      _hovering = -1;
    });
  }

  Color getButtonColor(int button) {
    if (_selected == button) {
      return Colors.white;
    } else if (_hovering == button) {
      return const Color(0xFF4C4C4C);
    } else {
      return const Color(0xFF8A8A8A);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          width: 228,
          height: 655,
          color: const Color(0xFF0c0c0c),
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
              child: Text('VIKKIVUK', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30), child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("PLAY", textAlign: TextAlign.left, style: TextStyle(color: Color(0xFF4C4C4C), fontSize: 16, fontWeight: FontWeight.w900)),
                const SizedBox(height: 5),
                SidebarButton(text: "Play Game", image: "assets/icons/gamepad.svg", onSidebarButtonPressed: onSidebarButtonPressedInternal, onSidebarButtonHover: onSidebarButtonHover, onSidebarButtonHoverExit: onSidebarButtonHoverExit, getButtonColor: getButtonColor, button: 0),
                SidebarButton(text: "Profiles", image: "assets/icons/wrench.svg", onSidebarButtonPressed: onSidebarButtonPressedInternal, onSidebarButtonHover: onSidebarButtonHover, onSidebarButtonHoverExit: onSidebarButtonHoverExit, getButtonColor: getButtonColor, button: 1),
                SidebarButton(text: "Modpacks", image: "assets/icons/wrench.svg", onSidebarButtonPressed: onSidebarButtonPressedInternal, onSidebarButtonHover: onSidebarButtonHover, onSidebarButtonHoverExit: onSidebarButtonHoverExit, getButtonColor: getButtonColor, button: 2),
                SidebarButton(text: "Resource Packs", image: "assets/icons/wrench.svg", onSidebarButtonPressed: onSidebarButtonPressedInternal, onSidebarButtonHover: onSidebarButtonHover, onSidebarButtonHoverExit: onSidebarButtonHoverExit, getButtonColor: getButtonColor, button: 3),
                const SizedBox(height: 20),
                const Text("EXPLORE", textAlign: TextAlign.left, style: TextStyle(color: Color(0xFF4C4C4C), fontSize: 16, fontWeight: FontWeight.w900)),
                const SizedBox(height: 5),
                SidebarButton(text: "Community", image: "assets/icons/group.svg", onSidebarButtonPressed: onSidebarButtonPressedInternal, onSidebarButtonHover: onSidebarButtonHover, onSidebarButtonHoverExit: onSidebarButtonHoverExit, getButtonColor: getButtonColor, button: 4),
                SidebarButton(text: "Source Code", image: "assets/icons/github.svg", onSidebarButtonPressed: onSidebarButtonPressedInternal, onSidebarButtonHover: onSidebarButtonHover, onSidebarButtonHoverExit: onSidebarButtonHoverExit, getButtonColor: getButtonColor, button: 5),
                SidebarButton(text: "Donate", image: "assets/icons/heart.svg", onSidebarButtonPressed: onSidebarButtonPressedInternal, onSidebarButtonHover: onSidebarButtonHover, onSidebarButtonHoverExit: onSidebarButtonHoverExit, getButtonColor: getButtonColor, button: 6),
                const SizedBox(height: 110),
                SidebarButton(text: "Updates", image: "assets/icons/download.svg", onSidebarButtonPressed: onSidebarButtonPressedInternal, onSidebarButtonHover: onSidebarButtonHover, onSidebarButtonHoverExit: onSidebarButtonHoverExit, getButtonColor: getButtonColor, button: 7),
                SidebarButton(text: "Settings", image: "assets/icons/settings.svg", onSidebarButtonPressed: onSidebarButtonPressedInternal, onSidebarButtonHover: onSidebarButtonHover, onSidebarButtonHoverExit: onSidebarButtonHoverExit, getButtonColor: getButtonColor, button: 8),
              ],
            ))
          ]),
        )
    );
  }
}

class SidebarButton extends StatelessWidget {
  final Function onSidebarButtonPressed;
  final Function onSidebarButtonHover;
  final Function onSidebarButtonHoverExit;
  final Function getButtonColor;
  final int button;
  final String image;
  final String text;

  const SidebarButton({Key? key, required this.text, required this.image, required this.onSidebarButtonPressed, required this.onSidebarButtonHover, required this.onSidebarButtonHoverExit, required this.getButtonColor, required this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: GestureDetector(
          onTap: () => onSidebarButtonPressed(button),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => onSidebarButtonHover(button),
            onExit: (_) => onSidebarButtonHoverExit(button),
            child: Row(
              children: [
                SvgPicture.asset(image, width: 23, height: 23, color: getButtonColor(button)),
                Padding(padding: const EdgeInsets.only(left: 16, right: 16), child: Text(text, style: TextStyle(color: getButtonColor(button), fontSize: 16, fontWeight: FontWeight.normal)))
              ],
            ),
          )
        )
    );
  }
}