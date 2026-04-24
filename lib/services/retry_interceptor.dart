part of tonydemo.lib;

class NetworkRetryInterceptor extends Interceptor {
  final RetryInterceptor _inner;

  NetworkRetryInterceptor(Dio dio)
    : _inner = RetryInterceptor(
        dio: dio,
        logPrint: LogHelper.writeLog,
        retries: 3,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
      );

  @override
  void onRequest(RequestOptions o, RequestInterceptorHandler h) =>
      _inner.onRequest(o, h);

  @override
  void onResponse(Response r, ResponseInterceptorHandler h) =>
      _inner.onResponse(r, h);

  @override
  void onError(DioException e, ErrorInterceptorHandler h) =>
      _inner.onError(e, h);
}
