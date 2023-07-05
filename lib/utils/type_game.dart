import 'package:parallax06/components/food.dart';

enum StateGame { running, win, lose }

// tipo de juego que se termina cuando el player pierde un dulce
StateGame oneLost(List<FoodPreSprite> levelN, int eatenFood, int lostFood) {
  if (lostFood >= 1) return StateGame.lose;
  if (levelN.length - 1 == eatenFood) return StateGame.win;

  return StateGame.running;
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

List<int> levelsMaxTime = [50, 80, 100]; // seconds

// tipo de juego en el que solo se puede consumir un timpo de alimento
StateGame byTime(
    List<FoodPreSprite> levelN, int points, int eatenFood, int lostFood) {
  return StateGame.running; // end game
}
