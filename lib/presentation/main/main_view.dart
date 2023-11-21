import 'package:ecommvvm/presentation/main/home/home_page.dart';
import 'package:ecommvvm/presentation/main/notification_page.dart';
import 'package:ecommvvm/presentation/main/search_page.dart';
import 'package:ecommvvm/presentation/main/settings_page.dart';
import 'package:ecommvvm/presentation/ressources/color_manager.dart';
import 'package:ecommvvm/presentation/ressources/string_manager.dart';
import 'package:ecommvvm/presentation/values_manager.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    NotificationPage(),
    SettingsPage()
  ];
  List<String> titles = const [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notification,
    AppStrings.settings
  ];
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_currentIndex],
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.black, spreadRadius: AppSize.s1_5)
        ]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: AppStrings.home),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: AppStrings.search),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppStrings.notification),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppStrings.email)
          ],
        ),
      ),
    );
  }

  onTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
