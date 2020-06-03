// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    User({
        this.confirmed,
        this.blocked,
        this.favourite,
        this.id,
        this.username,
        this.email,
        this.provider,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.role,
        this.rated,
        this.userId,
    });

    bool confirmed;
    bool blocked;
    List<String> favourite;
    String id;
    String username;
    String email;
    String provider;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String role;
    double rated;
    String userId;

    factory User.fromJson(Map<String, dynamic> json) => User(
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        favourite: List<String>.from(json["favourite"].map((x) => x)),
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        role: json["role"],
        rated: json["rated"].toDouble(),
        userId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "confirmed": confirmed,
        "blocked": blocked,
        "favourite": List<dynamic>.from(favourite.map((x) => x)),
        "_id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "role": role,
        "rated": rated,
        "id": userId,
    };
}

class Role {
    Role({
        this.id,
        this.name,
        this.description,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.roleId,
    });

    String id;
    String name;
    String description;
    String type;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String roleId;

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        roleId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "type": type,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "id": roleId,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
