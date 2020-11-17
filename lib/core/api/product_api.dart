import 'package:kedatonkomputer/core/api/main_api.dart';
import 'package:kedatonkomputer/core/models/product_model.dart';

class ProductApi extends MainApi {
  
  Future<List<Product>> loadProducts({
    int page = 1,
    int limit = 10,
    String search = ""
  }) async {
    try {
      final response = await getRequest(
        url: "$host/user/product?page=$page&limit=$limit&search=$search",
        useAuth: true
      );
      return productResponseModelFromMap(response).product;
    } catch (error) {
      throw error;
    }
  }
  
  Future<Product> loadProductDetail({String id = "1"}) async {
    try {
      final response = await postRequest(
        url: "$host/user/product/$id",
        useAuth: true
      );
      return productFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
}