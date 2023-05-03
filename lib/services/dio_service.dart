import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioClientProvider = Provider<Dio>((_) => Dio());

final dioServiceProvider = Provider<DioService>(
      (ref) => DioService(read: ref.read),
);

class DioService {
  final Function(ProviderListenable) read;

  DioService({required this.read});

  Future<T> getData<T>({
    required String path,
    required T Function(dynamic data) builder,
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response = await read(dioClientProvider).get(
      path,
      queryParameters: queryParameters,
    );
    if(response.data['error'] != null) {
      throw Exception(response.data['error']);
    }
    return builder(response.data);
  }
}
