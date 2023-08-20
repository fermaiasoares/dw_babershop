import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_babershop/src/core/exceptions/auth_exception.dart';
import 'package:dw_babershop/src/core/fp/either.dart';
import 'package:dw_babershop/src/core/restClient/rest_client.dart';
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
      final Response(:data) =
          await restClient.unAuth.post('/auth', data: {email, password});
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
}
