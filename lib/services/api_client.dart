part of tonydemo.lib;

class ApiClient {
  final Dio dio;

  ApiClient({required String baseUrl, required String? Function() getToken})
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    final retryInterceptor = NetworkRetryInterceptor(dio);
    dio.interceptors.addAll([
      AuthInterceptor(getToken), // token 自動注入
      retryInterceptor, // 網路重試
      CacheInterceptor(), // GET 快取
    ]);
  }

  Future<Response> get(String path, {Map<String, dynamic>? params}) =>
      dio.get(path, queryParameters: params);

  Future<Response> post(String path, dynamic data) =>
      dio.post(path, data: data);

  Future<Response> put(String path, dynamic data) => dio.put(path, data: data);

  Future<Response> patch(String path, dynamic data) =>
      dio.patch(path, data: data);

  Future<Response> delete(String path) => dio.delete(path);
}
