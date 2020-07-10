import 'package:flutter/material.dart';
import 'AccountUser.dart';
import 'AppointmentUser.dart';
import 'DashboardUser.dart';

int _selectedIndex = 0;

class BottomNavigationUser extends StatefulWidget {
  @override
  _BottomNavigationUserState createState() => _BottomNavigationUserState();
}

class _BottomNavigationUserState extends State<BottomNavigationUser> {
  void _onItemTapped(int index) {
    setState(() {
      print(index);
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushNamed(context, DashboardUser.id);
      }
      if (index == 1) {
        Navigator.pushNamed(context, AppointmentUser.id);
      }
      if (index == 2) {
        Navigator.pushNamed(context, AccountUser.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('search'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule),
          title: Text('Appointments'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text('Account'),
        ),
      ],
      currentIndex: _selectedIndex,
      // selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
