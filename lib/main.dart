import 'package:flutter/material.dart';
import 'package:freezed_bloc/cubit/post_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => PostCubit(),
        child: Post(),
      ),
    );
  }
}

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    getPost() {
      context.read<PostCubit>().getPosts();
    }

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PostCubit, PostState>(
          bloc: context.read<PostCubit>(),
          builder: (context, state) {
            return state.when(
                initial: () => ElevatedButton(
                      onPressed: () {
                        getPost();
                      },
                      child: Text('Get Posts'),
                    ),
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                error: () => ElevatedButton(
                      onPressed: () {
                        getPost();
                      },
                      child: Text('Tap to Retry'),
                    ),
                loaded: (posts) => ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(posts[index].title),
                          subtitle: Text(posts[index].body),
                        );
                      },
                    ));
          },
        ),
      ),
    );
  }
}
