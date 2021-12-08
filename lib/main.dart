import 'dart:ui';

import 'package:flutter/material.dart';
import './dummy_data.dart';

import './screens/settings_screen.dart';
import './screens/meals_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './models/meal.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _settings = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favoritedMeal = [];

  void _setSettings(Map<String, bool> settingData) {
    setState(() {
      _settings = settingData;

      _availableMeals = dummyMeals.where((meal) {
        if (_settings['gluten'] as bool && !meal.isGlutenFree) {
          return false;
        }
        if (_settings['lactose'] as bool && !meal.isLactoseFree) {
          return false;
        }
        if (_settings['vegan'] as bool && !meal.isVegan) {
          return false;
        }
        if (_settings['vegetarian'] as bool && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoritedMeal.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritedMeal.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedMeal.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoritedMeal.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
      ),
      //home: const CategoriesScreen(),
      initialRoute: '/', //defult is '/'
      //We will prefere using routes when we need to controll a big app with multiple screens
      routes: {
        '/': (ctx) =>
            TabsScreen(_favoritedMeal), //replacing home ,'/'-represent home
        //giving a screen class static const rout name can be used to prevent typo errors in the future as the line below shows
        CategoryMealsScreen.routName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routName: (ctx) =>
            MealDetailScreen(_isMealFavorite, _toggleFavorite),
        SettingsScreen.routName: (ctx) =>
            SettingsScreen(_settings, _setSettings),
      },
      //when getting to a named route thats not registered in the route table
      //onGenerateRoute: (settings) {
      //   return materialPageRoute(builder: (ctx)=>CategoriesScreen());
      // },
      //onUnknownRoute reached when flutter fail to build a screen with all other metters
      //onUnknownRoute:(settings){return ...},
    );
  }
}
