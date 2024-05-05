import 'dart:typed_data';

class ItemModel {
  final int ID;
  final String project_description;
  final List<Uint8List> four_image;
  final int height;
  final int width;
  final String category;
  final String position;

  ItemModel({
    required this.ID,
    required this.project_description,
    required this.four_image,
    required this.height,
    required this.width,
    required this.category,
    required this.position,
  });
}
