part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class GetListsEvent extends TodoEvent {}

class ShowDetailEvent extends TodoEvent {
  final String id;

  ShowDetailEvent(this.id);
}

class AddEvent extends TodoEvent {
  final Todo data;

  AddEvent(this.data);
}

class DeleteEvent extends TodoEvent {
  final String id;

  DeleteEvent(this.id);
}

class EditEvent extends TodoEvent {
  final String id;

  EditEvent(this.id);
}

class SubmitUpdateEvent extends TodoEvent {
  final Todo data;

  SubmitUpdateEvent(this.data);
}
