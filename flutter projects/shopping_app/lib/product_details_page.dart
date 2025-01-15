import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers.dart';


class Details extends StatefulWidget {
 final  Map<String,Object> product;
  const Details({
    super.key,
    required this.product,
    
    });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int selectedSize=0;
  @override
  void initState() {
       
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  
    return  Scaffold(
      appBar:AppBar(
        title: const Text('Details ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ),),centerTitle: true,
       ) ,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(widget.product['title']as String,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 35 )),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(widget.product['imageUrl']as String),
            ),
            const Spacer(flex: 2,),
            Container(
              height: 250,
              decoration: BoxDecoration(color:const  Color.fromRGBO(245,247,249,1),
               borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Text('\$${(widget.product['price']as double).toString()}',style:  (Theme.of(context).textTheme.titleLarge ))
                ,
                const SizedBox(height: 10,),
                SizedBox(height: 50,
                  child: ListView.builder(scrollDirection: Axis.horizontal, 
                  itemCount: (widget.product['sizes'] as List<int>).length,
                    
                    
                    itemBuilder: (context,index){
                      int size=(widget.product['sizes'] as List<int>)[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize=size;
                            });
                          },
                          child: Chip(label: Text(size.toString()),backgroundColor: selectedSize==size? Colors.yellow:null  )),
                      ) ;
                    }),
                  

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon (onPressed: (){
                   if(selectedSize!=0){ Provider.of<CartProvider>(context,listen: false).addproduct(
                      {
    'id': widget.product['id'],
    'title': widget.product['title'],
    'price': widget.product['price'],
    'imageUrl': widget.product['imageUrl'],
    'company': widget.product['company'],
    'sizes': selectedSize,
  });
  
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added succesfully')));
}
  else{ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a size')));



  } 
                  }, icon: const Icon(Icons.shopping_cart_outlined ),
                  style: const ButtonStyle(backgroundColor:WidgetStatePropertyAll(Colors.yellow),iconColor:WidgetStatePropertyAll(Colors.black),
                    minimumSize: WidgetStatePropertyAll(Size(double.infinity, 50)),
                  ),label:const  Text('Add to Cart',style: TextStyle(color: Colors.black,fontSize: 18),),),
                )
                
                
                ]
                


              ),

            )
          ],


      ),
    )  ;
  }
}