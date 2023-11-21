import 'package:dio/dio.dart';
import 'package:freezed_bloc/models/post/post.dart';
import 'package:retrofit/retrofit.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class Api_Service {
  factory Api_Service(Dio dio) = _Api_Service;

  @GET('/posts')
  Future<List<Post>> getPosts();
}