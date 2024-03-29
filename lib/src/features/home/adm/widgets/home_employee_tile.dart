import 'package:dw_barbearia/src/core/constants.dart';
import 'package:dw_barbearia/src/core/ui/widgets/barbearia_icons.dart';
import 'package:dw_barbearia/src/model/user_model.dart';
import 'package:flutter/material.dart';

class HomeEmployeeTile extends StatelessWidget {
  final UserModel employee;

  const HomeEmployeeTile({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorConstants.colorBrown),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: switch (employee.avatar) {
                  final avatar? => NetworkImage(avatar),
                  _ => const AssetImage(ImageConstants.avatar),
                } as ImageProvider,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/schedule',
                            arguments: employee);
                      },
                      child: const Text('AGENDAR'),
                    ),
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/employee/schedule',
                            arguments: employee);
                      },
                      child: const Text('VER AGENDA'),
                    ),
                    const Icon(
                      BarbeariaIcons.penEdit,
                      size: 16,
                      color: ColorConstants.colorBrown,
                    ),
                    const Icon(
                      BarbeariaIcons.trash,
                      size: 16,
                      color: ColorConstants.colorRed,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
