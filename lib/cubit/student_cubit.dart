
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koran/models/degree.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

import '../models/student.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(StudentInitial());


  List<Student> allData = [];
  List<Degree> studentDegrees = [];

  File image;

  static StudentCubit get(context) => BlocProvider.of(context);

  Future<void> getStudents()
  async {
    emit(StudentLoadig());
    QuerySnapshot querySnapshot =  await FirebaseFirestore.instance.collection("students").get().onError((error, stackTrace)
    {
      emit(Studentdataerror());
    });
    //List<Student> allData = querySnapshot.docs.map((doc) => doc.data()).toList();


    querySnapshot.docs.forEach((element) {
      allData.add(Student.fromJson(element.data()));
    });

    emit(StudentdataSuccess());
  }

  Future<void> getStudentByName(String StudentName)
  async {
    emit(StudentLoadig());
    QuerySnapshot querySnapshot =  await FirebaseFirestore.instance.collection("students").where('name',isEqualTo: StudentName)
        .get().onError((error, stackTrace)
    {
      emit(Studentdataerror());
    });

    querySnapshot.docs.forEach((element) {
      emit(StudentInfoByNameSuccess(Student.fromJson(element.data())));
    });
  }

  void PickImage(ImageSource source) async {
    final images = await ImagePicker().pickImage(source: source);
    if (images != null)
      {
        image = File(images.path);
        emit(StudentimagePick());
      }
  }

  Future<String> uploadimage(File file) async {
    if (file == null) return null;

    String fileName = basename(file.path);
    final ref = FirebaseStorage.instance.ref("images/$fileName");

    UploadTask task = ref.putFile(file);

    final snapshot = await task.whenComplete(() {});

     final imageurl = await snapshot.ref.getDownloadURL();

     emit(StudentimageUpload());

     return imageurl;
  }

  Future<void> addStudentDegree(String studentID, String studentName,int degree,String date)
  {
     final firestoreinstance = FirebaseFirestore.instance.collection("students").doc(studentID)
         .collection('degrees').doc();

     String docid = firestoreinstance.id;

     DateTime currentPhoneDate = DateTime.now();
     Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate);

     Degree degreedata = Degree(id: docid,studentName: studentName,degree: degree,date: date,timestamp: myTimeStamp.millisecondsSinceEpoch.toString() );

     firestoreinstance.set(degreedata.tojson()).then((value)
     {
       emit(degreeaddSuccess());

     });
  }

  Future<void> getDegrresofStudent(String StudentId)
  async {
 studentDegrees = [];
    emit(StudentLoadig());
    final firestoreinstance = FirebaseFirestore.instance.collection("students").doc(StudentId)
        .collection('degrees').orderBy('createdAt', descending: false);

    QuerySnapshot querySnapshot = await firestoreinstance.get().onError((error, stackTrace)
    {
      emit(Studentdataerror());
    });

    querySnapshot.docs.forEach((element){

      studentDegrees.add(Degree.fromJson(element.data()));

    });


    emit(getAllDegrreById());
  }


  String countValueOfStudentbyDegree(int value)
  {
    if(value < 50) return'ضعيف';
    else if(value >=50 && value <65) return 'مقبول';
    else if(value >=65 && value <75) return 'جيد';
    else if(value >=75 && value <90) return 'جيد جدا';
    else return 'ممتاز';

  }

  int countDegreesOfStudent(List<Degree> degrees)
  {
    int countDegree = 0;
    int sumOfDegrees = 0;
    degrees.forEach((element) {
      sumOfDegrees += element.degree;
    });

    countDegree = (sumOfDegrees / (degrees.length * 100) * 100).toInt();

    return countDegree;
  }

  int countNumOfAbsent(List<Degree> degrees)
  {
    int numOfAbsent = 0;

    degrees.forEach((element) {
      if(element.degree == 0)
        {
          numOfAbsent++;
        }
    });

    return numOfAbsent;
  }

  Future<void> updateDegree(String StudentID,Degree degree)
  async {
   FirebaseFirestore.instance.collection("students").doc(StudentID)
        .collection('degrees').doc(degree.id).update(degree.tojson()).then((value)
    {
      //emit(degreeEditSuccess());
    }).catchError((error){

     // emit(Studentdataerror());
    });
  }
}
