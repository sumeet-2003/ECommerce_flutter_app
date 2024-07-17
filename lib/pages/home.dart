import 'package:back_up/pages/productDetail.dart';
import 'package:back_up/pages/shopping.dart';
import 'package:back_up/widget/support_widget.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget{
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home>{

  List categories=[
    "assets/img/fan.jpeg",
    "assets/img/btn.jpeg",
    "assets/img/led-light.jpeg",
    "assets/img/mcb.jpeg",
    "assets/img/slider.jpeg",
    "assets/img/wires.jpeg",
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f1),
      body:Container(
        margin: const EdgeInsets.only(top: 50,left: 20,right: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Welcome, User",
                      style: AppWidget.introHeading(),
                            ),
                  Container(
                      child: const Icon(Icons.person,size: 35,)),
                ],
              ),
              Text("Greetings from Bizliwale",
                style: AppWidget.greeting(),
              ),
              const SizedBox(height: 20,),
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
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                              height: 130,
                              width: 270,
                              child: Image.asset('assets/img/logo.png',fit: BoxFit.cover)
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              height: 130,
                              width: 270,
                              child: Image.asset('assets/img/logo.png',fit: BoxFit.cover)
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              height: 130,
                              width: 270,
                              child: Image.asset('assets/img/logo.png',fit: BoxFit.cover)
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Categories",style: AppWidget.search(),),
                  const Text("See all",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                ],
              ),
              Row(
                children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Shopping()));
                },
                child: Container(
                  height: 130,
                  padding: const EdgeInsets.only(top: 10),
                  margin:const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                  color: const Color(0xff3e7bfa),
                  borderRadius: BorderRadius.circular(10)
                  ),
                  width: 80,
                  child:
                      const Center(
                          child: Text("View\n  All",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),)
                  ),
                ),
              ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: 150,
                      child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                          return CategoryTile(image: categories[index]);
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All Products",style: AppWidget.search(),),
                  const Text("See all",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                ],
              ),
              Container(
                height: 255,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProductDetail()));
                              },
                              child: Column(
                                children: [
                                  Image.asset("assets/img/fan-1.jpeg",height: 160,width: 160,),
                                  Text("Fans",style: AppWidget.search(),),
                                  Row(
                                    children: [
                                      Text("  Starts from ₹499",style: AppWidget.price()),
                                    ],
                                  ),
                                                      ],
                              ),
                            ),
                          ),
                           SizedBox(
                            width: MediaQuery.of(context).size.width/20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                Image.asset("assets/img/fan-1.jpeg",height: 160,width: 160,),
                                Text("Product 2",style: AppWidget.search(),),
                                Row(
                                  children: [
                                    Text("  Starts from ₹999",style: AppWidget.price()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 255,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProductDetail()));
                              },
                              child: Column(
                                children: [
                                  Image.asset("assets/img/fan-1.jpeg",height: 160,width: 160,),
                                  Text("Fans",style: AppWidget.search(),),
                                  Row(
                                    children: [
                                      Text("  Starts from ₹499",style: AppWidget.price()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width/20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                Image.asset("assets/img/fan-1.jpeg",height: 160,width: 160,),
                                Text("Product 2",style: AppWidget.search(),),
                                Row(
                                  children: [
                                    Text("  Starts from ₹999",style: AppWidget.price()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class CategoryTile extends StatelessWidget{
 String image;
 CategoryTile({super.key, required this.image});
  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin:const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(10)
      ),
      width: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(image,height: 90,width: 90,fit: BoxFit.cover,),
          const Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}