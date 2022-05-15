import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:koran/cubit/student_cubit.dart';
import 'package:koran/models/degree_argument.dart';
import 'package:koran/screens/add_degree.dart';

import '../constants/constants.dart';
import '../models/degree.dart';
import '../models/student.dart';
import '../models/student_arg.dart';


class StudentInformation extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Student studentdata = ModalRoute
        .of(context)
        .settings
        .arguments;

    String studentname = studentdata.name;
    String studentid = studentdata.id;
    String studentage = studentdata.age.toString();
    String studentimage = studentdata.image;

    StudentCubit.get(context).getStudentByName(studentname);
    StudentCubit.get(context).getDegrresofStudent(studentid);

    int dailydegree, monthlydegree = 0,yearlydegree = 0, numofabsent = 0;

    int Listofdegreesize = 1;

    String dailyvalue = '', monthlyvalue = '', yearlyvalue = '';

    List<Degree> listOfMonthDegree = [];
    List<Degree> listOfyearDegree = [];

    return Scaffold(
        appBar: AppBar(title: Text(studentname,style: normalstyle,),),
        body: SingleChildScrollView(
            child: BlocBuilder<StudentCubit, StudentState>(
                builder: (context, state) {
                  if (state is getAllDegrreById)
                     {
                      numofabsent = StudentCubit.get(context).countNumOfAbsent(StudentCubit.get(context).studentDegrees);


                       Listofdegreesize = StudentCubit.get(context).studentDegrees.length;

                        if(Listofdegreesize > 0)
                          {
                            dailydegree = StudentCubit.get(context).studentDegrees[Listofdegreesize-1].degree;
                            dailyvalue = StudentCubit.get(context).countValueOfStudentbyDegree(StudentCubit.get(context).studentDegrees[Listofdegreesize -1].degree);
                          }
                        else
                          {
                            dailydegree = 0;
                          }


                         if(StudentCubit.get(context).studentDegrees.length >= 8)
                            {
                               listOfMonthDegree = StudentCubit.get(context).studentDegrees.sublist(StudentCubit.get(context).studentDegrees.length - 8, StudentCubit.get(context).studentDegrees.length );
                               monthlydegree = StudentCubit.get(context).countDegreesOfStudent(listOfMonthDegree);
                               monthlyvalue = StudentCubit.get(context).countValueOfStudentbyDegree(monthlydegree);
                            }

                        if(StudentCubit.get(context).studentDegrees.length >= 96)
                        {
                           listOfyearDegree = StudentCubit.get(context).studentDegrees.sublist(StudentCubit.get(context).studentDegrees.length - 96, StudentCubit.get(context).studentDegrees.length );
                           yearlydegree = StudentCubit.get(context).countDegreesOfStudent(listOfyearDegree);
                           yearlyvalue = StudentCubit.get(context).countValueOfStudentbyDegree(yearlydegree);
                        }
                        return Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                              Container(
                                 width: MediaQuery.of(context).size.width,
                                 height: MediaQuery.of(context).size.height * 0.35,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(35),
                                     image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(studentimage!= null?studentimage:"https://images.pexels.com/photos/1767434/pexels-photo-1767434.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                                     ) ),
                              ),

                              SizedBox(
                                 height: 20,
                              ),

                              Padding(
                                 padding: const EdgeInsets.all(20),
                                 child: Column(
                                    children: [
                                       Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                             Text(studentname,style: normalstyle,),
                                             Text("الاسم",style: titletext,),
                                          ],
                                       ),
                                       SizedBox(height: 20,),
                                       Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                             Text(studentage.toString(),style: normalstyle,),
                                             Text("العمر",style: titletext,),
                                          ],
                                       ),
                                       SizedBox(height: 20,),
                                       Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                           Text(dailydegree.toString(),style: normalstyle,),
                                             Text(
                                                'درجة اليوم',
                                                style: titletext,
                                             )
                                          ],
                                       ),
                                       SizedBox(
                                          height: 20,
                                       ),
                                       Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                             Text(dailyvalue =='' ? 'لا يوجد': dailyvalue,style: normalstyle,),
                                             Text('التقدير اليومي', style: titletext)
                                          ],
                                       ),
                                       SizedBox(
                                          height: 20,
                                       ),
                                       Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                             Text(monthlyvalue == '' ? 'ليس بعد' : monthlyvalue,style: normalstyle,),
                                             Text('التقدير الشهري', style: titletext)
                                          ],
                                       ),
                                       SizedBox(
                                          height: 20,
                                       ),
                                       Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                             Text(yearlyvalue == '' ? 'ليس بعد' : yearlyvalue,style: normalstyle,),
                                             Text('التقدير السنوي', style: titletext)
                                          ],
                                       ),
                                       SizedBox(
                                          height: 20,
                                       ),
                                       Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                                Text(numofabsent.toString(),style: normalstyle,),
                                                Text('مرات الغياب', style: titletext)
                                             ],
                                          ),
                                       ),
                                       SizedBox(
                                          height: 20,
                                       ),
                                       Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                             Text('درجات الطالب ', style: titletext)
                                          ],
                                       ),
                                       SizedBox(
                                          height: 10,
                                       ),
                                       Listofdegreesize == 0? Container(
                                         child: Center(
                                           child: Text("لا توجد درجات مضافة الي الان"),
                                         ),
                                       ):Container(
                                          height: MediaQuery.of(context).size.height * 0.4,
                                          child: ListView.builder(
                                              shrinkWrap:true,
                                              itemBuilder: (context,index){
                                                 return Column(
                                                    children: [
                                                       ListTile(
                                                          leading: IconButton(icon: Icon(Icons.edit),onPressed: (){
                                                            Navigator.pushNamed(context, '/editdegree',arguments: DegreeArgument(StudentId: studentid,degree: StudentCubit.get(context).studentDegrees[index]));
                                                          },),
                                                          title: (Text(StudentCubit.get(context).studentDegrees[index].degree.toString(),style: normalstyle)),
                                                          trailing: Text(StudentCubit.get(context).studentDegrees[index].date.toString(),style: normalstyle),
                                                       ),
                                                       Divider(thickness: 5,)
                                                    ],
                                                 );
                                              },
                                              itemCount: StudentCubit.get(context).studentDegrees.length),
                                       ),
                                       SizedBox(
                                          height: 50,
                                       ),
                                    ],
                                 ),
                              ),
                              ElevatedButton(
                                 onPressed: () {
                                    Navigator.pushNamed(context, '/adddegree',arguments: studentarguments(studentid , studentname));
                                 },
                                 child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height * 0.08,
                                    child: Center(
                                      child: Text(
                                         'تسجيل درجة اليوم',
                                         textAlign: TextAlign.center
                                          ,style: normalstyle
                                      ),
                                    ),
                                 ),
                              ),
                              SizedBox(
                                 height: 20,
                              ),
                           ]
                        );
                     }


                  else if(state is StudentLoadig)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  else if(state is Studentdataerror)
                   return Center(
                      child: Text("خطآ في تحميل الداتا",style: normalstyle),
                    );
                  else
                    return Center(
                      child: Text("لا توجد بيانات لعرضها",style: normalstyle),
                    );
                }
            )
        )
    );
  }
}

