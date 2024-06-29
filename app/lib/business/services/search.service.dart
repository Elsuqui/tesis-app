import 'package:tesisApp/data/dto/models/product.dart';
import 'package:tesisApp/data/providers/rest.interface.dart';

class SearchService {
  final IRestProvider _restProvider;
  SearchService(this._restProvider);

  Future<List<Product>> getSearchResults(String query) async {
    final response = await _restProvider.get('/products?q=$query');
    return (response.data as List)
        .map((product) => Product.fromMap(product))
        .toList();
  }
}
