import 'package:back_up/widget/support_widget.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget{
  const ProductDetail({super.key});
  @override
  State<ProductDetail> createState()=>_ProductDetailState();
}
class _ProductDetailState extends State<ProductDetail>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f1),
      body: Container(
        padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  ),
              ),
            ),
              Center(
                  child: Image.asset("assets/img/fan-1.jpeg",height: 350,)
              ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all( 20),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(25),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Fan" ,style: AppWidget.introHeading(),),
                    Row(
                      children: [
                        Text("₹499",style: AppWidget.pdtPrice(),),
                        const SizedBox(width: 15,),
                        Text("₹599",style: AppWidget.oldPdtPrice(),),
                        const SizedBox(width: 15,),
                        Text("20% off",style: AppWidget.discount(),),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text("57 Reviews & 5 Ratings",style: AppWidget.rating(),),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xffffbc11),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Text("Buy Now",style: AppWidget.buyNow(),textAlign: TextAlign.center,),
                    ),
                    const SizedBox(height: 10,),
                    Text("Description",style: AppWidget.introHeading(),),
                    const SizedBox(height: 10,),
                    const Text("This is a fan with 3 blades and 5 speed modes with a remote control."),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
