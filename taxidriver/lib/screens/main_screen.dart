// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:taxidriver/tab_pages/earnings.dart';
import 'package:taxidriver/tab_pages/rating.dart';
import '../tab_pages/home.dart';
import '../tab_pages/profile.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  static const routeName = '/mainscreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      _tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          HomeTabPage(),
          EarningTabPage(),
          RatingTabPage(),
          ProfileTabPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: 'Earnings',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Rating',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.white),
        ],
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.grey,
        type: BottomNavigationBarType.shifting,
        selectedLabelStyle: TextStyle(fontSize: 12),
        showSelectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
