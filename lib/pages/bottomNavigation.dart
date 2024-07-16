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
  late Home HomePage;
  late Shopping ShoppingPage;
  late SignUp ProfilePage;
  int currentTabIndex=0;
  @override
  void initState(){
    HomePage=const Home();
    ShoppingPage=const Shopping();
    ProfilePage=const SignUp();
    pages=[HomePage,ShoppingPage,ProfilePage];
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: const Color(0xfff1f1f1) ,
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
