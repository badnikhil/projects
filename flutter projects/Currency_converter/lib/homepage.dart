


import 'package:flutter/material.dart';


class Homepage extends StatefulWidget{
  const Homepage ({super.key});

 @override
  State createState()=>_Convertedvarstate() ;
  }

  
class _Convertedvarstate extends State{
  double result=0;
    TextEditingController textEditingController=TextEditingController();
  void fn(){
     setState(() {
            result=double.parse(textEditingController.text)*81;
           });
  }
 @override
  Widget build(BuildContext context) {
   
    final border=  OutlineInputBorder(
                 borderSide: const BorderSide(color: Colors.black,
              width:  2.0,
              style: BorderStyle.solid,),
              borderRadius: BorderRadius.circular(5)     )
              ;
    return  MaterialApp( home: Scaffold(
      backgroundColor: Colors.blueGrey ,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Currency Converter",style: TextStyle(color: Colors.white),),
        centerTitle: true,


      ),
    body:  Center( child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Text('INR ${result!=0? result.toStringAsFixed(2):result.toStringAsFixed(0)}'  ,style:const TextStyle(
            fontSize: 25, 
            fontWeight: FontWeight.bold,
            color: Colors.white 
          ),


          ), TextField(
            controller: textEditingController ,
            keyboardType: TextInputType.number  ,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText:"Please enter the value in USD" ,
              hintStyle: const TextStyle(color: Colors.black),
              prefixIcon: const Icon(Icons.monetization_on_outlined ,),
              prefixIconColor: Colors.black,
              filled: true,
              fillColor: Colors.white,
              focusedBorder: border, 
                enabledBorder: border
              
          ),
          
                ),const SizedBox(width: 10,height: 10,),
          ElevatedButton(onPressed: fn,
          style:  ButtonStyle(
            elevation: const WidgetStatePropertyAll(30),
            backgroundColor: const WidgetStatePropertyAll(Colors.black),
            foregroundColor:  const WidgetStatePropertyAll(Colors.white),
            minimumSize: const WidgetStatePropertyAll(Size(double.infinity,50),),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5) 
            ))
          )
           ,child: const Text("Convert"),)
      ,const SizedBox(width: 10,height: 10,)
        ],
      ),
    )
    , 
   ),));  }
}


