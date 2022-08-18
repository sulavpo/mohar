part of 'theme_bloc.dart';

class ThemeState {
  final bool isDark;
  ThemeState({this.isDark = false});

  ThemeState copyWith({required bool isDark}) {
    return ThemeState(
      isDark: isDark,
    );
  }

  // @override
  // List<Object> get props => [isDark];
}

class ThemeInitState extends ThemeState {}
