import 'package:json_annotation/json_annotation.dart';

part 'certification.g.dart';

/// Portfolio certification synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Certification {
  const Certification({
    this.id,
    required this.title,
    required this.issuer,
    required this.dateIssued,
    required this.description,
    this.thumbnail = '',
  });

  factory Certification.fromJson(Map<String, dynamic> json) =>
      _$CertificationFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String title;
  final String issuer;
  final String dateIssued;
  final String description;

  @JsonKey(defaultValue: '')
  final String thumbnail;

  Map<String, dynamic> toJson() => _$CertificationToJson(this);
}
