import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_1/components/my_button.dart';
import 'package:sih_1/components/my_textfield.dart';
import 'package:sih_1/pages/home_page.dart';
import 'package:sih_1/pages/login_register/forget_password.dart';
import 'package:sih_1/pages/login_register/register_page.dart';
import 'models/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordContoller = TextEditingController();

  void login() async {
    final phoneNumber = phoneController.text;
    Provider.of<AuthProvider>(context, listen: false).login(phoneNumber);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void register_page() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                  const SizedBox(height: 150,),
                  //logo
                  Icon(
                    Icons.lock_open_rounded,
                    size: 100,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  
                  const SizedBox(height: 25),
                  //Welcome back you've been missed!
                  // const Text("Grocery Store App"),
              
                  const SizedBox(height: 10),
                  //email textfield
                  MyTextField(
                    controller: phoneController, 
                    hintText: "PhoneNumber", 
                    obscureText: false
                  ),  
                
                  //password textfield
                  MyTextField(
                    controller: passwordContoller, 
                    hintText: "Password", 
                    obscureText: true,
                  ),  
                        
                  //forgot password
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ForgotPassword(),
                    )),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
              
                  const  SizedBox(height: 25,),
                  //sign in button
                  MyButton(
                    name: 'Sign In',
                    onTap:login,
                  ),
                      
                  const SizedBox(height: 25,),
                  // //or continue with
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Divider(
                  //         thickness: 0.5,
                  //         color: Colors.grey[400],
                  //       )
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 25),
                  //       child: Text(
                  //         ' Or continue with',
                  //         style: TextStyle(color: Colors.grey[700]),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Divider(
                  //         thickness: 0.5,
                  //         color: Colors.grey[400],
                  //       ),
                  //     )
                  //   ],
                  // ),
                      
                  // const SizedBox(height: 35,),
                  // //google + apple sign in buttons
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     //google
                  //     MySquareTile(
                  //       onTap: () {},
                  //       imagePath: 'lib/images/google.png'
                  //     ),
          
                  //     const SizedBox(width: 20,),
          
                  //     //apple
                  //     MySquareTile(
                  //       onTap: () {},
                  //       imagePath: 'lib/images/apple.png'
                  //     )
                  //   ],
                  // ),
                      
                  // const SizedBox(height: 25,),
                  //not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //not a memeber
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700],   ),
                      ),
                      
                      const SizedBox(width: 4,),
                      
                      //register now
                      GestureDetector(
                        onTap: register_page,
                        child: const Text(
                          'Register Now',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
