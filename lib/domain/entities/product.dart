import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? ref;
  final String? title;
  final String? description;
  final String? thumbnail;

  const Product({
    this.ref,
    this.title,
    this.description,
    this.thumbnail,
  });

  @override
  List<Object?> get props => [ref, title, description, thumbnail];

  Map<String, dynamic> toMap() {
    return {
      'ref': ref,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      ref: map['ref'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      thumbnail: map['thumbnail'] as String,
    );
  }
}
