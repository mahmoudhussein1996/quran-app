import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koran/models/student.dart';
import 'package:path/path.dart';

import '../constants/constants.dart';
import '../cubit/student_cubit.dart';
import 'Home_screen.dart';

class AddStudent extends StatefulWidget {
  const AddStudent();

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();

  final studentKey = GlobalKey<FormState>();

  bool isload = false;

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<StudentCubit, StudentState>(
      builder: (context, state) {

        if(state is StudentimageUpload) return Center(child: CircularProgressIndicator());

        var image = StudentCubit.get(context).image;

        return Scaffold(
          appBar: AppBar(title: Text("اضافة الطالب ",style: normalstyle)),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: studentKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: namecontroller,
                      validator: (value){
                        if(value.isEmpty) return 'من فضلك ادخل اسم الطالب';
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon: Icon(Icons.person),
                        labelText: 'اسم الطالب',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: agecontroller,
                        validator: (value){
                          if(value.isEmpty) return 'من فضلك ادخل عمر الطالب';
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.auto_awesome),
                          labelText: 'عمر الطالب',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: image != null
                              ? Image.file(
                            image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          )
                              : Image.network(
                            "https://icon-library.com/images/add-photo-icon/add-photo-icon-19.jpg",
                            width: 100,
                            height: 100,
                          ),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                        leading: Icon(Icons.camera_alt),
                                        title: Text("camera"),
                                        onTap: () {
                                          StudentCubit.get(context).PickImage(ImageSource.camera);
                                          Navigator.of(context).pop();
                                        }),
                                    ListTile(
                                        leading: Icon(Icons.image),
                                        title: Text("gallery"),
                                        onTap: () {
                                          StudentCubit.get(context).PickImage(ImageSource.gallery);
                                          Navigator.of(context).pop();
                                        })
                                  ],
                                ));
                          },
                        ),
                        if(image == null) Text("اضغط هنا لاختيار صوره",style: normalstyle)
                        else Text("تم اختيار الصوره",style: normalstyle)
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                     !isload ? ElevatedButton(
                        onPressed: () async {

                          if (studentKey.currentState.validate()) {
                            setState(() {
                              isload = true;
                            });
                            String imagelink = await StudentCubit.get(context).uploadimage(image);

                            final firestoreInstance =
                            FirebaseFirestore.instance.collection('students').doc();

                            Student student = Student(id: firestoreInstance.id,name: namecontroller.text,age: int.parse(agecontroller.text),image: imagelink);
                            firestoreInstance.set(student.toJson()).then((value)
                            {
                              setState(() {
                                isload = false;
                              });
                              Navigator.pushReplacementNamed(context, '/home');
                            });

                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: Center(
                            child: Text(
                                'تسجيل',
                                textAlign: TextAlign.center
                                ,style: normalstyle
                            ),
                          ),
                        ),
                      ): Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}



