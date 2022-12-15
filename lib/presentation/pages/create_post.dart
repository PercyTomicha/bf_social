import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../commons/validator.dart';
import '../../data/post.dart';
import '../providers/post_notifier.dart';
import '../widget/label_form_field.dart';
import '../widget/my_form_button.dart';
import '../widget/my_form_field.dart';

class CreatePost extends ConsumerStatefulWidget {
  const CreatePost({super.key});

  @override
  ConsumerState<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends ConsumerState<CreatePost> {
  final _titleController = TextEditingController();

  final _descriptionController = TextEditingController();

  final _userIdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text("Nueva Publicación"),
        centerTitle: true,
      ),
      body: SafeArea(
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const LabelFormField( text: 'Título' ),
                MyFormField(
                  controller: _titleController,
                  keyboardType: TextInputType.name,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))],
                  hintText: 'Título',
                  validator: (val) => Validators.isEmpty(val!, 'título')
                ),
                const SizedBox(height: 8),
                const LabelFormField( text: 'Descripción' ),
                MyFormField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.text,
                  hintText: 'Descripción',
                  validator: (val) => Validators.isEmpty(val!, 'descripción')
                ),
                const SizedBox(height: 8),
                const LabelFormField( text: 'UserId' ),
                MyFormField(
                  controller: _userIdController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))],
                  hintText: 'UserId',
                  validator: (val) => Validators.isEmpty(val!, 'userId')
                ),
                const Spacer(),
                MyFormButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Post post = Post(
                        id: 0,
                        title: _titleController.text,
                        body: _descriptionController.text,
                        userId: int.parse(_userIdController.text),
                      );
                      await posts.addPost(post);
                      // ignore: use_build_context_synchronously
                      context.go('/');
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Creando Post')),
                      );
                    }
                  },
                  text: 'Crear Publicación'
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}