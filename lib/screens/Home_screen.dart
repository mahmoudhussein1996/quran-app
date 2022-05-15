import 'package:flutter/material.dart';
import 'package:koran/screens/results_screen.dart';

import '../constants/constants.dart';
import 'add_student.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedindex = 0;

// this is last comment 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('الصفحة الرئيسية',style: normalstyle),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'الصفحة الرئيسية'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                ),
                label: 'اضافة طالب'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.family_restroom,
                ),
                label: 'نتائج الطلاب'),
          ],
          currentIndex: selectedindex,
          onTap: (index) {
            if(index == 2)
              {
              setState(()  {
              selectedindex = index;
              Navigator.pushNamed(context, '/resultscreen');
              });
              }
            else if(index == 1)
              {
                setState(()  {
                  selectedindex = index;
                  Navigator.pushNamed(context, '/addstudent');
                });
              }

          },
        ),
        body: Container(
          height: double.infinity,
          child: Image(
            fit: BoxFit.contain,
            image: AssetImage('assets/images/koran.png'),
          ),
        ));
  }
}
