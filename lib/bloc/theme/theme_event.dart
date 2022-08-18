part of 'theme_bloc.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class ThemeChangeEvent extends ThemeEvent {
  bool value;
  ThemeChangeEvent({required this.value});
}

class ThemeInitEvent extends ThemeEvent {}
