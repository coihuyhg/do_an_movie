import 'package:json_annotation/json_annotation.dart';

part 'cast_response.g.dart';

@JsonSerializable()
class CastResponse {
  List<Cast>? cast;

  CastResponse(this.cast);

  factory CastResponse.fromJson(Map<String, dynamic> json) =>
      _$CastResponseFromJson(json);
}

@JsonSerializable()
class Cast {
  String? name;
  @JsonKey(name: "profile_path")
  String? profilePath;
  String? character;

  Cast({this.name, this.profilePath, this.character});

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
}