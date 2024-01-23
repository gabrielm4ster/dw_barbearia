import 'dart:developer';

import 'package:dw_barbearia/src/core/core/core/ui/core/ui/barbearia_icons.dart';
import 'package:dw_barbearia/src/core/core/core/ui/core/ui/widgets/barbearia_loader.dart';
import 'package:dw_barbearia/src/core/core/core/ui/core/ui/widgets/constants.dart';
import 'package:dw_barbearia/src/core/core/providers/application_providers.dart';
import 'package:dw_barbearia/src/freatures/splash/home/adm/widgets/home_adm_state.dart';
import 'package:dw_barbearia/src/freatures/splash/home/adm/widgets/home_adm_vm.dart';
import 'package:dw_barbearia/src/freatures/splash/home/adm/widgets/home_employee_tile.dart';
import 'package:dw_barbearia/src/freatures/splash/home/adm/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAdmPage extends ConsumerWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeAdmVmProvider);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: ColorConstants.colorBrown,
          onPressed: () async {
            await  Navigator.pushNamed(context,'/employee/register');
            ref.invalidate(getMeProvider);  
            ref.invalidate(homeAdmVmProvider);
          },
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 12,
            child: Icon(
              BarbeariaIcons.addEmplyeee,
              color: ColorConstants.colorBrown,
            ),
          ),
        ),
        body: homeState.when(
          data: (HomeAdmState data) {
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: HomeHeader(),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) => HomeEmployeeTile(employee: data.employees[index]),
                  childCount: data.employees.length,
                )),
              ],
            );
          },
          error: (error, stackTrace) {
            log('Erro ao carregar colaboradores',
                error: error, stackTrace: stackTrace);
            return const Center(
              child: Text('Erro ao carregar pagina '),
            );
          },
          loading: () {
            return const BarbeariaLoader();
          },
        ),
      ),
    );
  }
}