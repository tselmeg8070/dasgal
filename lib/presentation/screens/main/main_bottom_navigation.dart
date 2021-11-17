import 'package:dasgal/core/constants/colors.dart';
import 'package:dasgal/core/constants/styles.dart';
import 'package:flutter/material.dart';



class NavItem {
  IconData icon;
  String title;

  NavItem({required this.icon, required this.title});
}

class MainBottomNavigation extends StatefulWidget {
  MainBottomNavigation({
    required this.items,
    this.height: 65.0,
    this.iconSize: 24.0,
    required this.backgroundColor,
    required this.selectedTabIndex,
    this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4 || this.selectedTabIndex != null);
  }

  final List<NavItem> items;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final onTabSelected;
  final int selectedTabIndex;

  @override
  State<StatefulWidget> createState() => MainBottomNavigationState();
}

class MainBottomNavigationState extends State<MainBottomNavigation> {
  _updateIndex(int index) {
    widget.onTabSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return Container(
      // decoration: BoxDecoration(
      //     color: widget.backgroundColor,
      //     boxShadow: [
      //       BoxShadow(color: INACTIVE_GRAY_COLOR.withOpacity(0.6), blurRadius: 20,)
      //     ]
      // ),

      child: BottomAppBar(
        notchMargin: 8,
        elevation: 0.2,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items,
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required NavItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            splashColor: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.icon, size: 28, color: widget.selectedTabIndex == index ? AppColors.textColorHigh : AppColors.textColor,),
                const SizedBox(
                  height: 2,
                ),
                Text(item.title,
                    style: widget.selectedTabIndex == index
                        ? AppStyle.textCaption.copyWith(color: AppColors.textColorHigh)
                        : AppStyle.textCaption.copyWith(color: Colors.transparent))
              ],
            ),
          ),
        ),
      ),
    );
  }
}