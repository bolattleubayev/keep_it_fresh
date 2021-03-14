import 'package:flutter/material.dart';

import '../widgets/app_bar_title.dart';

import '../screens/add_item_screen.dart';
import '../screens/discover_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/profile_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': FeedScreen(),
        'title': 'Лента',
      },
      {
        'page': DiscoverScreen(),
        'title': 'Поиск профиля',
      },
      {
        'page': ProfileScreen(),
        'title': 'Профиль',
      },
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            AppBarTitle(title: _pages[_selectedPageIndex]['title'] as String),
        backgroundColor: const Color.fromRGBO(174, 142, 255, 1),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor, //change your color here
        ),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0.0,
        onTap: _selectPage,
        backgroundColor: Colors.white,
        unselectedItemColor:
            const Color.fromRGBO(174, 142, 255, 1).withOpacity(0.6),
        selectedItemColor: const Color.fromRGBO(174, 142, 255, 1),
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.border_all,
              size: 40.0,
            ),
            title: Text('Лента'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.search,
              size: 40.0,
            ),
            title: Text('Поиск профиля'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.person,
              size: 40.0,
            ),
            title: Text('Профиль'),
          ),
        ],
      ),
    );
  }
}
