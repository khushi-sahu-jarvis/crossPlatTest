import 'package:json_annotation/json_annotation.dart';

part 'VerifyModel.g.dart';

@JsonSerializable()

class VerifyModel{
  bool? success;
  String? message;
  VerifyModel({this.success, this.message});


  factory VerifyModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyModelFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyModelToJson(this);
}
