
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test_task/utils/api.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final Api _api = Api();

  Future<void> getDataForProcessing() => _api.getDataForProcessing();
}
