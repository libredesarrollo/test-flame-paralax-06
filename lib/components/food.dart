import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:parallax06/utils/helper.dart';

/* 
tipos de comidas que pudieran estar en el sprite sheet, en el 
sprite sheet de ejemplo aparecen solo dulces y pasteles
*/
enum TypeFood { bread, fruit, meat, candy, cake }

/* 
Direccion por donde debe de aparecer en la pantalla el dulce, se utiliza desde
el nivel, 

XX Se indica la posicion por donde va a aparecer
*/
// enum Direction {
//   top1,
//   top2,
//   top3,
//   right1,
//   right2,
//   bottom1,
//   bottom2,
//   bottom3,
//   left1,
//   left2
// }

// enum Food {
//   cake1,
//   candy1,
//   cake2,
//   candy2,
//   cake3,
//   cake4,
//   candy3,
//   candy4,
//   candy5
// } // sprite sheet

/* clase con las propiedades para definir un alimento/sprite por pantalla */
class Food {
  TypeFood typeFood; // tipo comida
  double chewed; // tiempo masticado ms
  Sprite sprite;

  Food({
    required this.typeFood,
    required this.chewed,
    required this.sprite,
    // required this.name
  });
}

/* 
clase empleada por los niveles para definir el tiempo de aparicion en la pantalla 
El nombre de FoodPreSprite consiste en que esta clase es utilizada para (antes/pre)
de generar el sprite de comida
*/
class FoodPreSprite {
  Food food; // comida
  double
      speed; // tiempo para aparecer en la pantalla mediante la funcion update
  SideType sideType;
  // int velocity; // velocidad de desplazamiento del sprite
  int timeToOtherFood;
  FoodPreSprite(
      {required this.food,
      required this.speed,
      required this.sideType,
      this.timeToOtherFood = 3});
}

List<Food> food = [
  // Food(typeFood: TypeFood.cake, chewed: 1),
  // Food(typeFood: TypeFood.candy, chewed: 3),
  // Food(typeFood: TypeFood.cake, chewed: 5),
  // Food(typeFood: TypeFood.cake, chewed: 2.5),
  // Food(typeFood: TypeFood.cake, chewed: 5),
  // Food(typeFood: TypeFood.candy, chewed: 5),
  // Food(typeFood: TypeFood.candy, chewed: 5),
  // Food(typeFood: TypeFood.candy, chewed: 5),
];

init() async {
  final spriteImage = await Flame.images.load('candies.png');
  final spriteSheet =
      SpriteSheet(image: spriteImage, srcSize: Vector2(512, 512));

  food = [
    Food(
        typeFood: TypeFood.cake,
        chewed: 10,
        sprite: spriteSheet.getSprite(0, 0)),
    Food(
        typeFood: TypeFood.candy,
        chewed: 3,
        sprite: spriteSheet.getSprite(0, 1)),
    Food(
        typeFood: TypeFood.cake,
        chewed: 5,
        sprite: spriteSheet.getSprite(0, 2)),
    Food(
        typeFood: TypeFood.cake,
        chewed: 2.5,
        sprite: spriteSheet.getSprite(0, 3)),
    Food(
        typeFood: TypeFood.cake,
        chewed: 5,
        sprite: spriteSheet.getSprite(1, 0)),
    Food(
        typeFood: TypeFood.candy,
        chewed: 5,
        sprite: spriteSheet.getSprite(1, 1)),
    Food(
        typeFood: TypeFood.candy,
        chewed: 5,
        sprite: spriteSheet.getSprite(1, 2)),
    Food(
        typeFood: TypeFood.candy,
        chewed: 5,
        sprite: spriteSheet.getSprite(1, 3)),
  ];
}

// cada posicion de la lista equivale a un sprite en el sprite sheet

// List<FoodPreSprite> foodLevel1 = [
//   FoodPreSprite(food: food[0], sideType: SideType.up, speed: 80),
//   FoodPreSprite(food: food[0], sideType: SideType.down, speed: 80),
//   FoodPreSprite(food: food[2], sideType: SideType.left, speed: 35),
//   FoodPreSprite(food: food[4], sideType: SideType.right, speed: 50),
//   FoodPreSprite(food: food[0], sideType: SideType.up, speed: 80),
//   FoodPreSprite(food: food[1], sideType: SideType.down, speed: 400),
//   FoodPreSprite(food: food[3], sideType: SideType.left, speed: 80),
//   FoodPreSprite(food: food[3], sideType: SideType.right, speed: 80),
// ];

// cantidad de sprite en el sprite sheet
//int foodLevel1Size = foodLevel1.length;

List<FoodPreSprite> getCurrentLevel({int level = 1}) {
  switch (level - 1) {
    case 2:
      return [
        FoodPreSprite(food: food[0], sideType: SideType.up, speed: 80),
        FoodPreSprite(food: food[0], sideType: SideType.down, speed: 80),
        FoodPreSprite(food: food[2], sideType: SideType.left, speed: 35),
        FoodPreSprite(food: food[4], sideType: SideType.right, speed: 50),
        FoodPreSprite(food: food[0], sideType: SideType.up, speed: 80),
        FoodPreSprite(food: food[1], sideType: SideType.down, speed: 400),
        FoodPreSprite(food: food[3], sideType: SideType.left, speed: 80),
        FoodPreSprite(food: food[3], sideType: SideType.right, speed: 80),
      ];
    default:
      return [
        FoodPreSprite(food: food[0], sideType: SideType.up, speed: 80),
        FoodPreSprite(food: food[0], sideType: SideType.down, speed: 80),
        FoodPreSprite(food: food[2], sideType: SideType.left, speed: 35),
        FoodPreSprite(food: food[4], sideType: SideType.right, speed: 50),
        FoodPreSprite(food: food[0], sideType: SideType.up, speed: 80),
        FoodPreSprite(food: food[1], sideType: SideType.down, speed: 400),
        FoodPreSprite(food: food[3], sideType: SideType.left, speed: 80),
        FoodPreSprite(food: food[3], sideType: SideType.right, speed: 80),
      ];
  }
}
