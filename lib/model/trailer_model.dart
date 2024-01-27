class TrailerModel {
  final String key;

  TrailerModel({required this.key});

  factory TrailerModel.fromJson(Map<String, dynamic> json) =>
      TrailerModel(key: json['key']);
}
