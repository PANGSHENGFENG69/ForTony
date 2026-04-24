part of tonydemo.lib;

class HomePageVM extends ChangeNotifier {
  String _name = '';
  bool _isSkeletonLoading = false;
  HomeResponse? _dogData;

  String get name => _name;
  bool get isSkeletonLoading => _isSkeletonLoading;
  HomeResponse? get dogData => _dogData;

  set dogData(HomeResponse? val) {
    _dogData = val;
    notifyListeners();
  }

  set name(String val) {
    _name = val;
    notifyListeners(); // 更新值
  }

  set isSkeletonLoading(bool val) {
    _isSkeletonLoading = val;
    notifyListeners();
  }

  HomePageVM() {
    // init 重要的東西在這 ，比如：load 手機系統語言
  }

  HomePageBiz _biz = HomePageBiz.instance;

  void toggleOnLoading(VoidCallback setter) {
    setter();
    notifyListeners();
  }

  Future<HomeResponse?> getDogs(
    BuildContext context, {
    VoidCallback? onStart,
    VoidCallback? onFinish,
  }) async {
    var result = await _biz.getDogs(
      onStart:
          onStart ?? () => toggleOnLoading(() => _isSkeletonLoading = true),
      onFinish:
          onFinish ?? () => toggleOnLoading(() => _isSkeletonLoading = false),
    );

    if (result != null) dogData = result;

    return dogData;
  }
}
