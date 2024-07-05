import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:back_up/pages/home.dart';
import 'package:back_up/pages/order.dart';
import 'package:back_up/pages/profile.dart';

class BottomNav extends StatefulWidget{
  const BottomNav({super.key});
  @override
  State<BottomNav> createState()=>_BottomNavState();
}
class _BottomNavState extends State<BottomNav>{
  late List<Widget> pages;
  late Home HomePage;
  late Order OrderPage;
  late Profile ProfilePage;
  int currentTabIndex=0;
  @override
  void initState(){
    HomePage=const Home();
    OrderPage=const Order();
    ProfilePage=const Profile();
    pages=[HomePage,OrderPage,ProfilePage];
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
            Icons.messenger_outline_rounded,
            color: Colors.white,
          ),
          Icon(
            Icons.person_outline_rounded,
            color: Colors.white,
          )
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
