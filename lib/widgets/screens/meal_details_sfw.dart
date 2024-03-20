// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:meals_bucket/models/meal_model.dart';

class MealDetailsScreen extends StatefulWidget {
  MealDetailsScreen({
    super.key,
    required this.mealDetails,
    required this.favoriteMeals,
    required this.addRemoveFavorites,
    required this.currentTabIndex,
  });

  MealModel mealDetails;
  List<MealModel> favoriteMeals;
  void Function(MealModel mealDetails, int currentTabIndex) addRemoveFavorites;
  final int currentTabIndex;

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  int iconIndex = 0;
  Icon icon = const Icon(
    Icons.star_border_rounded,
  );
  @override
  Widget build(BuildContext context) {
    if (widget.favoriteMeals.contains(widget.mealDetails)) {
      iconIndex = 1;
      icon = const Icon(
        Icons.star_rate_rounded,
      );
    }
    void toggleFavoriteIcon() {
      if (iconIndex == 0) {
        // setState(() {
        iconIndex = 1;
        icon = const Icon(
          Icons.star_rate_rounded,
        );
        // });
        return;
      }
      if (iconIndex == 1) {
        // setState(() {
        iconIndex = 0;
        icon = const Icon(
          Icons.star_border_rounded,
        );
        // });
      }
    }

    void onTappingFavoriteIcon() {
      setState(() {
        toggleFavoriteIcon();
      });
      widget.addRemoveFavorites(
        widget.mealDetails,
        widget.currentTabIndex,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mealDetails.title,
        ),
        actions: [
          IconButton(
            icon: icon,
            onPressed: onTappingFavoriteIcon,
            style: const ButtonStyle(
              iconSize: MaterialStatePropertyAll(30),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.mealDetails.imageUrl,
                    ),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Ingredients',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              for (final ingredient in widget.mealDetails.ingredients)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Text(
                    ingredient,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Steps',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              for (final step in widget.mealDetails.steps)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: Text(
                    step,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
