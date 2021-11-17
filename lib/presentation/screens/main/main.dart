import 'package:dasgal/presentation/screens/main/analytic/analytic.dart';
import 'package:dasgal/presentation/screens/main/main_bottom_navigation.dart';
import 'package:dasgal/presentation/screens/main/plan/plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedTabIndex = 0;


  void _onItemTapped(int index) {
    setState(() => {_selectedTabIndex = index});
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      AnalyticScreen(),
      PlanScreen(),
      const Center(child: Text("More")),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250), child: _widgetOptions.elementAt(_selectedTabIndex)),
      ),
      bottomNavigationBar: MainBottomNavigation(
        selectedTabIndex: _selectedTabIndex,
        onTabSelected: _onItemTapped,
        backgroundColor: Colors.transparent,
        items: [
          NavItem(
              icon: FeatherIcons.barChart2,
              title: "Хяналт"),
          NavItem(
              icon: FeatherIcons.clipboard,
              title: "Хөтөлбөр"),
          NavItem(
              icon: FeatherIcons.moreHorizontal,
              title: "Цэс"),
        ],
      ),
    );
  }
}
