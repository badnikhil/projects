// product_list.dart
import 'package:flutter/material.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/product_details_page.dart';
import 'package:shop_app/product_card.dart';

class ProductList extends StatefulWidget {
 final Function? resetSearch;
   
   const ProductList({super.key,this.resetSearch});
   
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<String> filters = const ['All', 'Adidas', 'Nike', 'Bata'];
  late String selectedFilter;
   

  int currPage = 0;
  final border = const OutlineInputBorder(
    borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
    borderSide: BorderSide(
      color: Color.fromRGBO(225, 225, 225, 1),
    ),
  );

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
    results = products;
  }
   

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Shoes \nCollection",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: (query) {
                    filterproducts(query);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search_rounded),
                    border: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                String filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                       filterproducts(selectedFilter);
                      });
                    },
                    child: Chip(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      label: Text(filter),
                      backgroundColor: filter == selectedFilter
                          ? const Color.fromRGBO(254, 206, 1, 1)
                          : const Color.fromRGBO(254, 247, 249, 1),
                      labelStyle: const TextStyle(fontSize: 16),
                      side: const BorderSide(color: Color.fromRGBO(254, 247, 249, 1)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return Details(product: results[index]);
                        },
                    ));
                  },
                  child: ProductCard(
                    title: results[index]['title'] as String,
                    imgurl: results[index]['imageUrl'] as String,
                    price: results[index]['price'] as double,
                    backgroung: index.isEven
                        ? const Color.fromRGBO(216, 240, 253, 1)
                        : const Color.fromRGBO(254, 247, 249, 1),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void filterproducts(String query) {
    if (query.isEmpty||query=='All') {
      results = products;
    } else {
      results = products.where((product) {
        return product['company'].toString().toLowerCase() == query.toLowerCase();
      }).toList();
    }
    setState(() {});
  }


  

  
}
