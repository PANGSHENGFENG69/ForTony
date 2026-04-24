part of tony_demo.res.lib;

@JsonSerializable()
class HomeResponse {
  String? message;
  String? status;

  HomeResponse({this.message, this.status});

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}
