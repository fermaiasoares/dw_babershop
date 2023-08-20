import 'package:dw_babershop/src/core/ui/constants.dart';
import 'package:dw_babershop/src/features/auth/login/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;

  double get _logoAinamtionWidth => 100 * _scale;
  double get _logoAinamtionHeight => 120 * _scale;

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1.0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImagesConstanst.backgroundChair),
              fit: BoxFit.cover,
              opacity: 0.2),
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 3),
            curve: Curves.easeIn,
            opacity: _animationOpacityLogo,
            onEnd: () {
              Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                    settings: const RouteSettings(name: '/auth/login'),
                    pageBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                    ) {
                      return const LoginPage();
                    },
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    }),
                (route) => false,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(seconds: 3),
              curve: Curves.linearToEaseOut,
              width: _logoAinamtionWidth,
              height: _logoAinamtionHeight,
              child: Image.asset(
                ImagesConstanst.imageLogo,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}