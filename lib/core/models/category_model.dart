import 'dart:convert';

CategoryResponseModel categoryResponseModelFromMap(String str) => CategoryResponseModel.fromMap(json.decode(str));

String categoryResponseModelToMap(CategoryResponseModel data) => json.encode(data.toMap());

class CategoryResponseModel {
    CategoryResponseModel({
        this.category,
        this.totalCategory,
    });

    List<Category> category;
    int totalCategory;

    factory CategoryResponseModel.fromMap(Map<String, dynamic> json) => CategoryResponseModel(
        category: List<Category>.from(json["category"].map((x) => Category.fromMap(x))),
        totalCategory: json["totalCategory"],
    );

    Map<String, dynamic> toMap() => {
        "category": List<dynamic>.from(category.map((x) => x.toMap())),
        "totalCategory": totalCategory,
    };
}

class Category {
    Category({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
