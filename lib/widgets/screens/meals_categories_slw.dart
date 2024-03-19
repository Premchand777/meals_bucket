import 'dart:async';

import 'package:flutter/material.dart';

import 'package:meals_bucket/data/meals_categories.dart';
import 'package:meals_bucket/models/meal_model.dart';
import 'package:meals_bucket/widgets/screens/category_meals_slw.dart';
import 'package:meals_bucket/widgets/widgets/meals_category_item_slw.dart';

class MealsCategoriesScreen extends StatelessWidget {
  const MealsCategoriesScreen({
    super.key,
    required this.favoriteMeals,
    required this.addRemoveFavorites,
  });

  final List<MealModel> favoriteMeals;
  final void Function(MealModel mealDetails) addRemoveFavorites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          children: <Widget>[
            for (final mealCategory in mealsCategories)
              MealsCategoryItemSLW(
                category: mealCategory,
                onSelect: () {
                  Timer(
                    const Duration(
                      milliseconds: 200,
                    ),
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => CategoryMealsScreen(
                            mealsCategoryId: mealCategory.id,
                            favoriteMeals: favoriteMeals,
                            addRemoveFavorites: addRemoveFavorites,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
