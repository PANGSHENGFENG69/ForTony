part of tonydemo.lib;

enum TonyTools { Screen, ErrorHandler, Helper }

extension Tools on TonyTools {
  Future<String> handleDioException(DioException e) async {
    final url = e.requestOptions.baseUrl;
    final path = e.requestOptions.path;
    final data = e.response?.data;
    List<String> errorMessages = [];

    void extractMessages(dynamic value) {
      if (value == null) return;
      if (value is String) {
        if (value.trim().isNotEmpty) errorMessages.add(value.trim());
      } else if (value is List) {
        for (final item in value) {
          extractMessages(item);
        }
      } else if (value is Map) {
        for (final entry in value.entries) {
          if (entry.key.toString().toLowerCase() == 'status') continue;
          extractMessages(entry.value);
        }
      }
    }

    if (data is String) {
      errorMessages.add(
        "伺服器回應錯誤，狀態碼：${e.response?.statusCode ?? '未知'} - $data",
      );
    } else if (data != null) {
      extractMessages(data);
    }

    var message = errorMessages.isNotEmpty
        ? errorMessages.join("\n")
        : "伺服器回應錯誤，狀態碼：${e.response?.statusCode ?? '未知'}";

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        LogHelper.writeLog("${url + path}:Connection Timeout");
        await showAlertDialog(
          content: "連線逾時，請檢查您的網路連線。",
          btnText: "確認",
          title: "錯誤",
        );

        // Handle connection timeout
        break;
      case DioExceptionType.sendTimeout:
        LogHelper.writeLog("${url + path}:Send Timeout");
        await showAlertDialog(
          content: "請求發送超時，請稍後再試。",
          btnText: "確認",
          title: "錯誤",
        );

        // Handle send timeout
        break;
      case DioExceptionType.receiveTimeout:
        LogHelper.writeLog("${url + path}:Receive Timeout");
        await showAlertDialog(
          content: "伺服器回應逾時，請稍後再試。",
          btnText: "確認",
          title: "錯誤",
        );

        // Handle receive timeout
        break;
      case DioExceptionType.badResponse:
      case DioExceptionType.connectionError:
        final statusCode = e.response?.statusCode;

        if (statusCode == 500) {
          message = "連線過於頻繁，請等待一分鐘後再重新嘗試。";
        }

        LogHelper.writeLog(
          "${url + path}:Response Error: ${statusCode},Message:${message}",
        );
        await showAlertDialog(content: message, btnText: "確認", title: "錯誤");

        break;
      case DioExceptionType.cancel:
        LogHelper.writeLog("${url + path}:Request Cancelled");
        await showAlertDialog(content: "請求已取消。", btnText: "確認", title: "錯誤");

        // Handle cancellation

        break;
      case DioExceptionType.unknown:
        LogHelper.writeLog("${url + path}:Other Error: ${e.message}");
        await showAlertDialog(
          content: "發生未知錯誤：${e.message}。",
          btnText: "確認",
          title: "錯誤",
        );

        // Handle other errors
        break;

      default:
    }
    return message;
  }
}

class LogHelper {
  static void writeLog(logContent) {
    try {
      if (kDebugMode) {
        if (logContent is String) {
          dev.log(logContent);
        } else {
          dev.log(logContent.toString());
        }
      }
      if (kReleaseMode) {
        if (logContent is String) {
          debugPrint(logContent);
        } else {
          debugPrint(logContent.toString());
        }
      }
    } catch (e) {
      dev.log('LogHelper.writeLog error: $e');
    }
  }
}
