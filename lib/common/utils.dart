part of tonydemo.lib;

enum Tony_Api {
  Dogs(name: "取得狗資料", path: "breeds/image/random");

  final String name;
  final String path;

  const Tony_Api({required this.name, required this.path});
}

enum APIStatus {
  Success(status: "success", statusCode: 200),
  Failed(status: "failed", statusCode: 400);

  final String status;
  final int statusCode;
  const APIStatus({required this.status, required this.statusCode});
}
