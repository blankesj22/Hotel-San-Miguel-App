class UserModel {
  String? uid;
  String? names;
  String? lastName;
  String? email;

  UserModel({
    this.uid,
    this.names,
    this.lastName,
    this.email,
  });

  //receiving data from firebase
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map["uid"],
      names: map["names"],
      lastName: map["lastName"],
      email: map["email"],
    );
  }

  //sending data to firebase
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "names": names,
      "lastName": lastName,
      "email": email,
    };
  }
}
