import 'dart:developer';

import 'package:dw_barbearia/src/core/constants.dart';
import 'package:dw_barbearia/src/core/providers/application_providers.dart';
import 'package:dw_barbearia/src/core/ui/widgets/avatar_widgets.dart';
import 'package:dw_barbearia/src/core/ui/widgets/barbearia_loader.dart';
import 'package:dw_barbearia/src/features/home/adm/widgets/home_header.dart';
import 'package:dw_barbearia/src/features/home/employee/home_employee_provider.dart';
import 'package:dw_barbearia/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeEmployeePage extends ConsumerWidget {
  const HomeEmployeePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModelAsync = ref.watch(getMeProvider);

    return Scaffold(
      body: userModelAsync.when(
        error: (e, s) {
          const errorMessage = 'Erro ao carregar página';
          log(errorMessage, error: e, stackTrace: s);
          return const Center(
            child: Text(errorMessage),
          );
        },
        loading: () => const BarbeariaLoader(),
        data: (user) {
          final UserModel(:id, :name) = user;
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader(),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const AvatarWidget.withoutButton(),
                      const SizedBox(height: 24),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width * .7,
                        height: 108,
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorConstants.colorGrey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer(
                              builder: (context, ref, child) {
                                final totalAsync = ref.watch(
                                  getTotalSchedulesTodayProvider(id),
                                );

                                return totalAsync.when(
                                  error: (e, s) {
                                    const errorMessage =
                                        'Erro ao carregar total de agendamentos';
                                    return const Text(errorMessage);
                                  },
                                  loading: () => const BarbeariaLoader(),
                                  skipLoadingOnRefresh: false,
                                  data: (totalScheduule) {
                                    return Text(
                                      '$totalScheduule',
                                      style: const TextStyle(
                                        fontSize: 40,
                                        color: ColorConstants.colorBrown,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            const Text(
                              'Hoje',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorConstants.colorBrown,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          await Navigator.of(context).pushNamed(
                            '/schedule',
                            arguments: user,
                          );
                          ref.invalidate(getTotalSchedulesTodayProvider(id));
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        child: const Text('AGENDAR CLIENTE'),
                      ),
                      const SizedBox(height: 24),
                      OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            '/employee/schedule',
                            arguments: user,
                          );
                        },
                        child: const Text('VER AGENDA'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
