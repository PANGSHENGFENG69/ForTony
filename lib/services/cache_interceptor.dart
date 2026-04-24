part of tonydemo.lib;

class CacheInterceptor extends Interceptor {
  final DioCacheInterceptor _inner = DioCacheInterceptor(
    options: CacheOptions(
      store: MemCacheStore(),
      maxStale: const Duration(minutes: 10),
    ),
  );

  @override
  void onRequest(RequestOptions o, RequestInterceptorHandler h) =>
      _inner.onRequest(o, h);

  @override // 少了這個，cache 不會被寫入
  void onResponse(Response r, ResponseInterceptorHandler h) =>
      _inner.onResponse(r, h);

  @override // 少了這個，offline 時不會回傳 cache
  void onError(DioException e, ErrorInterceptorHandler h) =>
      _inner.onError(e, h);
}
