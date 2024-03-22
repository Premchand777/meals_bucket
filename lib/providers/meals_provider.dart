import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_bucket/data/meals.dart';
import 'package:meals_bucket/models/meal_model.dart';

// Providers are access points to shared states.
final mealsProvider = Provider((ref) => meals);

class FavoriteMealsNotifier extends StateNotifier<List<MealModel>> {
  FavoriteMealsNotifier() : super([]);

  bool addOrRemoveFavorites(
    MealModel mealDetails,
    // int currentTabIndex,
  ) {
    if (state.contains(mealDetails)) {
      state = state.where((m) => m.id != mealDetails.id).toList();
      return false;
    } else {
      state = [...state, mealDetails];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<MealModel>>(
  (ref) => FavoriteMealsNotifier(),
);
