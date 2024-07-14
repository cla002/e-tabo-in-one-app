import 'package:buyers/screens_buyer/all_product_screen.dart';
import 'package:buyers/screens_buyer/favorites_screen.dart';
import 'package:buyers/screens_buyer/home_screen_buyer.dart';
import 'package:buyers/screens_buyer/orders_screen_buyer.dart';
import 'package:buyers/screens_buyer/profile_screen_buyer.dart';
import 'package:buyers/widgets_buyer/cart/cart_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainScreenBuyer extends StatefulWidget {
  const MainScreenBuyer({Key? key}) : super(key: key);

  static const String id = 'main-screen';

  @override
  _MainScreenBuyerState createState() => _MainScreenBuyerState();
}

class _MainScreenBuyerState extends State<MainScreenBuyer> {
  late PersistentTabController controller;

  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens() {
      return [
        const HomeScreen(),
        const OrderScreen(),
        const AllProductListScreen(),
        const FavoriteScreen(),
        const ProfileScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGreen,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.shopping_basket),
          title: ("Orders"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGreen,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.circle),
          title: ("Products"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGreen,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.favorite),
          title: ("Favorites"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGreen,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.account_circle_rounded),
          title: ("Profile"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGreen,
        ),
      ];
    }

    return Scaffold(
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(bottom: 50.0),
        child: CartNotification(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PersistentTabView(
        context,
        controller: controller,
        screens: buildScreens(),
        items: navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          border: Border.all(color: Colors.green),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1,
      ),
    );
  }
}
