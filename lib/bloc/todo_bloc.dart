import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/models/todo_model.dart' as todo;

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    final db = FirebaseFirestore.instance;

    Future getData() async {
      await db.collection("todo").get().then((event) {
        List<Todo> temp = [];
        for (var doc in event.docs) {
          temp.add(Todo(
            id: doc.id,
            title: doc.data()['title'],
            detail: doc.data()['detail'],
            time: doc.data()['time'].toDate(),
          ));
        }
        todo.list = temp;
      });
    }

    Future addData(Todo data) async {
      final setData = <String, dynamic>{
        "title": data.title,
        "detail": data.detail,
        "time": data.time
      };

      await db.collection("todo").add(setData);
    }

    Future updateData(Todo updateData) async {
      await db.collection('todo').doc(updateData.id).update({
        'title': updateData.title,
        'detail': updateData.detail,
        'time': updateData.time
      });
    }

    Future deleteData(String id) async {
      await db.collection('todo').doc(id).delete();
    }

// ------------------------------------------------------------------------

    on<GetListsEvent>((event, emit) async {
      await getData();
      emit(ListsState(todo.list));
    });

    on<ShowDetailEvent>((event, emit) {
      final getDetail =
          todo.list.indexWhere((element) => element.id == event.id);
      final detail = todo.list[getDetail];
      emit(DetailState(detail));
    });

    on<AddEvent>((event, emit) async {
      await addData(event.data);
    });

    on<DeleteEvent>((event, emit) async {
      todo.list.removeWhere((element) => event.id == element.id);
      await deleteData(event.id);
    });

    on<EditEvent>((event, emit) {
      final getItemToEdit =
          todo.list.indexWhere((element) => element.id == event.id);
      final item = todo.list[getItemToEdit];
      emit(ItemToEditState(item));
    });

    on<SubmitUpdateEvent>((event, emit) async {
      await updateData(event.data);
    });
  }
}
