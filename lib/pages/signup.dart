import 'package:back_up/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatefulWidget{
  const SignUp({super.key});
  @override
  State<SignUp> createState()=>_SignUpState();
}
class _SignUpState extends State<SignUp>{

  void _launchWhatsApp() async {
    const phoneNumber = '+919770497756'; // Replace with your desired phone number
    const message = 'Hello'; // Replace with your desired message
    final Uri url = Uri.parse('https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void _openDialPad() async {
    const phoneNumber = '+919770497756'; // Replace with your desired phone number
    final Uri url =Uri.parse( 'tel:$phoneNumber');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/img/login.jpeg"),
                Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                            child: Text(
                              "Describe Your Problem",
                              style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                        ),
                        const SizedBox(height: 20),
                        const Text("Name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter your name";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter your full name",
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Phone Number",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter your phone number";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter your Phone Number",
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Address",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter your address";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter your address",
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Problem",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter your problem";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter your Problem",
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: (){
                            _launchWhatsApp();
                          },
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width/1.5,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xffffbc11),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(child: Text("Book Now",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xffffffff)),)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Talk to us? ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                            GestureDetector(
                              onTap: (){
                                _openDialPad();
                              },
                                child: const Text("Contact",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Color(0xffffbc11)),)
                            ),
                          ],
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
