import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:wlauncher/pages/login.dart';

class AccountPickerPage extends StatelessWidget {
  const AccountPickerPage({Key? key}) : super(key: key);

  void setWindowSize(Size size) async {
    WindowManager.instance.setSize(size, animate: true);
    WindowManager.instance.center();
    WindowManager.instance.setMinimumSize(size);
    WindowManager.instance.setMaximumSize(size);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFF0c0c0c),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                'Who\'s cooking?',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                padding: const EdgeInsets.symmetric(horizontal: 180, vertical: 30),
                children: const [
                    AccountCard(image: AssetImage('assets/placeholder.png'), name: 'John Doe'),
                    AccountCard(image: AssetImage('assets/placeholder.png'), name: 'John Doe'),
                    AccountCard(image: AssetImage('assets/placeholder.png'), name: 'John Doe'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const Login()),
                );
              },
              child: const Padding(padding: EdgeInsets.only(bottom: 100),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/add.png'),
                  radius: 40,
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  final ImageProvider image;
  final String name;

  const AccountCard({Key? key, required this.image, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: switch account
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: image,
            radius: 50,
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFFB3B3B3),
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}