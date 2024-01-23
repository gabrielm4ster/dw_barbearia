
import 'package:dw_barbearia/src/core/core/core/ui/core/ui/barbearia_icons.dart';
import 'package:dw_barbearia/src/core/core/core/ui/core/ui/widgets/barbearia_loader.dart';
import 'package:dw_barbearia/src/core/core/core/ui/core/ui/widgets/constants.dart';
import 'package:dw_barbearia/src/core/core/providers/application_providers.dart';
import 'package:dw_barbearia/src/freatures/splash/home/adm/widgets/home_adm_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerWidget {
  final bool showFilter;

  const HomeHeader({super.key}) : showFilter = true;
  const HomeHeader.withoutFilter({super.key}) : showFilter = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbearia = ref.watch(getMyBarbeariaProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 16),
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        image: DecorationImage(
          image: AssetImage(
            ImageConstants.backgroundChair,
          ),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          barbearia.maybeWhen(
            data: (barbeariaData) {
              return Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xffbdbdbd),
                    child: SizedBox.shrink(),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Text(
                      barbeariaData.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Expanded(
                    child: Text(
                      'editar',
                      style: TextStyle(
                        color: ColorConstants.colorBrown,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(homeAdmVmProvider.notifier).logout();
                    },
                    icon: const Icon(
                      BarbeariaIcons.exit,
                      color: ColorConstants.colorBrown,
                      size: 32,
                    ),
                  )
                ],
              );
            },
            orElse: () {
              return const Center(
                child: BarbeariaLoader(),
              );
            },
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Bem Vindo',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Agenda um Cliente',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 32,
            ),
          ),
          Offstage(
            offstage: !showFilter,
            child: const SizedBox(
              height: 24,
            ),
          ),
          Offstage(
            offstage: !showFilter,
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text('Buscar Colaborador'),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 24.0),
                  child: Icon(
                    BarbeariaIcons.search,
                    color: ColorConstants.colorBrown,
                    size: 26,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}