part of tonydemo.lib;

class HomePageBiz {
  final ApiService _apiService;

  HomePageBiz._internal() : _apiService = ApiService._instance;

  static final HomePageBiz instance = HomePageBiz._internal();

  Future<HomeResponse?> getDogs({
    required VoidCallback onStart,
    required VoidCallback onFinish,
  }) async {
    onStart();
    try {
      var result = await _apiService.getStores();
      if (result.status == APIStatus.Success.status &&
          (result.message != null && result.message?.isNotEmpty == true)) {
        return result;
      }
    } on DioException catch (e) {
      TonyTools.ErrorHandler.handleDioException(e);
    } catch (e) {
      showAlertDialog(title: "錯誤", content: e.toString(), btnText: "確認");
    } finally {
      onFinish();
    }
    return null;
  }
}
