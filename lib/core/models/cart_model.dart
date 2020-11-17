import 'dart:convert';

import 'package:kedatonkomputer/core/models/account_model.dart';
import 'package:kedatonkomputer/core/models/product_model.dart';

CartModel cartModelFromMap(String str) => CartModel.fromMap(json.decode(str));

String cartModelToMap(CartModel data) => json.encode(data.toMap());

class CartModel {
    CartModel({
        this.cart,
        this.totalCart,
        this.totalCost,
    });

    List<Cart> cart;
    int totalCart;
    int totalCost;

    factory CartModel.fromMap(Map<String, dynamic> json) => CartModel(
        cart: List<Cart>.from(json["cart"].map((x) => Cart.fromMap(x))),
        totalCart: json["totalCart"],
        totalCost: json["totalCost"],
    );

    Map<String, dynamic> toMap() => {
        "cart": List<dynamic>.from(cart.map((x) => x.toMap())),
        "totalCart": totalCart,
        "totalCost": totalCost,
    };
}

class Cart {
    Cart({
        this.id,
        this.quantity,
        this.user,
        this.product,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String id;
    int quantity;
    AccountModel user;
    Product product;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Cart.fromMap(Map<String, dynamic> json) => Cart(
        id: json["_id"],
        quantity: json["quantity"],
        user: AccountModel.fromMap(json["user"]),
        product: Product.fromMap(json["product"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "quantity": quantity,
        "user": user.toMap(),
        "product": product.toMap(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}