import 'dart:convert';

OrderModel orderModelFromMap(String str) => OrderModel.fromMap(json.decode(str));

String orderModelToMap(OrderModel data) => json.encode(data.toMap());

List<OrderModel> ordersModelFromMap(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromMap(x)));

String ordersModelToMap(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class OrderModel {
    OrderModel({
        this.orderNotes,
        this.admin,
        this.totalPrice,
        this.totalItem,
        this.rating,
        this.ulasan,
        this.paymentMethod,
        this.proofTransactionBill,
        this.proofItemReceived,
        this.cancelReason,
        this.id,
        this.transactionCode,
        this.user,
        this.detailProducts,
        this.statusTransaction,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String orderNotes;
    dynamic admin;
    int totalPrice;
    int totalItem;
    int rating;
    String ulasan;
    String paymentMethod;
    String proofTransactionBill;
    String proofItemReceived;
    String cancelReason;
    String id;
    String transactionCode;
    String user;
    List<DetailProduct> detailProducts;
    String statusTransaction;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
        orderNotes: json["orderNotes"],
        admin: json["admin"],
        totalPrice: json["totalPrice"],
        totalItem: json["totalItem"],
        rating: json["rating"],
        ulasan: json["ulasan"],
        paymentMethod: json["paymentMethod"],
        proofTransactionBill: json["proofTransactionBill"],
        proofItemReceived: json["proofItemReceived"],
        cancelReason: json["cancelReason"],
        id: json["_id"],
        transactionCode: json["transactionCode"],
        user: json["user"],
        detailProducts: List<DetailProduct>.from(json["detailProducts"].map((x) => DetailProduct.fromMap(x))),
        statusTransaction: json["statusTransaction"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "orderNotes": orderNotes,
        "admin": admin,
        "totalPrice": totalPrice,
        "totalItem": totalItem,
        "rating": rating,
        "ulasan": ulasan,
        "paymentMethod": paymentMethod,
        "proofTransactionBill": proofTransactionBill,
        "proofItemReceived": proofItemReceived,
        "cancelReason": cancelReason,
        "_id": id,
        "transactionCode": transactionCode,
        "user": user,
        "detailProducts": List<dynamic>.from(detailProducts.map((x) => x.toMap())),
        "statusTransaction": statusTransaction,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class DetailProduct {
    DetailProduct({
        this.id,
        this.count,
        this.product,
        this.price,
        this.totalPrice,
    });

    String id;
    int count;
    String product;
    int price;
    int totalPrice;

    factory DetailProduct.fromMap(Map<String, dynamic> json) => DetailProduct(
        id: json["_id"],
        count: json["count"],
        product: json["product"],
        price: json["price"],
        totalPrice: json["totalPrice"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "count": count,
        "product": product,
        "price": price,
        "totalPrice": totalPrice,
    };
}
