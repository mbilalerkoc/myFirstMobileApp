import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstapp/common/path.dart';
import 'package:myfirstapp/features/dashboard/views/dashboard.dart';
import 'package:myfirstapp/features/profile/views/profile.dart';
import '../../../common/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex =0; // Variable to keep track of the selected index in the BottomNavigationBar

  onTap(int index) {
    setState(() {
      _currentIndex = index; // basılan indexi güncellemek için setState kullanarak _currentIndex'i güncelliyoruz
    });
  }

  List<Widget> list = [Dashboard(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex], // sayfalr arası geçiş için listeden seçilen indexe göre sayfa gösterimi
           
      bottomNavigationBar: BottomNavigationBar(
        // BottomNavigationBar widget for navigation
        selectedLabelStyle: TextStyle(color: TitleColor),
        currentIndex: _currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(homeDeactiveSvg),
            activeIcon: SvgPicture.asset(homeActiveSvg),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(profileDeactiveSvg),
            activeIcon: SvgPicture.asset(profileActiveSvg),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
