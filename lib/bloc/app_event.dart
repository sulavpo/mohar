part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class LoginEvent extends AppEvent {
  const LoginEvent(this.ctx, {required this.email, required this.password});
  final String email;
  final String password;
  final BuildContext ctx;
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LogoutEvent extends AppEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GoogleEvent extends AppEvent {
  const GoogleEvent(this.ctx);
  final BuildContext ctx;
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class InitialEvent extends AppEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RegisterEvent extends AppEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
