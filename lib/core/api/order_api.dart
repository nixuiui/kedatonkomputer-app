import 'package:kedatonkomputer/core/api/main_api.dart';
import 'package:kedatonkomputer/core/models/order_model.dart';
import 'package:kedatonkomputer/core/models/order_post_model.dart';

class OrderApi extends MainApi {
  
  Future<bool> createOrder(OrderPost data) async {
    try {
      await postRequest(
        url: "$host/user/order",
        useAuth: true,
        body: data.toMap()
      );
      return true;
    } catch (error) {
      throw error;
    }
  }
  
  Future<bool> cancelOrder({
    String id,
    String cancelReason,
  }) async {
    try {
      await patchRequest(
        url: "$host/user/order/$id",
        useAuth: true,
        body: {"cancelReason": cancelReason}
      );
      return true;
    } catch (error) {
      throw error;
    }
  }
  
  Future<bool> transactionDone(String id) async {
    try {
      await putRequest(
        url: "$host/user/order/$id",
        useAuth: true
      );
      return true;
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
      return orderResponseFromJson(response).order;
    } catch (error) {
      throw error;
    }
  }
  
  Future<bool> sendReviews({
    String rating,
    String review,
    String id
  }) async {
    try {
      await patchRequest(
        url: "$host/user/order-review/$id",
        useAuth: true,
        body: {
          "rating": rating,
          "review": review
        }
      );
      return true;
    } catch (error) {
      throw error;
    }
  }
  
}