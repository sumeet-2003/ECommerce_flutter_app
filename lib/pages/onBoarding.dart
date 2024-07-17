import 'package:back_up/pages/bottomNavigation.dart';
import 'package:back_up/pages/home.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget{
  const OnBoarding({super.key});
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}
class _OnBoardingState extends State<OnBoarding>{
  @override
  Widget build(BuildContext contaxt){
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 235, 231),
        body:
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 20,bottom: 20),
                    child: Image.asset("assets/img/banner.png")),
                const Text("Welcome,\nExplore the best quality products and Services",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const BottomNav()));

                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 35),
                        padding: const EdgeInsets.all(20),
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xff4395fd),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                            child: Row(
                              children: [
                                Text(" Dive IN  ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                Icon(Icons.arrow_circle_right_outlined),
                              ],
                            )
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}