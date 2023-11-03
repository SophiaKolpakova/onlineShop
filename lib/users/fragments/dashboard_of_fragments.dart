import 'package:flutter/material.dart.';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shop/users/fragments/order_fragment_screen.dart';
import 'package:shop/users/fragments/profile_fragment_screen.dart';
import 'favorites_fragment_screen.dart';
import 'home_fragment_screen.dart';

class DashboardOfFragments extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final List<Widget> fragmentScreen = [
      HomeFragmentScreen(),
      FavoritesFragmentScreen(),
      OrderFragmentScreen(),
      ProfileFragmentScreen(),
    ];

    List _navigationButtonsProperties = [
      {
        "active_icon": Icons.home,
        "non_active_icon": Icons.home_outlined,
        "label": "Home"
      },
      {
        "active_icon": Icons.favorite,
        "non_active_icon": Icons.favorite_border,
        "label": "Favorites"
      },
      {
        "active_icon": FontAwesomeIcons.boxOpen,
        "non_active_icon": FontAwesomeIcons.box,
        "label": "Order"
      },
      {
        "active_icon": Icons.person,
        "non_active_icon": Icons.person_outline,
        "label": "Profile"
      },
    ];

    RxInt _indexNumber = 0.obs;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(
              () => fragmentScreen[_indexNumber.value],
        ),
      ),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: _indexNumber.value,
          onTap: (value) {
            _indexNumber.value = value;
          },
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white24,
          items: List.generate(4, (index) {
            var navBtnProperties = _navigationButtonsProperties[index];
            return BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(navBtnProperties["non_active_icon"]),
              activeIcon: Icon(navBtnProperties["active_icon"]),
              label: navBtnProperties["label"],
            );
          }),
        ),
      ),
    );
  }
}
