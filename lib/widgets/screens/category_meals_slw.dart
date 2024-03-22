import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_bucket/data/meals_categories.dart';
import 'package:meals_bucket/models/meal_model.dart';
import 'package:meals_bucket/widgets/screens/meal_details_sfw.dart';

import 'package:meals_bucket/providers/meals_provider.dart';

class CategoryMealsScreen extends ConsumerWidget {
  const CategoryMealsScreen({
    super.key,
    this.mealsCategoryId,
    required this.filteredMeals,
  });

  final String? mealsCategoryId;
  final List<MealModel> filteredMeals;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<MealModel> categoryMeals = [];
    if (mealsCategoryId != null) {
      List<MealModel> mealsCopy =
          filteredMeals.isNotEmpty ? filteredMeals : ref.read(mealsProvider);
      for (final meal in mealsCopy) {
        if (meal.categories.contains(mealsCategoryId)) {
          categoryMeals.add(meal);
        }
      }
    } else {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      categoryMeals = favoriteMeals;
    }

    final Widget bodyContent;

    if (categoryMeals.isNotEmpty) {
      bodyContent = ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (ctx, index) {
          return Container(
            height: 200,
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                image: NetworkImage(
                  categoryMeals[index].imageUrl,
                ),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.black12,
                      onTap: () {
                        // time interval of 2 seconds
                        Timer(
                          const Duration(
                            milliseconds: 200,
                          ),
                          () {
                            Navigator.of(ctx).push(
                              MaterialPageRoute(
                                builder: (ctx) => MealDetailsScreen(
                                  mealDetails: categoryMeals[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 200,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          categoryMeals[index].title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.access_time_filled_rounded,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              '${categoryMeals[index].duration.toString()} min',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Icon(
                              Icons.shopping_bag_rounded,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              categoryMeals[index].complexity.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Icon(
                              Icons.attach_money_rounded,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              categoryMeals[index].affordability.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      bodyContent = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh... nothing here!',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          mealsCategoryId != null
              ? '${mealsCategories.firstWhere((mc) => mc.id == mealsCategoryId).name} Meals'
              : 'Favorite Meals',
        ),
      ),
      body: bodyContent,
    );
  }
}
