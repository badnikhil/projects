// homepage.dart
import 'package:flutter/material.dart';
import 'package:shop_app/cart_page.dart';
import 'package:shop_app/global_variables.dart';

import 'package:shop_app/product_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
 
  List<String> filters = const ['All', 'Adidas', 'Nike', 'Bata'];
  
  late String selectedFilter;
  int currPage = 0;

  @override
  void initState() {
    selectedFilter = filters[0];
    super.initState();
  }
  void resetSearch() {
    searchController.clear();
    setState(() {
      results = products; 
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currPage,
        children: [ProductList(resetSearch: resetSearch),
          const  CartPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currPage,
        onTap: (value) {
          setState(() {
            currPage = value;
             if(currPage==0) resetSearch();
          });
          
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: '')
        ],
      ),
    );
  }

 
  
}
