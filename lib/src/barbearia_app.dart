import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbearia/src/core/core/core/ui/barbearia_nav_global_key.dart';
import 'package:dw_barbearia/src/core/core/core/ui/core/ui/widgets/barbearia_loader.dart';
import 'package:dw_barbearia/src/core/core/core/ui/core/ui/widgets/barbearia_theme.dart';
import 'package:dw_barbearia/src/freatures/employee/register/employee_register_page.dart';
import 'package:dw_barbearia/src/freatures/employee/register/schedule/employee_schedule_page.dart';
import 'package:dw_barbearia/src/freatures/employee/register/schedule/schedule_page.dart';
import 'package:dw_barbearia/src/freatures/splash/auth/login/login_page.dart';
import 'package:dw_barbearia/src/freatures/splash/auth/login/register/user/barbearia/barbearia_register_page.dart';
import 'package:dw_barbearia/src/freatures/splash/auth/login/register/user/user_register_page.dart';
import 'package:dw_barbearia/src/freatures/splash/home/adm/home_adm_page.dart';
import 'package:dw_barbearia/src/freatures/splash/home/employee/home_employee_page.dart';
import 'package:dw_barbearia/src/freatures/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbeariaApp extends StatelessWidget {
  const BarbeariaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarbeariaLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DW Barbearia',
          theme: BarbeariaTheme.themeData,
          navigatorObservers: [asyncNavigatorObserver],
          navigatorKey: BarbeariaNavGlobalKey.instance.navKey,
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
            '/auth/register/user': (_) => const UserRegisterPage(),
            '/auth/register/barebershop': (_) => const BarbeariaRegisterPage(),
            '/home/adm': (_) => const HomeAdmPage(),
            '/home/employee': (_) => const HomeEmployeePage(),
            '/employee/register': (_) => const EmployeeRegisterPage(),
            '/employee/schedule': (_) => const EmployeeSchedulePage(),
            '/schedule': (_) => const SchedulePage(),
          },
          locale: const Locale('pt', 'BR'),
          supportedLocales: const [Locale('pt', 'BR')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}