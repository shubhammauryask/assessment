import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MySignUp extends StatefulWidget {
  const MySignUp({Key? key}) : super(key: key);

  @override
  State<MySignUp> createState() => _MySignUpState();
}

class _MySignUpState extends State<MySignUp> {

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/register.jpg'), fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children:[
            Container(
              margin: const EdgeInsets.only(left: 40, top: 30),
              child: const Text("Register\nYourself",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: Colors.white
                ),),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.28, left: 40, right: 40),
                child: Column(
                  children: [
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                          hintText: "Name",
                          prefixIcon: const Icon(Icons.person, color: Colors.brown,),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_rounded, color: Colors.brown,),
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
                          prefixIcon: const Icon(Icons.lock_rounded, color: Colors.brown,),
                          hintText: "Password",
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(height: 50, width: 500),
                      child: ElevatedButton(onPressed: (){
                        var value = signUpWithEmailAndPassword(email.text.toString().trim(), password.text.toString().trim());
                        if(value == null){
                            null;
                        }
                        else{
                          Navigator.popAndPushNamed(context, 'home');
                        }
                      },
                          child: const Text("SIGN UP",
                            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),)
                      ),
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