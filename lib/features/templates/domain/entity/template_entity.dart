class TemplatesEntity {
  final List<TemplateEntity> templates;
  final int totalCount;

  TemplatesEntity(this.templates, this.totalCount);

}

class TemplateEntity {
  final String name;
  final String id;

  TemplateEntity(this.name, this.id);
}