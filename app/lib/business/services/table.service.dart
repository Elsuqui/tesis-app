import 'package:tesisApp/data/dto/requests/sync_request.dto.dart';
import 'package:tesisApp/data/dto/responses/session_response.dto.dart';
import 'package:tesisApp/data/providers/rest.interface.dart';

class TableService {
  final IRestProvider _httpProvider;

  TableService(this._httpProvider);

  Future<SessionResponseDto> syncronize(
      int tableId, SyncRequestDto syncRequestDto) async {
    final response = await _httpProvider.post(
        '/tables/$tableId/sync', syncRequestDto.toJson());
    return SessionResponseDto.fromJson(response.data);
  }
}
