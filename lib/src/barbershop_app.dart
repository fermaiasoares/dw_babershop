import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_babershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:dw_babershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_babershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_babershop/src/features/auth/login/login_page.dart';
import 'package:dw_babershop/src/features/register/barbershop/barbershop_register_page.dart';
import 'package:dw_babershop/src/features/register/user/user_register_page.dart';
import 'package:dw_babershop/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
        customLoader: const BarbershopLoader(),
        builder: (asyncNavigatorObserver) {
          return MaterialApp(
            title: 'Baber Shop',
            theme: BarbershopTheme.themeData,
            navigatorObservers: [asyncNavigatorObserver],
            navigatorKey: BarbershopNavGlobalKey.instance.navKey,
            routes: {
              '/': (_) => const SplashPage(),
              '/auth/login': (_) => const LoginPage(),
              '/auth/register/user': (_) => const UserRegisterPage(),
              '/auth/register/barbershop': (_) =>
                  const BarbershopRegisterPage(),
              '/home/adm': (_) => const Text('ADM'),
              '/home/employee': (_) => const Text('Employee'),
            },
          );
        });
  }
}
