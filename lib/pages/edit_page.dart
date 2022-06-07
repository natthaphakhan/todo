import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/models/todo_model.dart';

class EditPage extends StatelessWidget {
  const EditPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodoBloc>(context).add(EditEvent(id));
    final form = GlobalKey<FormState>();

    var data = Todo(
      id: id,
      title: '',
      detail: '',
      time: DateTime.now(),
    );

    void submitForm() {
      form.currentState!.save();
      BlocProvider.of<TodoBloc>(context).add(SubmitUpdateEvent(Todo(
          id: data.id,
          title: data.title,
          detail: data.detail,
          time: DateTime.now())));
    }

    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is ItemToEditState) {
          data = Todo(
              id: id,
              title: state.data.title,
              detail: state.data.detail,
              time: state.data.time);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                  BlocProvider.of<TodoBloc>(context).add(GetListsEvent());
                },
              ),
            ),
            body: Form(
              key: form,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      initialValue: data.title,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data = Todo(
                            id: data.id,
                            title: value!,
                            detail: data.detail,
                            time: data.time);
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: const InputDecoration(labelText: 'Detail'),
                      initialValue: data.detail,
                      onSaved: (value) {
                        data = Todo(
                            id: data.id,
                            title: data.title,
                            detail: value!,
                            time: data.time);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: (() {
                          if (form.currentState!.validate() == false) {
                            return;
                          }
                          submitForm();
                          Navigator.pop(context);
                          BlocProvider.of<TodoBloc>(context)
                              .add(GetListsEvent());
                        }),
                        child: const Text('Submit'))
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
