import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/features/home/blocs/create_post_bloc/create_post_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';

class PostScreen extends StatefulWidget {
  final MyUser myUser;
  final VoidCallback? onPostCreated;
  const PostScreen(this.myUser, {super.key, this.onPostCreated});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late Post post;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    post = Post.empty;
    post = post.copyWith(myUser: widget.myUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePostBloc, CreatePostState>(
      listener: (context, state) {
        if (state is CreatePostSuccess) {
          // Call the callback to refresh posts
          widget.onPostCreated?.call();
          Navigator.pop(context);
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                setState(() {
                  post = post.copyWith(post: _controller.text);
                });
                context.read<CreatePostBloc>().add(CreatePost(post));
              }
            },
            child: const Icon(CupertinoIcons.share),
          ),
          appBar: AppBar(
            elevation: 0,
            foregroundColor: Colors.white,
            title: const Text('Create a Post !'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                maxLines: 10,
                maxLength: 500,
                decoration: InputDecoration(
                  hintText: "Enter Your Post Here...",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
