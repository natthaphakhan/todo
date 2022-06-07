part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class ListsState extends TodoState {
  final List<Todo> list;

  ListsState(this.list);
}

class DetailState extends TodoState {
  final Todo detail;

  DetailState(this.detail);
}

class ItemToEditState extends TodoState {
  final Todo data;

  ItemToEditState(this.data);
}
