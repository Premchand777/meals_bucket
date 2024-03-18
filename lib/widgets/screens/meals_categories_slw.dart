import 'dart:async';

import 'package:flutter/material.dart';

import 'package:meals_bucket/data/meals_categories.dart';
import 'package:meals_bucket/widgets/screens/category_meals_slw.dart';
import 'package:meals_bucket/widgets/widgets/meals_category_item_slw.dart';

class MealsCategoriesScreen extends StatelessWidget {
  const MealsCategoriesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals Category'),
      ),
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
                      milliseconds: 80,
                    ),
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => CategoryMealsScreen(
                            mealsCategory: mealCategory.id,
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
