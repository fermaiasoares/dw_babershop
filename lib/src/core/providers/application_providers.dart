import 'package:dw_babershop/src/core/fp/either.dart';
import 'package:dw_babershop/src/core/restClient/rest_client.dart';
import 'package:dw_babershop/src/models/barbershop_model.dart';
import 'package:dw_babershop/src/models/user_model.dart';
import 'package:dw_babershop/src/repositories/barbershop/barbershop_repository.dart';
import 'package:dw_babershop/src/repositories/barbershop/barbershop_repository_impl.dart';
import 'package:dw_babershop/src/repositories/user/user_repository_impl.dart';
import 'package:dw_babershop/src/repositories/user/user_repository.dart';
import 'package:dw_babershop/src/services/user_login/user_login_service.dart';
import 'package:dw_babershop/src/services/user_login/user_login_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();

  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) =>
    BarbershopRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarberShopModel> getMyBarbershop(GetMyBarbershopRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);
  final barbershopRepository = ref.watch(barbershopRepositoryProvider);
  final result = await barbershopRepository.getMyBarbershop(userModel);

  return switch (result) {
    Success(value: final barbershop) => barbershop,
    Failure(:final exception) => throw exception
  };
}
