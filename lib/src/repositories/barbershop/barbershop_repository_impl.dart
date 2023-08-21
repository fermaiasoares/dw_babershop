import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:dw_babershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_babershop/src/core/fp/either.dart';
import 'package:dw_babershop/src/core/fp/nil.dart';
import 'package:dw_babershop/src/core/restClient/rest_client.dart';
import 'package:dw_babershop/src/models/barbershop_model.dart';
import 'package:dw_babershop/src/models/user_model.dart';
import 'package:dw_babershop/src/repositories/barbershop/barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient restClient;

  BarbershopRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, BarberShopModel>> getMyBarbershop(
      UserModel userModel) async {
    try {
      switch (userModel) {
        case UserModelADM():
          final Response(data: List(first: data)) = await restClient.auth.get(
            '/barbershop',
            queryParameters: {
              'user_id': '#userAuthRef',
            },
          );
          return Success(BarberShopModel.fromMap(data));

        case UserModelEmployee():
          final Response(:data) = await restClient.auth.get(
            '/barbershop/${userModel.barbershopId}',
          );
          return Success(BarberShopModel.fromMap(data));
        default:
          throw Failure(RepositoryException(message: 'Unknow user model type'));
      }
    } on DioException catch (e, s) {
      log('Erro ao buscar estabelecimento', error: e, stackTrace: s);
      return Failure(
        RepositoryException(message: 'Erro ao buscar estabelecimento'),
      );
    } on ArgumentError catch (e, s) {
      log('Invalid JSON', error: e, stackTrace: s);
      return Failure(
        RepositoryException(message: 'Invalid JSON'),
      );
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> save(
      ({
        String email,
        String name,
        List<String> openingDays,
        List<int> openingHours
      }) data) async {
    try {
      await restClient.auth.post('/barbershop', data: {
        'user_id': '#userAuthRef',
        'name': data.name,
        'email': data.email,
        'opening_days': data.openingDays,
        'opening_hours': data.openingHours,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registar barbearia', error: e, stackTrace: s);
      return Failure(
        RepositoryException(message: 'Erro ao registar barbearia'),
      );
    }
  }
}
