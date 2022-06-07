import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodoBloc>(context).add(ShowDetailEvent(id));
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is DetailState) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                  BlocProvider.of<TodoBloc>(context).add(GetListsEvent());
                },
              ),
              title: Text(state.detail.title),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: SizedBox(
                    child: SelectableText(
                      state.detail.detail,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
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
