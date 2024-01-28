import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbearia/src/core/barbearia_nav_global_key.dart';
import 'package:dw_barbearia/src/core/barbearia_theme.dart';
import 'package:dw_barbearia/src/core/ui/widgets/barbearia_loader.dart';
import 'package:dw_barbearia/src/features/auth/login/login_page.dart';
import 'package:dw_barbearia/src/features/auth/register/barbearia/barbearia_register_page.dart';
import 'package:dw_barbearia/src/features/auth/register/user/user_register_page.dart';
import 'package:dw_barbearia/src/features/employee/register/employee_register_page.dart';
import 'package:dw_barbearia/src/features/employee/schedule/employee_schedule_page.dart';
import 'package:dw_barbearia/src/features/employee/schedule/schedule_page.dart';
import 'package:dw_barbearia/src/features/home/adm/home_adm_page.dart';
import 'package:dw_barbearia/src/features/home/employee/home_employee_page.dart';
import 'package:dw_barbearia/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
            '/auth/register/barbearia': (_) => const BarbeariaRegisterPage(),
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
