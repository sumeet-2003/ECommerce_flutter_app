import 'package:back_up/pages/login.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget{
  const SignUp({super.key});
  @override
  State<SignUp> createState()=>_SignUpState();
}
class _SignUpState extends State<SignUp>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 40),
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
                              "User Sign Up",
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
                        const Text("Create Password",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter your password";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Create your Password",
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width/1.5,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xffffbc11),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(child: Text("Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xffffffff)),)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const LogIn()));
                              },
                                child: const Text(" Log In",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Color(0xffffbc11)),)
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
