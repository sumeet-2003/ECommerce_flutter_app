import 'package:back_up/pages/signup.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:back_up/pages/home.dart';
import 'package:back_up/pages/shopping.dart';

class BottomNav extends StatefulWidget{
  const BottomNav({super.key});
  @override
  State<BottomNav> createState()=>_BottomNavState();
}
class _BottomNavState extends State<BottomNav>{
  late List<Widget> pages;
  late Home homePage;
  late Shopping shoppingPage;
  late SignUp profilePage;
  int currentTabIndex=0;
  @override
  void initState(){
    homePage=const Home();
    shoppingPage=const Shopping();
    profilePage=const SignUp();
    pages=[homePage,shoppingPage,profilePage];
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Colors.transparent ,
        color: const Color(0xff3e7bfa),
        animationDuration: const Duration(milliseconds: 300),
        onTap: (int index){
          setState(() {
            currentTabIndex=index;
          });
        },
        items: const [
          Icon(
              Icons.home_sharp,
              color: Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          Icon(
            Icons.message,
            color: Colors.white,
          )
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
