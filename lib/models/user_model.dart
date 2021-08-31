class UserModel {
  String? id;
  String name;
  String lastName;

  UserModel(this.name, this.lastName, [this.id]);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "lastName": lastName,
    };
  }
}
