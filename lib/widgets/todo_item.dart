import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/pages/detail_page.dart';
import 'package:todo/pages/edit_page.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.title,
    required this.time,
    required this.id,
  }) : super(key: key);
  final String id;
  final String title;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: ((context) => DetailPage(id: id)))),
      child: Card(
        child: ListTile(
          title: Text(title),
          subtitle: Text(time.toIso8601String()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PopupMenuButton(
                onSelected: (value) {
                  if (value == 'delete') {
                    BlocProvider.of<TodoBloc>(context).add(DeleteEvent(id));
                    BlocProvider.of<TodoBloc>(context).add(GetListsEvent());
                  }
                  if (value == 'edit') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => EditPage(id: id))));
                  }
                },
                tooltip: 'Options',
                itemBuilder: ((context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: const [
                            Icon(Icons.edit),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Theme.of(context).errorColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Delete',
                              style: TextStyle(
                                  color: Theme.of(context).errorColor),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
