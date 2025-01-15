import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
 

  Widget build(BuildContext context) {
     final cart=Provider.of<CartProvider>(context).cart;
    return  Scaffold(
      appBar:AppBar(
        title: const Text('Cart'),
      ) ,
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context,index){
          final thiscart=cart[index];
          return ListTile(leading: CircleAvatar(backgroundImage: AssetImage((thiscart['imageUrl']as String)),backgroundColor: Colors.white,),
             trailing: IconButton(onPressed: (){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: const Text('Delete product'),
                content: const Text('Are you sure you want to delete this product?'),
                actions: [
                  TextButton(onPressed: (){
                    Provider.of<CartProvider>(context,listen: false).removeproduct(cart[index]);
                      Navigator.of(context).pop();
                  }, child: const Text('Yes')),
                   TextButton(onPressed: (){
                    Navigator.of(context).pop();
                   }, child: const Text('NO'))
                ],
              );
            });
                
             }, icon:const Icon(Icons.delete),color: Colors.red,),
              title: Text(thiscart['title'] as String),
              subtitle: Text('${thiscart['sizes']}'),
          );

      })
    );
  }
}