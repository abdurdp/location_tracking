import 'package:flutter/material.dart';
import 'package:location_ba_task/division_thana_screen.dart';
import 'package:location_ba_task/map_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // backgroundColor: Colors.grey.shade200,
        bottomNavigationBar: menu(),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            MapScreen(),
            DivisionThanaDropdowns(),
          ],
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      child: const TabBar(
        labelColor: Colors.blueAccent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(2.0),
        indicatorWeight: 3.0,
        unselectedLabelColor: Colors.grey,
        tabs: [
          Tab(
            text: 'Map',
            icon: Icon(
              Icons.map,
              color: Colors.blueAccent,
            ),
          ),
          Tab(
            text: 'Location',
            icon: Icon(
              Icons.home_work_outlined,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
