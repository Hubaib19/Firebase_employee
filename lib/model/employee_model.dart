class EmployeeModel {
  String? id;
  String? name;
  String? location;
  int? age;

  EmployeeModel({
    required this.age,
    required this.id,
    required this.location,
    required this.name,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      age: json["age"],
      id: json["id"],
      location: json["location"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "location": location, "age": age};
  }
}
