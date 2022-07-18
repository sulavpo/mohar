part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UpdateEvent extends UserEvent {
  const UpdateEvent({required this.type, required this.input});
  final String type;
  final TextEditingController input;
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AddressUpdateEvent extends UserEvent {
  const AddressUpdateEvent(
      {required this.input1,
      required this.type,
      required this.input2,
      required this.input3});
  final TextEditingController input1;
  final String type;
  final TextEditingController input2;
  final TextEditingController input3;
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class DeleteEvent extends UserEvent {
  const DeleteEvent({required this.type});
  final String type;
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
