class EmployeeModel {
  String? id;
  String? name;
  String? location;
  int? age;
  String? image;

  EmployeeModel({
    required this.age,
    required this.id,
    required this.location,
    required this.name,
required this.image
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      image: json["image"],
      age: json["age"],
      id: json["id"],
      location: json["location"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "location": location, "age": age,"image":image};
  }
}