import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koran/cubit/student_cubit.dart';
import 'package:koran/models/student_arg.dart';
import 'package:koran/screens/student_information.dart';

import '../constants/constants.dart';
import '../models/student.dart';


class ResultsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    StudentCubit.get(context).allData = [];
    StudentCubit.get(context).getStudents();
    return Scaffold(
      appBar: AppBar(
        title: Text('نتائج الطلبة',style: normalstyle),
      ),
      body: BlocBuilder<StudentCubit, StudentState>(
  builder: (context, state) {
    if(state is StudentLoadig)

      return  Center(
              child: CircularProgressIndicator());

    else if(state is StudentdataSuccess)

      if(StudentCubit.get(context).allData.length == 0)
        return  Container(
            child: Center(
                child: Text("لا يوجد معلومات لعرضها",style: normalstyle)));
      else
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text('الصورة', style: titletext),
                SizedBox(
                  width: 10,
                ),
                Text('العمر', style: titletext),
                SizedBox(
                  width: 10,
                ),
                Text('الاسم', style: titletext)
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
                          itemCount: StudentCubit.get(context).allData.length,
                          itemBuilder: (context, index) {
                            return  GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/studentinfo',arguments: Student(id: StudentCubit.get(context).allData[index].id,name: StudentCubit.get(context).allData[index].name,age: StudentCubit.get(context).allData[index].age,image: StudentCubit.get(context).allData[index].image));
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10,top: 20,bottom: 20,right: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.1,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey,
                                            size: 30,
                                          ),
                                          onPressed: ()
                                          {
                                            FirebaseFirestore.instance.collection("students").doc(StudentCubit.get(context).allData[index].id.toString()).delete();
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: CircleAvatar(
                                          radius: 25.0,
                                          backgroundImage:
                                          NetworkImage("${StudentCubit.get(context).allData[index].image != null?StudentCubit.get(context).allData[index].image :"https://static.thenounproject.com/png/396915-200.png"}"),
                                          //  backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      SizedBox(width: 30,),
                                      //Image.network("${snapshot.data[index]['image']}",height: 40,width: 40,fit: BoxFit.cover),
                                      Container(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          child: Text("${StudentCubit.get(context).allData[index].age}",style: normalstyle,)),
                                      Container(
                                          width: MediaQuery.of(context).size.width * 0.25,
                                          child: Text("${StudentCubit.get(context).allData[index].name}",style: normalstyle,overflow: TextOverflow.ellipsis,)
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
            )
          )
        ],
      );
    else return Center(
        child: Text("خطآ في تحميل الداتا",style: normalstyle),
      );
  },
),

);
  }
}
