import 'package:business_startup/user/Chat.dart';
import 'package:flutter/material.dart';
import 'Account.dart';
import 'AppointmentsBusiness.dart';
import 'DashboardBusiness.dart';
import '../globals.dart' as globals;

int _selectedIndex = 0;

class BottomNavigationBusiness extends StatefulWidget {
  @override
  _BottomNavigationBusinessState createState() =>
      _BottomNavigationBusinessState();
}

class _BottomNavigationBusinessState extends State<BottomNavigationBusiness> {
  void _onItemTapped(int index) {
    setState(() {
      globals.showBadge = false;
      print(index);
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushNamed(context, DashboardBusiness.id);
      }
      if (index == 1) {
        Navigator.pushNamed(context, AppointmentsBusiness.id);
      }
      if (index == 2) {
        Navigator.pushNamed(context, Account.id);
      }
    });
  }

  @override
  Widget build(context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          title: Text('Appointments'),
          icon: Icon(Icons.calendar_today),
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
