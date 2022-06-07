import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/pages/add_page.dart';
import 'package:todo/widgets/todo_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodoBloc>(context).add(GetListsEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: [
          IconButton(
            tooltip: 'Add new',
            onPressed: (() => Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const AddPage())))),
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: (() {
              showDialog(
                context: context,
                builder: (context) => const Dialog(),
              );
            }),
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is ListsState) {
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: ((context, index) {
                return TodoItem(
                  title: state.list[index].title,
                  time: state.list[index].time,
                  id: state.list[index].id,
                );
              }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class Dialog extends StatelessWidget {
  const Dialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'This app uses Bloc and Firestore',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Image.network(
            'https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/bloc_logo_full.png',
            width: 200,
          ),
          const SizedBox(height: 30),
          Image.network(
            'https://www.4xtreme.com/wp-content/uploads/2020/11/logo-standard.png',
            width: 200,
          ),
          const SizedBox(height: 30),
          const Text(
            'Developed by Natthaphakhan',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
