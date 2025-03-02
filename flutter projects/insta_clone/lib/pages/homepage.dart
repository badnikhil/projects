import 'package:flutter/material.dart';
import 'package:insta_clone/screens/homescreen.dart';
import 'package:insta_clone/screens/searchscreen.dart';
import 'package:insta_clone/screens/addpostscreen.dart';
import 'package:insta_clone/screens/notifications.dart';
import 'package:insta_clone/screens/profile.dart';
import 'package:insta_clone/utils/home_page_utils/botton_navigation.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0); 
  final List<Widget> screens = [
    const Homescreen(),
    const Searchscreen(),
    const AddPostScreen(),
    const NotificationsScreen(),
    const Profile(),
  ];
  void _onItemTapped(int index) {
    _selectedIndex.value = index; 
    _pageController.jumpToPage(index);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), 
        children: screens,
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex, 
        builder: (context, index, child) {
          return BottomNavigation(
            selectedIndex: index,
            onItemTapped: _onItemTapped,
          );
        },
      ),
    );
  }
  @override
  void dispose() {
    _pageController.dispose();
    _selectedIndex.dispose();
    super.dispose();
  }
}
