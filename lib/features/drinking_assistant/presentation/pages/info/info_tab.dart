import 'package:drinking_assistant/core/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Application Info',
              style: GoogleFonts.muli(fontSize: 16, color: black),
            ),
          ),
//          ListTile(
//            leading: Icon(Icons.star_border),
//            title: Text(
//              'Give Rating',
//              style: GoogleFonts.muli(fontSize: 16, color: grey),
//            ),
//            onTap: () {
//              showAboutDialog(context: context);
//            },
//          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(
              'About Apps',
              style: GoogleFonts.muli(fontSize: 16, color: grey),
            ),
            onTap: () {
              showAboutDialog(context: context);
            },
          ),
        ],
      ),
    );
  }
}
