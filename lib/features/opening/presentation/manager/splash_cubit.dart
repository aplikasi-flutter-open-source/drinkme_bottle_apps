import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startSplash() async {
    emit(SplashStart());
    await Future.delayed(Duration(seconds: 1, milliseconds: 500));
    emit(SplashFinish());
  }
}
