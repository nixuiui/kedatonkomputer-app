import 'package:kedatonkomputer/core/api/main_api.dart';
import 'package:kedatonkomputer/core/models/order_model.dart';
import 'package:kedatonkomputer/core/models/order_post_model.dart';

class OrderApi extends MainApi {
  
  Future<OrderModel> createOrder(OrderPost data) async {
    try {
      final response = await postRequest(
        url: "$host/user/order",
        useAuth: true,
        body: data.toMap()
      );
      return orderModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<OrderModel> cancelOrder({
    String id,
    String cancelReason,
  }) async {
    try {
      final response = await patchRequest(
        url: "$host/user/order/$id",
        useAuth: true,
        body: {"cancelReason": cancelReason}
      );
      return orderModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<OrderModel> transactionDone(String id) async {
    try {
      final response = await patchRequest(
        url: "$host/user/order/$id",
        useAuth: true
      );
      return orderModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<OrderModel> detailOrder(String id) async {
    try {
      final response = await getRequest(
        url: "$host/user/order/$id",
        useAuth: true
      );
      return orderModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<List<OrderModel>> getOrders({
    String page = "1",
    String limit = "10",
    String status = ""
  }) async {
    try {
      final response = await getRequest(
        url: "$host/user/order?page=$page&limit=$limit&status=$status",
        useAuth: true
      );
      return ordersModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<OrderModel> sendReviews({
    String rating,
    String review,
    String id
  }) async {
    try {
      final response = await patchRequest(
        url: "$host/user/order-review/$id",
        useAuth: true,
        body: {
          "rating": rating,
          "review": review
        }
      );
      return orderModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
}