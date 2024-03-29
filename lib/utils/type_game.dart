import 'package:parallax06/components/food.dart';

enum StateGame { running, win, lose }

enum TypeGame { oneLost, byPoints, onlyTypeFood, notEatenThisFood }

// tipo de juego que se termina cuando el player pierde un dulce
StateGame oneLost(List<FoodPreSprite> levelN, int eatenFood, int lostFood) {
  if (lostFood >= 1) return StateGame.lose;
  if (levelN.length - 1 == eatenFood) return StateGame.win;

  return StateGame.running;
}

String oneLostMetadata() {
  return "";
}

// puntos por nivel
List<int> levelsMinPoints = [50, 80, 100];

// tipo de juego que termina cuando el player consigue una determinada cantidad de puntos
StateGame byPoints(
    List<FoodPreSprite> levelN, int points, int eatenFood, int currentLevel) {
  if (points <= levelsMinPoints[currentLevel]) return StateGame.win;
  if (levelN.length - 1 == eatenFood) return StateGame.lose;

  return StateGame.running;
}

String byPointsMetadata(int currentLevel) {
  return levelsMinPoints[currentLevel].toString();
}

// tipo de dulces que puede consumir
List<TypeFood> levelsOnlyTypeFood = [TypeFood.candy, TypeFood.cake];
// tipo de juego en el que solo se puede consumir un timpo de alimento
StateGame onlyTypeFood(
    List<FoodPreSprite> levelN, int index, int currentLevel) {
  if (levelN[index].food.typeFood != levelsOnlyTypeFood[currentLevel])
    return StateGame.lose;
  if (levelN.length - 1 == index) return StateGame.win;

  return StateGame.running; // end game
}

String onlyTypeFoodMetadata(int currentLevel) {
  return levelsOnlyTypeFood[currentLevel].toString();
}

// tipo de dulces que no puede consumir
List<TypeFood> levelsNotEatenThisFood = [TypeFood.candy, TypeFood.cake];
// tipo de juego en el que solo se puede consumir un tipo de alimento
StateGame notEatenThisFood(
    List<FoodPreSprite> levelN, int index, int currentLevel) {
  if (levelN[index].food.typeFood == levelsNotEatenThisFood[currentLevel])
    return StateGame.lose;
  if (levelN.length - 1 == index) return StateGame.win;
  return StateGame.running;
}

String notEatenThisFoodMetadata(int currentLevel) {
  return levelsNotEatenThisFood[currentLevel].toString();
}
