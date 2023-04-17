import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List<IconData> icons;
  final Function(int) onTabSelected;

  CustomBottomNavigationBar({required this.icons, required this.onTabSelected});

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          widget.icons.length,
              (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.onTabSelected(index);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icons[index],
                  color: _selectedIndex == index ? Colors.blue : Colors.grey,
                ),
                SizedBox(height: 4.0),
                Text(
                  'Tab $index',
                  style: TextStyle(
                    color: _selectedIndex == index ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
