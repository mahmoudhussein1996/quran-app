import 'package:cloud_firestore/cloud_firestore.dart';

class Degree
{
  String id,studentName,date;
  int degree;
  String timestamp;


  Degree({this.id,this.studentName,this.degree,this.date,this.timestamp});

  Degree.fromJson(Map<String,dynamic> json)
  {
    this.id = json['id'];
    this.studentName = json['student name'];
    this.degree = json['degree'];
    this.date = json['date'];
    this.timestamp = json['createdAt'];

  }

  Map<String ,dynamic> tojson()
  {
    Map<String ,dynamic> degreedata = Map<String , dynamic>();

    degreedata['id'] = this.id;
    degreedata['student name'] = this.studentName;
    degreedata['degree'] = this.degree;
    degreedata['date'] = this.date;
    degreedata['createdAt'] = this.timestamp;

    return degreedata;
  }
}