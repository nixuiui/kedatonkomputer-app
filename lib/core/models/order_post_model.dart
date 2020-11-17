import 'dart:convert';

OrderPost orderPostFromMap(String str) => OrderPost.fromMap(json.decode(str));

String orderPostToMap(OrderPost data) => json.encode(data.toMap());

class OrderPost {
    OrderPost({
        this.orderNotes,
        this.detailProducts,
    });

    String orderNotes;
    List<DetailProduct> detailProducts;

    factory OrderPost.fromMap(Map<String, dynamic> json) => OrderPost(
        orderNotes: json["orderNotes"],
        detailProducts: List<DetailProduct>.from(json["detailProducts"].map((x) => DetailProduct.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "orderNotes": orderNotes,
        "detailProducts": List<dynamic>.from(detailProducts.map((x) => x.toMap())),
    };
}

class DetailProduct {
    DetailProduct({
        this.count,
        this.product,
    });

    int count;
    String product;

    factory DetailProduct.fromMap(Map<String, dynamic> json) => DetailProduct(
        count: json["count"],
        product: json["product"],
    );

    Map<String, dynamic> toMap() => {
        "count": count,
        "product": product,
    };
}
