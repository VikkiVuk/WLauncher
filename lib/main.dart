import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:wlauncher/pages/account_picker.dart';
import 'package:wlauncher/interfaces/profiles.dart';
import 'package:wlauncher/pages/main/play_game.dart';

import 'pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await checkIfProfilesFileExists();

  var profilesCount = await getProfilesCount();
  if (profilesCount == 0) {
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
  } else {
    WindowOptions windowOptions = const WindowOptions(
      size: Size(884, 503),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      minimumSize: Size(884, 503),
      maximumSize: Size(884, 503),
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
    runApp(AccountPickerPage());
  }
}