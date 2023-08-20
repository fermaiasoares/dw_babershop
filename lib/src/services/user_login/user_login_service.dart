import 'package:dw_babershop/src/core/exceptions/service_exception.dart';
import 'package:dw_babershop/src/core/fp/either.dart';
import 'package:dw_babershop/src/core/fp/nil.dart';

abstract interface class UserLoginService {
  Future<Either<ServiceException, Nil>> execute(String email, String password);
}
