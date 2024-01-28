import 'package:flutter/material.dart';

class BarbeariaNavGlobalKey {
  static BarbeariaNavGlobalKey? _instance;
  final navKey = GlobalKey<NavigatorState>();
 
  // Avoid self instance
  BarbeariaNavGlobalKey._();
  static BarbeariaNavGlobalKey get instance =>
    _instance ??= BarbeariaNavGlobalKey._();

}