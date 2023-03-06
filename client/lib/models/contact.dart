import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Contact {
  Contact({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
  });

  final String? id;
  final String? name;
  final String? address;
  final String? phoneNumber;

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
