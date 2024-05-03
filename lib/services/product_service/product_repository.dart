abstract class ProductRepository {
  getAllProducts();

  getSingleProducts(String id);

  getAllCategories();

  getSingleCart(String userId);

  addToCart(Map<String, dynamic> data);
}
