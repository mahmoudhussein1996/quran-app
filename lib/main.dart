import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koran/cubit/student_cubit.dart';
import 'package:koran/screens/Home_screen.dart';
import 'package:koran/screens/add_degree.dart';
import 'package:koran/screens/add_student.dart';
import 'package:koran/screens/edit_degree.dart';
import 'package:koran/screens/results_screen.dart';
import 'package:koran/screens/student_information.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> StudentCubit()),
      ],
      child: MaterialApp(
        routes: {
          '/addstudent' : (context) => AddStudent(),
          '/adddegree' : (context) => AddDegree(),
          '/editdegree' : (context) => EditDegree(),
          '/resultscreen' : (context) => ResultsScreen(),
          '/studentinfo' : (context) => StudentInformation(),
          '/home' : (context) => HomeScreen()
        },
        theme: ThemeData(
            primarySwatch: Colors.green,
          // bottomNavigationBarTheme: BottomNavigationBarThemeData(
          //   unselectedLabelStyle: TextStyle(
          //     fontFamily: 'jana',
          //     color: Colors.red
          //   ),
          //   selectedLabelStyle: TextStyle(
          //     fontFamily: 'jana',
          //   )
          // )
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
