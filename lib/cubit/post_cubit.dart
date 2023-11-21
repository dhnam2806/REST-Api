import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:freezed_bloc/models/post/post.dart';
import 'package:freezed_bloc/service/api_service.dart';
part 'post_state.dart';
part 'post_cubit.freezed.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostState.initial());

  getPosts() {
    final service = Api_Service(Dio(BaseOptions(contentType: 'application/json')));
    try {
      emit(PostState.loading());
      service.getPosts().then((posts) {
        emit(PostState.loaded(posts));
      });
    } catch (e) {
      emit(PostState.error());
    }
  }

}
