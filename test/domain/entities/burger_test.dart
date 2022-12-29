import 'dart:convert';

import 'package:burger/domain/entities/burger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const burgerString = """  
    {
      "ref": "1",
      "title": "The Big Burger",
      "description": "Un classique mais tellement bon.",
      "thumbnail": "https://uad.io/bigburger/images/1.png",
      "price": 92820
    } 
  """;

  test("Burger.FromMap should return Burger Object ", () {
    final result = Burger.fromMap(jsonDecode(burgerString));

    expect(
      result,
      const Burger(
        ref: "1",
        thumbnail: "https://uad.io/bigburger/images/1.png",
        title: "The Big Burger",
        description: "Un classique mais tellement bon.",
        price: 928.20,
      ),
    );
  });
}
