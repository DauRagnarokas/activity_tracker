// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bored_api_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String _$activityTypesHash() => r'ef158ea34a2e998abc607ba84b64789fc0588439';

/// See also [activityTypes].
final activityTypesProvider = AutoDisposeProvider<List<String>>(
  activityTypes,
  name: r'activityTypesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activityTypesHash,
);
typedef ActivityTypesRef = AutoDisposeProviderRef<List<String>>;
String _$getActivityHash() => r'1ed97dcfcb66700822c9bb1f64c51dac8b6e0b73';

/// See also [getActivity].
class GetActivityProvider extends AutoDisposeFutureProvider<Activity> {
  GetActivityProvider({
    required this.queryParameters,
  }) : super(
          (ref) => getActivity(
            ref,
            queryParameters: queryParameters,
          ),
          from: getActivityProvider,
          name: r'getActivityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getActivityHash,
        );

  final Map<String, dynamic> queryParameters;

  @override
  bool operator ==(Object other) {
    return other is GetActivityProvider &&
        other.queryParameters == queryParameters;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, queryParameters.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef GetActivityRef = AutoDisposeFutureProviderRef<Activity>;

/// See also [getActivity].
final getActivityProvider = GetActivityFamily();

class GetActivityFamily extends Family<AsyncValue<Activity>> {
  GetActivityFamily();

  GetActivityProvider call({
    required Map<String, dynamic> queryParameters,
  }) {
    return GetActivityProvider(
      queryParameters: queryParameters,
    );
  }

  @override
  AutoDisposeFutureProvider<Activity> getProviderOverride(
    covariant GetActivityProvider provider,
  ) {
    return call(
      queryParameters: provider.queryParameters,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'getActivityProvider';
}
