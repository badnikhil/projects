import 'package:flutter/material.dart';
class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, 
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items:[
          BottomNavigationBarItem(icon: Icon( selectedIndex!=0? Icons.home_outlined:Icons.home,size: 30,), label: ""),
          const BottomNavigationBarItem(icon: Icon(Icons.search, size: 30), label: ""),
          const BottomNavigationBarItem(icon: Icon(Icons.add_box_rounded, size: 35), label: ""),
          BottomNavigationBarItem(icon: Icon(selectedIndex==3?Icons.favorite:Icons.favorite_outline, size: 30), label: ""),
          const BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 30), label: ""),
        ],
      ),
    );
  }
}
