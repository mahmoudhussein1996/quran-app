
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:koran/cubit/student_cubit.dart';
import 'package:koran/screens/Home_screen.dart';
import 'package:koran/screens/student_information.dart';

import '../constants/constants.dart';
import '../models/student_arg.dart';

class AddDegree extends StatefulWidget {
  //String studentName;
  AddDegree();

  @override
  _AddDegreeState createState() => _AddDegreeState();
}

class _AddDegreeState extends State<AddDegree> {

  TextEditingController degreeController = TextEditingController();

  int _groupvalue = 1;
  bool visabilty = true;
  int degree;
  bool validate = false;

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();

    studentarguments studentarg = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('اضافة درجة اليوم',style: normalstyle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Row(
            children: [
            Radio(
            value: 2,
                groupValue: _groupvalue,
                onChanged: (value)
                {
                  setState(() {
                    visabilty = false;
                    _groupvalue = value as int;
                  });
                }
            ),
            SizedBox(width: 10,),
            Text("غائب",style: normalstyle)
          ],
        ),
                Row(
                  children: [
                    Radio(
                        value: 1,
                        groupValue: _groupvalue,
                        onChanged: (value)
                        {
                          setState(() {
                            visabilty = true;
                            _groupvalue = value as int;
                          });
                        }
                    ),
                    SizedBox(width: 10,),
                    Text("حاضر",style: normalstyle)
                  ],
                )
              ],
            ),
            Visibility(
              visible: visabilty,
              child: TextFormField(
                  controller: degreeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.auto_awesome),
                    labelText: 'درجة الطالب',
                    errorText: validate ? "ادخل درجة الطالب" : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2050),
                        helpText: "اختيار تاريخ اليوم",
                        cancelText: "ليس الان",
                        confirmText: "اختيار")
                    .then((date) {
                  if (date == null) {
                    return;
                  } else {
                    selectedDate = date;
                  }
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Center(
                  child: Text(
                    'اختيار التاريخ',style: normalstyle
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {

                if(visabilty == true && degreeController.text.isEmpty)
                  {
                    setState(() {
                      validate = true;
                    });
                  }
                else
                  {
                    if(visabilty == false)
                      degree = 0;
                    else
                    degree = int.parse(degreeController.text);

                    String date = DateFormat.yMMMd().format(selectedDate);


                    StudentCubit.get(context).addStudentDegree(studentarg.id, studentarg.name, degree, date);

                    Navigator.pushReplacementNamed(context, '/home');
                  }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Center(
                  child: Text(
                    'تسجيل',style: normalstyle
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
