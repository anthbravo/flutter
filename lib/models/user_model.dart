class UserModel {
  final String id;
  final String name;
  final String lastName;

  const UserModel(this.name, this.lastName, {this.id = '0'});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "lastName": lastName,
    };
  }

  Map<String, dynamic> toMapInsert() {
    return <String, dynamic>{
      "name": name,
      "lastName": lastName,
    };
  }
}
