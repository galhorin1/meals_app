import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

//import 'package:meals_app/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CategoryItem({
    Key? key,
    required this.id,
    required this.title,
    required this.color,
  }) : super(key: key);

//here we use navigaor to push new screen to our stack (not useing map of routes)
  // void SelectCategory(BuildContext ctx) {
  //   Navigator.of(ctx).push(
  //     MaterialPageRoute(
  //       builder: (_) {
  //         return CategoryMealsScreen(
  //           categoryTitle: title,
  //           categoryId: id,
  //         );
  //       },
  //     ),
  //   );
  // }

  //using pushNamed and setting args
  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      //here we are using the category meal screen static route name we set for preventing typo errors
      CategoryMealsScreen.routName,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    //inkwell used to make categorys tapable and respond to a tap
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
