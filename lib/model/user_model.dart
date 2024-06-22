class UserModel {
  String name;
  String? email; // email optional
  String role;
  String birthdate;
  String address;
  String? profilePic;
  String createdAt;
  String phoneNumber;
  String uid;

  UserModel({
    required this.name,
    this.email, 
    required this.role,
    required this.birthdate,
    required this.address,
    this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'],
      role: map['role'] ?? '',
      birthdate: map['birthdate'] ?? '',
      address: map['address'] ?? '',
      profilePic: map['profilePic'],
      createdAt: map['createdAt'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  set updatedAt(String updatedAt) {}

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "role": role,
      "birthdate": birthdate,
      "address": address,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "uid": uid,
    };
  }
}
