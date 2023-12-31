import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../service/Auth_Services.dart';
import 'homepage.dart';

class signinPage extends StatefulWidget {
  const signinPage({Key? key}) : super(key: key);

  @override
  State<signinPage> createState() => _signinPageState();
}

class _signinPageState extends State<signinPage> {
  firebase_auth.FirebaseAuth firebaseAuth= firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(//wrap with container
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign In",style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              ),
              SizedBox(height: 20,
              ),
              buttonItem('assets/google.png', "Continue with Google",25,(){
                authClass.googleSignIn(context);
              } ),
              SizedBox(
                height: 15,
              ),
              // buttonItem('assets/phone.png', "Continue with Mobile",25,(){}),
              // SizedBox(
              //   height: 15,
              // ),
              Text("Or",style: TextStyle(color: Colors.white,fontSize: 18),),
              SizedBox(
                height: 15,
              ),
              textItem("Email",_emailController,false),
              SizedBox(
                height: 15,
              ),
              textItem("Password",_pwdController,true),
              SizedBox(
                height: 30,
              ),
              colorButton(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("If you don't have an account? ",style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  ),
                  Text("SignUp",style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Forget Password?",style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton(){
    return InkWell(
      onTap: () async{
        try{
          firebase_auth.UserCredential userCredential = await firebaseAuth
              .signInWithEmailAndPassword(email: _emailController.text, password: _pwdController.text);
          print(userCredential.user?.email);
          setState(() {
            circular=false;
          });
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>homepage()),
                  (route) => false);

        }
        catch(e)
        {
          final snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            circular=false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width-90,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Color(0xfffd746c),
              Color(0xffff9068),
              Color(0xfffd746c)
            ])
        ),
        child: Center(
          child: circular?CircularProgressIndicator():
          Text("Sign In",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonItem(String imagepath, String buttonName, double size,onTap)
  {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width-60,
        height: 60,
        child: Card(
          color: Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              width: 1,color: Colors.grey,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagepath,
                height: size,
                width: size,
              ),
              //Image.asset('assets/phone.png'),
              SizedBox(
                width: 15,
              ),
              Text(
                buttonName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget textItem(String labeltext,TextEditingController controller,bool obscureText){
    return Container(
      width: MediaQuery.of(context).size.width-70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
            fontSize: 17,
            color: Colors.white
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.white
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
