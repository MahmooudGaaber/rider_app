import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riderapp/modules/map_screen/Cubit/Cubit.dart';
import 'package:riderapp/modules/map_screen/Cubit/States.dart';
import 'modules/login_screen/LoginScreen.dart';
import 'modules/map_screen/MapScreen.dart';
import 'modules/register_screen/ResgisterScreen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference UserRef = FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (context)=>MapScreenCubit(),
      child: BlocConsumer<MapScreenCubit,MapScreenState>(
        listener: (BuildContext context, state)
        {

        },
        builder: (BuildContext context, state)
        {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              fontFamily: "Brand Bold",
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: MapScreen(),
            debugShowMaterialGrid: false,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
