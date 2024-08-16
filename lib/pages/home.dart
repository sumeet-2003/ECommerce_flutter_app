
import 'package:back_up/pages/shopping.dart';
import 'package:back_up/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
    "assets/img/wires.jpeg",
  ];

  void _launchWeb() async {
    final Uri url = Uri.parse("https://bizliwale.com");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
  void _launchDev() async {
    final Uri url = Uri.parse("https://chitrashalaproduction.com");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

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
                  Text("BiZliWale ",
                      style: AppWidget.introHeading(),
                            ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('This feature is coming soon...'),
                        ),
                      );
                    },
                    child: const Icon(Icons.light_rounded,size: 40,color: Color(
                        0xff1fb8ff),),
                  ),
                ],
              ),
              Text("Electronics Sales & Services",
                style: AppWidget.greeting(),
              ),
              const SizedBox(height: 20,),
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
                              width: MediaQuery.of(context).size.width/1.2,
                              child: Image.asset('assets/img/sale-1.png',fit: BoxFit.cover)
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              height: 130,
                              width: MediaQuery.of(context).size.width/1.2,
                              child: Image.asset('assets/img/sale-4.png',fit: BoxFit.cover)
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              height: 130,
                              width: MediaQuery.of(context).size.width/1.2,
                              child: Image.asset('assets/img/sale-3.jpg',fit: BoxFit.cover)
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
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Shopping()));
                      },
                      child: const Text("See all",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
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
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Shopping()));
                      },
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
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Popular Products Brands",style: AppWidget.search(),),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Shopping()));
                      },
                      child: const Text("See all",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width/2.5,
                    padding: const EdgeInsets.all(5),
                    margin:const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:
                     GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Shopping()));
                        },
                       child: Center(
                          child: Image.asset('assets/img/surya-logo.jpg',fit: BoxFit.cover),
                                           ),
                     ),
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width/2.5,
                    padding: const EdgeInsets.all(5),
                    margin:const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Shopping()));
                      },
                      child: Center(
                        child: Image.asset('assets/img/Bajaj-Electricals-Logo.jpg',fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width/2.5,
                    padding: const EdgeInsets.all(5),
                    margin:const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Shopping()));
                      },
                      child: Center(
                        child: Image.asset('assets/img/polar-logo.jpeg',fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width/2.5,
                    padding: const EdgeInsets.all(5),
                    margin:const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Shopping()));
                      },
                      child: Center(
                        child: Image.asset('assets/img/pressfit-logo.png',fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width/2.5,
                    padding: const EdgeInsets.all(5),
                    margin:const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Shopping()));
                      },
                      child: Center(
                        child: Image.asset('assets/img/polycab-logo.jpeg',fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width/2.5,
                    padding: const EdgeInsets.all(5),
                    margin:const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Shopping()));
                      },
                      child: Center(
                        child: Image.asset('assets/img/havells-logo.jpg',fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
               const SizedBox(
                height: 30,
              ),
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: const Color(0xffeaeaea),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blue,width: 4)
                ),
                child: Column(
                    children:[
                      Text("BiZliWale",style: AppWidget.buyNow()),
                      Text("One stop solution for all electrical needs",style: AppWidget.search()),
                      Text("Visit Our Website to Schedule a Service",style: AppWidget.search()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.phone_in_talk_rounded,color: Color(
                              0xff1a58e8),size: 20,),
                          const Text("  0771-352-0523",style: TextStyle(color: Colors.blue,fontSize: 16),),
                          const SizedBox(width: 20,),
                          GestureDetector(
                            onTap: _launchWeb,
                            child:
                            const Text("www.bizliwale.com",style: TextStyle(color: Color(
                                0xff0059ff),fontSize: 16),),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _launchDev,
                              child: Text("Contact Developers  ",style: AppWidget.search(),)),
                          GestureDetector(
                            onTap: _launchDev,
                            child: const Icon(Icons.android_rounded,size:25,color: Color(0xff1fb8ff),),
                          ),
                        ],
                      ),
                    ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget{
  final String image;
 const CategoryTile({super.key, required this.image});
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