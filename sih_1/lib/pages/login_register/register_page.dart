import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_1/components/my_button.dart';
import 'package:sih_1/components/my_textfield.dart';
import 'package:sih_1/pages/home_page.dart';
import 'package:sih_1/pages/login_register/login_page.dart';
import 'models/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController passwordContoller = TextEditingController();

  final TextEditingController confirmpasswordContoller = TextEditingController();

  void register() async {
    if(passwordContoller.text == confirmpasswordContoller.text) {
      final phoneNumber = phoneController.text;
      Provider.of<AuthProvider>(context, listen: false).register(phoneNumber);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      return showDialog(
        context: context, 
        builder: (context) => const AlertDialog(
          title: Text('Passowrds don\'t match'),
        ) 
      );
    }
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
                  //name textfield
                  MyTextField(
                    controller: nameController, 
                    hintText: "Name", 
                    obscureText: false
                  ),  

                  //email textfield
                  MyTextField(
                    controller: phoneController, 
                    hintText: "Phone Number", 
                    obscureText: false
                  ),  
                
                  //password textfield
                  MyTextField(
                    controller: passwordContoller, 
                    hintText: "Password", 
                    obscureText: true,
                  ),  
                        
                  //confirm password
                  MyTextField(
                    controller: confirmpasswordContoller, 
                    hintText: "Confirm Password", 
                    obscureText: true,
                  ),  
      
              
                  const  SizedBox(height: 25,),
                  //sign in button
                  MyButton(
                    name: 'Sign Up',
                    onTap: register,
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
                      
                  //const SizedBox(height: 35,),
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
                        'Already an member?',
                        style: TextStyle(color: Colors.grey[700],   ),
                      ),
                      
                      const SizedBox(width: 4,),
                      
                      //register now
                      GestureDetector(
                        onTap: () { Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                        },
                        child: const Text(
                          'Login Now',
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
