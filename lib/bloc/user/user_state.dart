part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
   const UserInitial();
  
  @override
  List<Object> get props => [];
}
class UpdatedState extends UserState {
   const UpdatedState();
  
  @override
  List<Object> get props => [];
}
class NotUpdatedState extends UserState {
   const NotUpdatedState();
  
  @override
  List<Object> get props => [];
}
class DeletedState extends UserState {
   const DeletedState();
  
  @override
  List<Object> get props => [];
}
class NotDeletedState extends UserState {
   const NotDeletedState();
  
  @override
  List<Object> get props => [];
}
