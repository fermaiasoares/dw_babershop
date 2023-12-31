import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_babershop/src/core/exceptions/auth_exception.dart';
import 'package:dw_babershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_babershop/src/core/fp/either.dart';
import 'package:dw_babershop/src/core/fp/nil.dart';
import 'package:dw_babershop/src/core/restClient/rest_client.dart';
import 'package:dw_babershop/src/models/user_model.dart';
import 'package:dw_babershop/src/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<AuthException, String>> login(
    String email,
    String password,
  ) async {
    try {
      final Response(:data) = await restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
      });
      return Success(data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('Login ou senha inválidos', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ou realizar login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ou realizar login'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');
      return Success(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário logado', error: e, stackTrace: s);
      return Failure(
        RepositoryException(message: 'Erro ao buscar usuário logado'),
      );
    } on ArgumentError catch (e, s) {
      log('Invalid JSON', error: e, stackTrace: s);
      return Failure(
        RepositoryException(message: e.message),
      );
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String email, String name, String password}) userData) async {
    try {
      await restClient.unAuth.post('/users', data: {
        'name': userData.name,
        'password': userData.password,
        'email': userData.email,
        'profile': 'ADM'
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao registrar usuário'));
    }
  }
}
