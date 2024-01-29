class ActorModel {
  final int id;
  final String name;
  final String foto;

  ActorModel({required this.id, required this.name, required this.foto});

  factory ActorModel.fromJson(Map<String, dynamic> json) => ActorModel(
        id: json['id'],
        name: json['name'],
        foto: json['profile_path'],
      );
}
