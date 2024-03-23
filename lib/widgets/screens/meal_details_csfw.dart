// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_bucket/models/meal_model.dart';
import 'package:meals_bucket/providers/meals_providers.dart';

class MealDetailsScreenCSFW extends ConsumerStatefulWidget {
  MealDetailsScreenCSFW({
    super.key,
    required this.mealDetails,
  });

  MealModel mealDetails;

  @override
  ConsumerState<MealDetailsScreenCSFW> createState() =>
      _MealDetailsScreenState();
}

class _MealDetailsScreenState extends ConsumerState<MealDetailsScreenCSFW> {
  Icon icon = const Icon(
    Icons.star_border_rounded,
  );

  void toggleFavoriteIcon(bool isFavorite) {
    if (isFavorite) {
      setState(() {
        icon = const Icon(
          Icons.star_rate_rounded,
        );
      });
      _showToggleFavoriteSnackMsg('Marked as favorite.');
      return;
    }
    setState(() {
      icon = const Icon(
        Icons.star_border_rounded,
      );
    });
    _showToggleFavoriteSnackMsg('Removed from favorites.');
  }

  void onTappingFavoriteIcon() {
    final wasAdded = ref
        .read(favoriteMealsProvider.notifier)
        .addOrRemoveFavorites(widget.mealDetails);
    toggleFavoriteIcon(wasAdded);
  }

  void _showToggleFavoriteSnackMsg(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Durations.extralong2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (ref.read(favoriteMealsProvider).contains(widget.mealDetails)) {
      icon = const Icon(
        Icons.star_rate_rounded,
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
