
import 'package:appafhopades/SignUp/sign_up_page.dart';
import 'package:appafhopades/constants/constants.dart';
import 'package:appafhopades/screens/dashboard/sliding_cards.dart';
import 'package:appafhopades/screens/dashboard/tabs.dart';
import 'package:appafhopades/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import 'exhibition_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 2),
                Header(),
                SizedBox(height: 15),
                Tabs(),
                SizedBox(height: 2),
                SlidingCardsView(),

              ],
            ),

          ),

          // ExhibitionBottomSheet(),
          // use this or ScrollableExhibitionSheet
          SheetHeader(fontSize: 10)
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      new Image.asset(
        'assets/logo.jpg',
        width: 180.0,
        height: 110.0,
      ),
    ]);
  }
}
