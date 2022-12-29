import 'package:burger/domain/entities/burger.dart';

const List<Burger> tBurgers = [
  Burger(
      ref: "1",
      title: "The Big Burger",
      description: "Un classique mais tellement bon.",
      thumbnail: "https://uad.io/bigburger/images/1.png",
      price: 928.20),
  Burger(
      ref: "2",
      title: "The Big Cheese Burger",
      description: "Avec du fromage 🧀 c'est toujours meilleur.",
      thumbnail: "https://uad.io/bigburger/images/2.png",
      price: 128.30),
];

const tBurgersString = """ 
[
  {
    "ref": "1",
    "title": "The Big Burger",
    "description": "Un classique mais tellement bon.",
    "thumbnail": "https://uad.io/bigburger/images/1.png",
    "price": 92820
  },
  {
    "ref": "2",
    "title": "The Big Cheese Burger",
    "description": "Avec du fromage 🧀 c'est toujours meilleur.",
    "thumbnail": "https://uad.io/bigburger/images/2.png",
    "price": 12830
  }
]
""";
const tErrorMessageNetwork = "No internet connexion found";
const tErrorMessageServer = "Server error";
const tErrorMessageUnauthorized = "Unauthorized";
