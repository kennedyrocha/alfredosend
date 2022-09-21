import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendify/core/utils/custom_colors.dart';
import 'package:sendify/features/analytics/presentation/analytics_screen.dart';
import 'package:sendify/features/send/presentation/send_screen.dart';
import 'package:sendify/features/templates/presentation/templates_screen.dart';

class DashBoard extends StatefulWidget {
  static const PATH = "/dashboard";

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    SendScreen(),
    TemplateScreen(),
    AnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.BACKGROUND,
      body: GestureDetector(
        child: _children[_currentIndex],
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  _buildBottomBar() => BottomNavigationBar(
        unselectedItemColor: CustomColors.FONT,
        selectedItemColor: CustomColors.FONT,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        backgroundColor: CustomColors.PRIMARY_COLOR,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.send),
            label: "Enviar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web_rounded),
            label: "Modelos",
          )/*,
          BottomNavigationBarItem(
            icon: new Icon(Icons.analytics),
            label: "Analítico",
          ),*/
        ],
      );

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
