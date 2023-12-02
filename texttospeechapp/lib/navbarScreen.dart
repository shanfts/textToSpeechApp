import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:texttospeechapp/views/history/historyScreen.dart';
import 'package:texttospeechapp/views/home/homeScreem.dart';
import 'package:texttospeechapp/views/settings/settingsScreen.dart';

class navBarScreenWidget extends StatelessWidget {
  const navBarScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 1);
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.history),
          title: ("History"),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.home_outlined,
            color: Color.fromARGB(255, 40, 58, 120),
            size: 35,
          ),
          title: ("Home"),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.settings),
          title: ("Settings"),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    List<Widget> _buildScreens() {
      return [
        const historyScreenWidget(),
        const homeScreenWidget(),
        const settingScreenWidget(),
      ];
    }

    return Scaffold(
      body: PersistentTabView(
        context,
        controller: controller,
        navBarHeight: 70,
        screens: _buildScreens(),
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style15,
        confineInSafeArea: true,
        backgroundColor: const Color.fromARGB(255, 40, 58, 120),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      extendBody: true,
    );
  }
}
