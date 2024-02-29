import 'package:drivers_app_project/tab_pages/earning_tab.dart';
import 'package:drivers_app_project/tab_pages/home_tab.dart';
import 'package:drivers_app_project/tab_pages/profile_tab.dart';
import 'package:drivers_app_project/tab_pages/ratings_tab.dart';
import 'package:flutter/material.dart';

class MainScreens extends StatefulWidget {

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> with SingleTickerProviderStateMixin {

  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index){
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: TabBarView(
       physics: NeverScrollableScrollPhysics(),
       controller: tabController,
       children: const [
         HomeTabPage(),
         EarningsTabPage(),
         RatingsTabPage(),
         ProfileTabPage()
       ],
     ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início '),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Lucros'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Avaliações '),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil '),
        ],
        unselectedItemColor: Colors.white54 ,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 14),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),
    );
  }
}
