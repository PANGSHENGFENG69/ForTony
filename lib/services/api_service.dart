part of tonydemo.lib;

abstract interface class IApiService {
  Future<HomeResponse> getStores();
}

class ApiService implements IApiService {
  @override
  Future<HomeResponse> getStores() async {
    var remoteResult = await apiClient.get(Tony_Api.Dogs.path);
    LogHelper.writeLog(remoteResult.data["message"]);
    return HomeResponse.fromJson(remoteResult.data);
  }

  ApiService._privateConstructor();

  static final ApiService _instance = ApiService._privateConstructor();

  static ApiService get instance => _instance;

  ApiClient apiClient = ApiClient(
    baseUrl: "https://dog.ceo/api/",
    getToken: () => "", //到時候在看怎樣 丟進來
  );
}
