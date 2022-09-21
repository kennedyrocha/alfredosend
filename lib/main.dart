import 'package:flutter/material.dart';
import 'package:sendify/features/dashboard/presentation/dashboard.dart';
import 'core/di/di.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: setupRoutes(),
      initialRoute: DashBoard.PATH,

      debugShowCheckedModeBanner: false,
    );
  }

  Map<String, WidgetBuilder> setupRoutes() =>
      {DashBoard.PATH: (BuildContext context) => DashBoard()};
}
//asd