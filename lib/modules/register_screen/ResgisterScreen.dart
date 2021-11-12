import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riderapp/main.dart';
import 'package:riderapp/modules/login_screen/LoginScreen.dart';

class RegisterScreen extends StatelessWidget
{
  TextEditingController RegisterNameController = TextEditingController() ;
  TextEditingController RegisterEmailController = TextEditingController() ;
  TextEditingController RegisterPhoneController = TextEditingController() ;
  TextEditingController RegisterPasswordController = TextEditingController() ;

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
              SizedBox(height: 25.0,),
              Image(
                image: AssetImage("images/logo.png"),
                width: 390,
                height: 240,
                alignment: Alignment.center,
              ),
              SizedBox(height: 5.0,),
              Text(
                "SignUp , Let's Start",
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
                      controller:RegisterNameController ,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: " Name ",
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
                      controller:RegisterEmailController ,
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
                      controller:RegisterPhoneController ,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: " Phone ",
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
                      controller:RegisterPasswordController ,
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
                          if (RegisterNameController.text.length < 3 )
                          {
                            DisplayToaste("Your Name Must Be More Than 2", context);
                          }  
                          else if (!RegisterEmailController.text.contains("@"))
                          {
                            DisplayToaste("Please Enter Correct Email", context);
                          }
                          else if (RegisterPhoneController.text.isEmpty)
                          {
                            DisplayToaste("Please Enter Phone Number ", context);
                          }
                          else if (RegisterPasswordController.text.length < 7)
                          {
                            DisplayToaste("Please Enter Password More Than 7 Number ", context);
                          }
                          else
                            {
                              SignUpNewUser(context);
                            }
                        },
                        color: Colors.yellow,
                        child: Center(
                          child: Text(
                            " SignUp ",
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
                            builder: (context)=>LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Already Have an Account? Login From Here.",
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

  SignUpNewUser(BuildContext context) async
  {
   final User firebaseUser = ( await
       _firebaseAuth.createUserWithEmailAndPassword
         (
           email: RegisterEmailController.text,
           password: RegisterPasswordController.text  ,
         )
   ).user;

   if(firebaseUser != null)
   {

     Map UserDataMap = {
       "name":RegisterNameController.text.trim() ,
       "email":RegisterEmailController.text.trim() ,
       "phone":RegisterPhoneController.text.trim() ,
       "password":RegisterPasswordController.text.trim(),
     };
     
     UserRef.child(firebaseUser.uid).set(UserDataMap); 
     DisplayToaste("Congrates for Created Account", context);

   } else
     {
       DisplayToaste("New User Haven't Created ", context);
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
