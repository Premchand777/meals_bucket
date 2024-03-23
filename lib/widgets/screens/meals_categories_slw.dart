import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_bucket/data/meals_categories.dart';
import 'package:meals_bucket/providers/meals_provider.dart';
import 'package:meals_bucket/widgets/screens/category_meals_slw.dart';
import 'package:meals_bucket/widgets/widgets/meals_category_item_slw.dart';

class MealsCategoriesScreen extends ConsumerWidget {
  const MealsCategoriesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredMeals = ref.watch(filteredMealsProvider);
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
                            filteredMeals: filteredMeals,
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
