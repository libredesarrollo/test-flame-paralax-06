import 'package:parallax06/components/food.dart';

bool oneLost(
    List<FoodPreSprite> levelN, int points, int eatenFood, int lostFood) {
  return false; // end game
}

List<int> levelsMinPoints = [50, 80, 100];

bool byPoints(
    List<FoodPreSprite> levelN, int points, int eatenFood, int lostFood) {
  return false; // end game
}

// solo se puede consumir un timpo de alimento
bool onlyTypeFood(List<FoodPreSprite> levelN, int points, int eatenFood,
    int lostFood, TypeFood typeFood) {
  return false; // end game
}

List<int> levelsMaxTime = [50, 80, 100]; // seconds
//
bool byTime(List<FoodPreSprite> levelN, int points, int eatenFood, int lostFood,
    TypeFood typeFood) {
  return false; // end game
}
