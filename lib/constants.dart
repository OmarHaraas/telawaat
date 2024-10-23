import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/azqaar_page.dart';
import '/pdf_viewer_page.dart';
import 'package:url_launcher/url_launcher.dart';

//  "https://t.me/telebyluck";
var myAppBar = AppBar(
  iconTheme: const IconThemeData(color: Colors.white),
  backgroundColor: Colors.grey[900],
  // actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.back_hand))],
);

var myDefaultBackgroundColor = Colors.grey[300];

var myDrawer = Drawer(
  backgroundColor: Colors.grey[900],
  shape: Border.all(width: 0), //was more than one in last flutter update.
  child: Builder(builder: (context) {
    return ListView(
      children: [
        Column(
          children: [
            DrawerHeader(
                child: Center(
              child: CircleAvatar(
                radius: 60,
                child: Image.asset("assets/icons/icon.png"),
              ),
            )),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: const Text(
                "الصفحة الرئيسية",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.book_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "كتاب الفقه الميسر",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const PdfPage();
                  },
                ));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.personal_injury_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "الأذكار",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const AzqaarPage();
                  },
                ));
              },
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      title: const Text(
                        'ملاحظات',
                        textAlign: TextAlign.center,
                      ),
                      content: AnimatedOpacity(
                        opacity: 1.0,
                        duration: const Duration(seconds: 1),
                        child: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              // Your rows here...
                              const Padding(
                                padding: EdgeInsets.all(7.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.cached_rounded),
                                    //Text("  For auto repeat audio."),
                                    Text("  " "لتكرار الملف الصوتى"),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(7.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.shuffle_rounded),
                                    Text("  For auto play next."),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.settings_suggest_outlined),
                                    const Text("  For suggestions, "),
                                    InkWell(
                                        onTap: () {
                                          launchUrl(
                                            Uri.parse('https://t.me/Om4Ro'),
                                          );
                                        },
                                        child: const Text(
                                          "tap here",
                                          style: TextStyle(
                                            color: Colors.red,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(7.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.nights_stay),
                                    Text(
                                      "ولا تنس ذكر الله",
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              leading: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: const Text(
                "الاعدادات",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse("https://t.me/telebyluck"));
              },
              leading: const Icon(
                Icons.telegram_rounded,
                color: Colors.white,
              ),
              title: const Text(
                "انضم إلينا",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Colors.white),
              title: const Text(
                'مشاركة التطبيق',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onTap: () {
                // Share.share(
                //     "Download the app from our telegram channel @telebyluck");
              },
            ),
            ListTile(
              onTap: () {
                SystemNavigator.pop();
              },
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              title: const Text(
                "الخروج",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }),
);
