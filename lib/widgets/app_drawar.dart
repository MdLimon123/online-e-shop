import 'package:e_shop_online/adminscreens/addproduct.dart';
import 'package:e_shop_online/screens/main_screen.dart';
import 'package:e_shop_online/utils/custom_color.dart';
import 'package:e_shop_online/utils/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [drawerHeader(),
             drawerItems('home page', FontAwesomeIcons.home, () { 
               Navigator.pushReplacementNamed(context, MainPage.id);
             }),
            drawerItems('admin page', FontAwesomeIcons.user, () {
              Navigator.pushReplacementNamed(context, AddProductPage.id);
            }),
          ],
        ),
      ),
    );
  }

  ListTile drawerItems(String title, IconData icon, GestureTapCallback onTap) {
    return ListTile(
            leading:  Icon(icon),
            title:  Text(title),
            onTap: onTap
          );
  }

  DrawerHeader drawerHeader() {
    return DrawerHeader(
      padding: const EdgeInsets.all(0.0),
      child: Container(
          color: primaryColor,
          child: Center(
            child: Text(
              'WELCOME ONLINE SHOP',
              textAlign: TextAlign.center,
              style: heading1,
            ),
          )),
    );
  }
}
