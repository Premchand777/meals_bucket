// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_bucket/models/meal_model.dart';
import 'package:meals_bucket/providers/meals_providers.dart';

class MealDetailsScreenCW extends ConsumerWidget {
  MealDetailsScreenCW({
    super.key,
    required this.mealDetails,
  });

  MealModel mealDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showToggleFavoriteSnackMsg(String msg) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          duration: Durations.extralong2,
        ),
      );
    }

    void toggleFavoriteIcon(bool isFavorite) {
      if (isFavorite) {
        showToggleFavoriteSnackMsg('Marked as favorite.');
        return;
      }
      showToggleFavoriteSnackMsg('Removed from favorites.');
    }

    void onTappingFavoriteIcon() {
      final wasAdded = ref
          .read(favoriteMealsProvider.notifier)
          .addOrRemoveFavorites(mealDetails);
      toggleFavoriteIcon(wasAdded);
    }

    final isFavorited = ref.watch(favoriteMealsProvider).contains(mealDetails);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          mealDetails.title,
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorited ? Icons.star_rate_rounded : Icons.star_border_rounded,
            ),
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
                      mealDetails.imageUrl,
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
              for (final ingredient in mealDetails.ingredients)
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
              for (final step in mealDetails.steps)
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
