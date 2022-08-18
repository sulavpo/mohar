import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitState()) {
    on<ThemeInitEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final isDark = await prefs.getBool('switch') ?? false;
      emit(ThemeState(isDark: isDark));
    });

    on<ThemeChangeEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("switch", event.value);
      emit(state.copyWith(isDark: event.value));
    });
  }
}
