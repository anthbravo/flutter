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
      baseUrl: 'https://run.mocky.io/v3/bdfb8a43-4272-49d3-8df5-d5f5a95dfa43',
      services: [
        _$MarksService(),
      ],
    );
    return _$MarksService(chopperClient);
  }
}
