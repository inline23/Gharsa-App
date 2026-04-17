import '../models/product_model.dart';
import '../models/user_model.dart';

class ApiService {
  // Dummy service simulating network requests
  
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    if (email.isNotEmpty && password.isNotEmpty) {
      return UserModel(
        id: '1',
        name: 'John Doe',
        email: email,
      );
    }
    throw Exception('Invalid credentials');
  }

  Future<List<ProductModel>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return [
      const ProductModel(id: '1', title: 'Product 1', price: 10.0, imageUrl: 'https://via.placeholder.com/150'),
      const ProductModel(id: '2', title: 'Product 2', price: 20.0, imageUrl: 'https://via.placeholder.com/150'),
      const ProductModel(id: '3', title: 'Product 3', price: 30.0, imageUrl: 'https://via.placeholder.com/150'),
    ];
  }
}
