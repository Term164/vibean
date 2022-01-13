import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  _launchURL(_url) async {
    await launch(_url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(backgroundColor: Colors.blue[900], elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset('assets/logo.png'),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text(
                'All in one app for song managment',
                style: TextStyle(
                    color: Color(0xFFF7941D),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontFamily: 'gluck'),
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Divider(
                    color: Color(0xFFF7941D), height: 50, thickness: 6)),
            const Padding(
              padding: EdgeInsets.fromLTRB(45, 0, 45, 20),
              child: Text(
                "VIBEAN is an app created in 2022 by two Computer Science students from Slovenia. We're a non-profit collective, so you shouldn't see any ads on our app. If you do, beware! \n\n We're are not accepting any donations, but if you are still willing to donate here are some organisation that would kindly appreciate it:",
                style: TextStyle(
                  color: Color(0xFFF7941D),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  primary: const Color(0xFFF7941D),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  _launchURL('https://www.esiras.si/');
                },
                icon: const Icon(Icons.emoji_people),
                label: const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "Rdeči križ slovenije",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    primary: const Color(0xFFF7941D),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    _launchURL('https://www.karitasfoundation.org/');
                  },
                  icon: const Icon(Icons.emoji_people),
                  label: const Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text(
                      "Karitas",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  primary: const Color(0xFFF7941D),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  _launchURL('https://ebm.si/glavna/web/');
                },
                icon: const Icon(Icons.emoji_people),
                label: const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "Ekologi brez meja",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                "Contact us",
                style: TextStyle(
                    color: Color(0xFFF7941D),
                    fontFamily: 'gluck',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 110,
                    height: 30,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        primary: const Color(0xFFF7941D),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        _launchURL('https://github.com/Term164/vibean/');
                      },
                      icon: const Icon(Icons.web),
                      label: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          "Website",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: SizedBox(
                      width: 100,
                      height: 30,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          primary: const Color(0xFFF7941D),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: "vibeanSupport@vibean.com"));
                          final snackBar = SnackBar(
                              content: const Text('Email copied to clipboard'),
                              action: SnackBarAction(
                                  label: 'Hide', onPressed: () {}));

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        icon: const Icon(Icons.email_outlined),
                        label: const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            "Email",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        primary: const Color(0xFFF7941D),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        _launchURL('https://github.com/Term164');
                      },
                      icon: const Icon(Icons.web),
                      label: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          "Github",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
