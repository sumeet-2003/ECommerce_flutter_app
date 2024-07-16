import 'package:flutter/material.dart';
import 'package:back_up/widget/support_widget.dart';

class Shopping extends StatefulWidget{
  const Shopping({super.key});
  @override
  State<Shopping> createState()=>_ShoppingState();
}
class _ShoppingState extends State<Shopping>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f1),
      body: Column(
        children:[
          Padding(
            padding: const EdgeInsets.only(top: 30,left: 10),
            child: Row(
              children: [
                 GestureDetector(
                   onTap: (){
                      Navigator.pop(context);
                      },
                     child: const Icon(Icons.arrow_back_ios,size: 30,)),
                 const SizedBox(width: 10,),
                 const Text("Shopping",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              color: const Color(0xffffffff),

              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              decoration: InputDecoration(border: InputBorder.none,
                hintText: "Search",hintStyle: AppWidget.search(),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ]
      )
    );
  }
}
