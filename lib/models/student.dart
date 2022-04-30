class Student {
  String id, name, image;
  int age;

  Student({this.id,this.name,this.age,this.image});

  Student.fromJson(Map<String, dynamic> json)
  {
    this.name = json['name'];
    this.id = json['docId'];
    this.image = json['image'];
    this.age = json['age'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> Studentdata =  Map<String, dynamic>();
    Studentdata['name'] = this.name;
    Studentdata['docId'] = this.id;
    Studentdata['image'] = this.image;
    Studentdata['age'] = this.age;

    return Studentdata;
  }

}