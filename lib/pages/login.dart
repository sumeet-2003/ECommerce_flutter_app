import 'package:back_up/pages/signup.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget{
  const LogIn({super.key});
  @override
  State<LogIn> createState()=>_LogInState();
}
class _LogInState extends State<LogIn>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 40),
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
                            "User Log In",
                            style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                      ),
                      const SizedBox(height: 20),
                      const Text("Phone Number",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: "Enter your Phone Number",
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("Password",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: "Enter your Password",
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      const Center(child: Text("Forgot Password?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width/1.5,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color(0xffffbc11),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(child: Text("Log In",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xffffffff)),)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUp()));
                            },
                              child: const Text(" Sign Up",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Color(0xffffbc11)),)),
                        ],
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
