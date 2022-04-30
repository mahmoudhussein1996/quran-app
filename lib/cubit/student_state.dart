part of 'student_cubit.dart';

@immutable
abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoadig extends StudentState {}

class StudentdataSuccess extends StudentState {}

class degreeaddSuccess extends StudentState {}

class degreeEditSuccess extends StudentState {}

class getAllDegrreById extends StudentState {
}

class StudentInfoByNameSuccess extends StudentState {
  Student studentinfo;

  StudentInfoByNameSuccess(this.studentinfo);
}

class StudentimagePick extends StudentState {}

class StudentimageUpload extends StudentState {}

class Studentdataerror extends StudentState {}

