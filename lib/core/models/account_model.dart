import 'dart:convert';

AccountModel accountModelFromMap(String str) => AccountModel.fromMap(json.decode(str));

String accountModelToMap(AccountModel data) => json.encode(data.toMap());

class AccountModel {
    AccountModel({
        this.id,
        this.name,
        this.phoneNumber,
        this.email,
        this.gender,
        this.placeOfBirth,
        this.dateOfBirth,
        this.address,
        this.password,
        this.isActive,
        this.photoProfile,
        this.token,
    });

    String id;
    String name;
    String phoneNumber;
    String email;
    String gender;
    dynamic placeOfBirth;
    DateTime dateOfBirth;
    String address;
    String password;
    bool isActive;
    String photoProfile;
    String token;

    factory AccountModel.fromMap(Map<String, dynamic> json) => AccountModel(
        id: json["_id"] ?? null,
        name: json["name"] ?? null,
        phoneNumber: json["phoneNumber"] ?? null,
        email: json["email"] ?? null,
        gender: json["gender"] ?? null,
        placeOfBirth: json["placeOfBirth"] ?? null,
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        address: json["address"] ?? null,
        password: json["password"] ?? null,
        isActive: json["isActive"] ?? null,
        photoProfile: json["photoProfile"] ?? null,
        token: json["token"] ?? null,
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "gender": gender,
        "placeOfBirth": placeOfBirth,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "address": address,
        "isActive": isActive,
        "photoProfile": photoProfile,
        "token": token,
    };
    
    Map<String, dynamic> toMapForEditProfile() => {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "gender": gender,
        "address": address,
        "placeOfBirth": placeOfBirth,
    };
    
    Map<String, dynamic> toMapForRegister() => {
        "name": name,
        "phoneNumber": phoneNumber,
        "password": password,
        "email": email,
        "dateOfBirth": dateOfBirth.toIso8601String(),
    };
}