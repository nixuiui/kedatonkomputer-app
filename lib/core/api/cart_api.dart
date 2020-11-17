import 'package:flutter/material.dart';
import 'package:kedatonkomputer/core/api/main_api.dart';
import 'package:kedatonkomputer/core/models/cart_model.dart';

class CartApi extends MainApi {
  
  Future<CartModel> loadCarts() async {
    try {
      final response = await getRequest(
        url: "$host/user/cart",
        useAuth: true
      );
      print("cartModelFromMap(response)");
      print(cartModelFromMap(response));
      return cartModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }

  Future<CartModel> addToCart({
    @required String product,
    @required int quantity
  }) async {
    try {
      final response = await postRequest(
        url: "$host/user/cart",
        useAuth: true,
        body: {
          "product" : product,
          "quantity" : quantity
        }
      );
      return cartModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<CartModel> updateCartItem({
    @required String product,
    @required int quantity
  }) async {
    try {
      final response = await patchRequest(
        url: "$host/user/cart/$product",
        useAuth: true,
        body: {
          "quantity" : quantity
        }
      );
      return cartModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<CartModel> loadCart({
    @required String product,
    @required int quantity
  }) async {
    try {
      final response = await postRequest(
        url: "$host/user/cart/$product",
        useAuth: true,
        body: {"quantity" : quantity}
      );
      return cartModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }

  Future<CartModel> deleteToCart(String productId) async {
    try {
      final response = await deleteRequest(
        url: "$host/user/cart/$productId",
        useAuth: true
      );
      return cartModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
}