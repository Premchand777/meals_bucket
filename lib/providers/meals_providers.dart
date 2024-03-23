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

enum Filters { isGlutenFree, isVegan, isVegetarian, isLactoseFree }

class FiltersStateNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersStateNotifier()
      : super({
          Filters.isGlutenFree: false,
          Filters.isVegan: false,
          Filters.isVegetarian: false,
          Filters.isLactoseFree: false
        });

  void setFilters(Filters filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersStateProvider =
    StateNotifierProvider<FiltersStateNotifier, Map<Filters, bool>>(
  (ref) => FiltersStateNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final filtersProvider = ref.watch(filtersStateProvider);
  final meals = ref.read(mealsProvider);
  return meals.where((meal) {
    return filtersProvider.entries.every((entry) {
      switch (entry.key) {
        case Filters.isGlutenFree:
          return !entry.value || meal.isGlutenFree;
        case Filters.isVegan:
          return !entry.value || meal.isVegan;
        case Filters.isVegetarian:
          return !entry.value || meal.isVegetarian;
        case Filters.isLactoseFree:
          return !entry.value || meal.isLactoseFree;
        default:
          return true;
      }
    });
  }).toList();
});
