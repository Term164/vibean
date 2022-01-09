import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  final Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFF7941D),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Jani Bangiev"),
            accountEmail: Text("jani.bangiev@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/Yuki.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
              backgroundColor: Colors.white,
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/background.jpg'),
                )),
          ),
          ListTile(
            leading: Icon(Icons.home, size: 40, color: textColor),
            title: Text("Home", style: TextStyle(color: textColor)),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.library_music, size: 40, color: textColor),
            title: Text("Music library", style: TextStyle(color: textColor)),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.download_rounded, size: 40, color: textColor),
            title: Text("Downloads", style: TextStyle(color: textColor)),
            onTap: () => null,
          ),
          const Divider(height: 20, thickness: 3),
          ListTile(
            leading: Icon(Icons.info_outline, size: 40, color: textColor),
            title: Text("About us", style: TextStyle(color: textColor)),
            onTap: () => null,
          ),
          ListTile(
            leading:
                Icon(Icons.warning_amber_rounded, size: 40, color: textColor),
            title: Text("Report a bug", style: TextStyle(color: textColor)),
            onTap: () => null,
          ),
          const Divider(height: 20, thickness: 3),
          ListTile(
            leading: Icon(Icons.exit_to_app, size: 40, color: textColor),
            title: Text("Sign out", style: TextStyle(color: textColor)),
            onTap: () => null,
          )
        ],
      ),
    );
  }
}
