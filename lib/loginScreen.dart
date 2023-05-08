import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  final email = TextEditingController();
  final password = TextEditingController();

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/login.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 70, top: 120),
              child: const Text("Welcome\nBack",
                style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.w900),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.43,
                    left: 40,
                    right: 40),
                child: Column(
                  children: [
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_rounded, color: Colors.brown),
                          hintText: "E-Mail",
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_rounded, color: Colors.brown),
                          hintText: "Password",
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(height: 50, width: 500),
                      child: ElevatedButton(onPressed: () async {
                        var value = signInWithEmailAndPassword(email.text.toString().trim(), password.text.toString().trim());
                        if(value == null){
                          null;
                        }
                        else{
                          Navigator.popAndPushNamed(context, 'home');
                        }
                      },
                        child: const Text("LOGIN", style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white
                        ),),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(height: 50, width: 500),
                        child: ElevatedButton.icon(onPressed: (){
                          // Code to Open Sign Up Screen
                          Navigator.pushNamed(context, 'signup');
                        },
                            icon: const Icon(Icons.arrow_right, size: 55,),
                            label: const Text("SIGN UP", style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                                color: Colors.white),)
                        )
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}