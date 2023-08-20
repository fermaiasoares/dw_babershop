import 'package:dw_babershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_babershop/src/core/fp/either.dart';
import 'package:dw_babershop/src/models/barbershop_model.dart';
import 'package:dw_babershop/src/models/user_model.dart';

abstract interface class BarbershopRepository {
  Future<Either<RepositoryException, BarberShopModel>> getMyBarbershop(
    UserModel userModel,
  );
}
