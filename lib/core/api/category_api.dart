import 'package:kedatonkomputer/core/api/main_api.dart';
import 'package:kedatonkomputer/core/models/category_model.dart';

class CategoryApi extends MainApi {
  
  Future<List<Category>> loadCategory() async {
    try {
      final response = await postRequest(
        url: "$host/user/category",
        useAuth: true
      );
      return categoryResponseModelFromMap(response).category;
    } catch (error) {
      throw error;
    }
  }
  
}