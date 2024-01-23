// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$restClientHash() => r'0ee58f1fd102b2016ed621885f1e8d52ed00da66';

/// See also [restClient].
@ProviderFor(restClient)
final restClientProvider = Provider<RestClient>.internal(
  restClient,
  name: r'restClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$restClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RestClientRef = ProviderRef<RestClient>;
String _$userRepositoryHash() => r'4a324f69804b6738f220b7c48b19aad627021894';

/// See also [userRepository].
@ProviderFor(userRepository)
final userRepositoryProvider = Provider<UserRepository>.internal(
  userRepository,
  name: r'userRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRepositoryRef = ProviderRef<UserRepository>;
String _$userLoginServiceHash() => r'62431221aac8e45888e74928ecf0b5836e72b999';

/// See also [userLoginService].
@ProviderFor(userLoginService)
final userLoginServiceProvider = Provider<UserLoginService>.internal(
  userLoginService,
  name: r'userLoginServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userLoginServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserLoginServiceRef = ProviderRef<UserLoginService>;
String _$getMeHash() => r'835de91f459d1216fe7813de1ce4ffa8c28975d4';

/// See also [getMe].
@ProviderFor(getMe)
final getMeProvider = FutureProvider<UserModel>.internal(
  getMe,
  name: r'getMeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getMeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMeRef = FutureProviderRef<UserModel>;
String _$barbeariaRepositoryHash() =>
    r'802f77a6c168df283b2c0e54779b606087f3a4c7';

/// See also [barbeariaRepository].
@ProviderFor(barbeariaRepository)
final barbeariaRepositoryProvider = Provider<BarbeariaRepository>.internal(
  barbeariaRepository,
  name: r'barbeariaRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$barbeariaRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BarbeariaRepositoryRef = ProviderRef<BarbeariaRepository>;
String _$getMyBarbeariaHash() => r'2582f6d11bbd631935d86722fac22931ee14478c';

/// See also [getMyBarbearia].
@ProviderFor(getMyBarbearia)
final getMyBarbeariaProvider = FutureProvider<BarbeariaModel>.internal(
  getMyBarbearia,
  name: r'getMyBarbeariaProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getMyBarbeariaHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMyBarbeariaRef = FutureProviderRef<BarbeariaModel>;
String _$logoutHash() => r'4fe8cdf7ee6a9d8ca6e306adb4764250bc066736';

/// See also [logout].
@ProviderFor(logout)
final logoutProvider = AutoDisposeFutureProvider<void>.internal(
  logout,
  name: r'logoutProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LogoutRef = AutoDisposeFutureProviderRef<void>;
String _$scheduleRepositoryHash() =>
    r'd8bb90e09ddffd4926259e9e2ec796a76739a37d';

/// See also [scheduleRepository].
@ProviderFor(scheduleRepository)
final scheduleRepositoryProvider =
    AutoDisposeProvider<ScheduleRepository>.internal(
  scheduleRepository,
  name: r'scheduleRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$scheduleRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ScheduleRepositoryRef = AutoDisposeProviderRef<ScheduleRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
