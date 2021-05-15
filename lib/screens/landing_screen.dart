import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_application/state/application_state.dart';
import 'settings_screen.dart';
import 'users_screens.dart';
import 'profile_screen.dart';
import 'package:training_application/state/inherited_application_state.dart';

const kTextColor = Color(0xFF3C3A36);
const kBottomAppBarColor = Color(0xFFBEBAB3);

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (int page) {
          InheritedAplicationState.of(context).pageNotifier.value = page;
        },
        controller: InheritedAplicationState.of(context).controller,
        children: [
          UsersScreen(),
          ProfileScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: InheritedAplicationState.of(context).pageNotifier,
        builder: (context, value, child) {
          return CustomNavigationPanel(
              controller: InheritedAplicationState.of(context).controller);
        },
      ),
    );
  }
}

class CustomNavigationPanel extends StatefulWidget {
  final PageController controller;

  const CustomNavigationPanel({Key key, this.controller}) : super(key: key);

  @override
  _CustomNavigationPanelState createState() => _CustomNavigationPanelState();
}

class _CustomNavigationPanelState extends State<CustomNavigationPanel> {
  void onItemTap(int index) {
    print(index);
    InheritedAplicationState.of(context).previousPageIndex =
        InheritedAplicationState.of(context).pageNotifier.value;
    InheritedAplicationState.of(context).pageNotifier.value = index;
    InheritedAplicationState.of(context).goToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: kBottomAppBarColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
        child: BottomNavigationBar(
          onTap: onItemTap,
          currentIndex: InheritedAplicationState.of(context).pageNotifier.value,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('images/Icon.svg'),
              title: Text(
                'Users',
                style: TextStyle(),
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('images/Profile Icon.svg'),
              title: Text('Profile'),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('images/Frame 4.svg'),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
