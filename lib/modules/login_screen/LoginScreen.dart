import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riderapp/main.dart';
import 'package:riderapp/modules/map_screen/MapScreen.dart';
import 'package:riderapp/modules/register_screen/ResgisterScreen.dart';

class LoginScreen extends StatelessWidget
{
  TextEditingController LoginEmailController = TextEditingController() ;
  TextEditingController LoginPasswordController = TextEditingController() ;
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding:  EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 45.0,),
              Image(
                  image: AssetImage("images/logo.png"),
                width: 390,
                height: 240,
                alignment: Alignment.center,
              ),
              SizedBox(height: 5.0,),
              Text(
                  'Login , Welcome Back',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding:  EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller:LoginEmailController ,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: " Email ",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ) ,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    TextField(
                      controller:LoginPasswordController ,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: " Password ",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ) ,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                      style: TextStyle(
                          fontSize: 14.0
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      height: 50.0,
                      width: double.infinity,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        onPressed: (){
                          if (!LoginEmailController.text.contains("@"))
                          {
                            DisplayToaste("Please Enter Correct Email", context);
                          }else if (LoginPasswordController.text.isEmpty)
                          {
                            DisplayToaste("Please Enter Password", context);
                          } else
                            {
                              LoginAndAuthenticateUser(context);
                            }

                        },
                        color: Colors.yellow,
                        child: Center(
                          child: Text(
                            " Login ",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    TextButton(
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context)=>RegisterScreen(),
                              ),
                          );
                        },
                        child: Text(
                            "Don't Have an Account? Register From Here.",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
 void LoginAndAuthenticateUser(BuildContext context) async
  {
    final User firebaseUser = ( await
        _firebaseAuth.signInWithEmailAndPassword
        (
        email: LoginEmailController.text,
        password: LoginPasswordController.text  ,
    )
    ).user;


    if(firebaseUser != null)
    {

      UserRef.child(firebaseUser.uid).once().then((DataSnapshot snap){
        if(snap.value != null ){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context)=>MapScreen(),
            ),
          );
          DisplayToaste("Congrates for Logged in", context);
        }
        else  {
          _firebaseAuth.signOut();
          DisplayToaste("No Record for this account", context);
        }
      });


    } else {
      DisplayToaste("Error Ocurd ", context);
    }

  }

  DisplayToaste ( msg , context)
  {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.yellow
    );
  }
}
