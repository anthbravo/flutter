//
import 'package:chopper/chopper.dart';
import 'package:maps/dtos/marks_response_dto.dart';

part 'marks_service.chopper.dart';

@ChopperApi()
abstract class MarksService extends ChopperService {
  @Get(path: '')
  Future<Response> getMarks();

  static MarksService create() {
    final chopperClient = ChopperClient(
      interceptors: [HttpLoggingInterceptor()],
      converter: JsonConverter(),
      errorConverter: JsonConverter(),
      baseUrl: 'https://run.mocky.io/v3/0e302b39-ef0d-49a3-a43d-087159335917',
      services: [
        _$MarksService(),
      ],
    );
    return _$MarksService(chopperClient);
  }
}
