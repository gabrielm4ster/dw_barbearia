import 'package:dw_barbearia/src/core/core/core/ui/core/ui/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BarbeariaLoader extends StatelessWidget {
  const BarbeariaLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: ColorConstants.colorBrown,
        size: 60,
      ),
    );
  }
}