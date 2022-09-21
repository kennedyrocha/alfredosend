import 'package:sendify/features/templates/domain/entity/template_entity.dart';

class TemplateModel extends TemplateEntity {
  TemplateModel(String name, String id) : super(name, id);

  factory TemplateModel.fromJson(Map<String, dynamic> json) {
    return TemplateModel(json['name'], json['id']);
  }

}