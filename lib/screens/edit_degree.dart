import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koran/cubit/student_cubit.dart';
import 'package:koran/models/degree.dart';
import 'package:koran/models/degree_argument.dart';

import '../constants/constants.dart';


class EditDegree extends StatelessWidget {
   EditDegree();

  TextEditingController degreeController = TextEditingController();
   final degreekey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    DegreeArgument degreeArgument = ModalRoute.of(context).settings.arguments;

    degreeController.text = degreeArgument.degree.degree.toString();

    return Scaffold(
      appBar: AppBar(title: Text("تعديل الدرجة",style: normalstyle),),
      body:  Container(
          child: Form(
          key: degreekey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  controller: degreeController,
                  validator: (value){
                    if(value.isEmpty) return 'من فضلك ادخل درجة الطالب';
                    else if(int.parse(value) > 100) return 'من فضلك ادخل درجة اقل من 100';
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.auto_awesome),
                    labelText: 'درجة الطالب',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  )),

              SizedBox(height: 50,),

              ElevatedButton(
                onPressed: () {
                  if(degreekey.currentState.validate())
                    {
                      Degree editedDegree = Degree(id: degreeArgument.degree.id,studentName: degreeArgument.degree.studentName,degree: int.parse(degreeController.text),date:  degreeArgument.degree.date,timestamp:  degreeArgument.degree.timestamp);
                       StudentCubit.get(context).updateDegree(degreeArgument.StudentId, editedDegree);

                      Navigator.pushNamed(context, '/home');
                    }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Text(
                    'حفظ الدرجة',
                    textAlign: TextAlign.center,
                      style: normalstyle
                  ),
                ),
              )
            ],
          )
        ),
      ));
  }
}
