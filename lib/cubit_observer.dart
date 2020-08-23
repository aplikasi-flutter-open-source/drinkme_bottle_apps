import 'package:bloc/bloc.dart';

class CubitObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    print('CUBITOBSERVER ${cubit.runtimeType} $change');
    super.onChange(cubit, change);
  }
}
