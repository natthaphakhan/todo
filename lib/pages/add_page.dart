import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/models/todo_model.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    var data = Todo(id: '', title: '', detail: '', time: DateTime.now());

    void submitForm() {
      form.currentState!.save();

      BlocProvider.of<TodoBloc>(context).add(AddEvent(Todo(
          id: '',
          title: data.title,
          detail: data.detail,
          time: DateTime.now())));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new'),
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
                    BlocProvider.of<TodoBloc>(context).add(GetListsEvent());
                  }),
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
