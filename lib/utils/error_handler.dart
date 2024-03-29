import 'package:webspark_test_task/models/error_model.dart';
import 'package:webspark_test_task/utils/failure.dart';

class ErrorHandler {
  static Failure handleError(dynamic failure) {

    Failure fl;

    if (failure is Failure) {
      switch (failure.code) {
        
        case 500:
        case 429:
          ErrorModel? errorModel = _ser(failure);

          fl = Failure(
            errorModel?.message ?? failure.message,
            code: failure.code,
          );
          break;
        default:

        fl = Failure(
          failure.message,
          code: failure.code,
        );
      }      
    } else {
      fl = Failure(failure.toString(), code: 0);
    }
    
    return fl;
  }

  static ErrorModel? _ser(Failure failure) {
    try {
      return ErrorModel.fromJson(failure.response?.data);
    } catch (e) {
      return null;
    }
  }
}