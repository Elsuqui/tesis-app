import 'package:tesisApp/data/dto/responses/menu_response.dto.dart';
import 'package:tesisApp/data/dto/rest_response.dto.dart';
import 'package:tesisApp/data/providers/rest.interface.dart';

class MenuService {
  final IRestProvider _restProvider;
  MenuService(this._restProvider);

  Future<MenuResponseDto> requestMenu() async {
    final RestResponse response = await _restProvider.get('/menu');

    return MenuResponseDto.fromJson(response.data);
  }
}
