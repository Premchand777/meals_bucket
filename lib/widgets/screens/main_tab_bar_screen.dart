import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:meals_bucket/data/meals.dart';
import 'package:meals_bucket/models/meal_model.dart';
import 'package:meals_bucket/providers/meals_provider.dart';
import 'package:meals_bucket/widgets/screens/category_meals_slw.dart';
import 'package:meals_bucket/widgets/screens/filters_screen_sfw.dart';
import 'package:meals_bucket/widgets/screens/meals_categories_slw.dart';
import 'package:meals_bucket/widgets/widgets/main_drawer_slw.dart';

AppBar appBar = AppBar(
  title: const Text(
    'Meals Categories',
  ),
);

class MainTabBarScreen extends ConsumerStatefulWidget {
  const MainTabBarScreen({
    super.key,
  });

  @override
  ConsumerState<MainTabBarScreen> createState() => _MainTabBarScreenState();
}

class _MainTabBarScreenState extends ConsumerState<MainTabBarScreen> {
  int currentScreenIndex = 0;
  Widget? currentScreen;
  List<MealModel> favoriteMealCategories = [];
  AppBar? currentAppBar = appBar;
  List<MealModel> filteredMeals = [];

  void _setCurrentScreen(int index) async {
    if (index == 1) {
      currentAppBar = null;
      setState(() {
        currentScreenIndex = 1;
        currentScreen = CategoryMealsScreen(
          favoriteMeals: favoriteMealCategories,
          addRemoveFavorites: _addRemoveFavorites,
          currentTabIndex: currentScreenIndex,
          filteredMeals: filteredMeals,
        );
      });
    }
    if (index == 0) {
      currentAppBar = appBar;
      setState(() {
        currentScreenIndex = 0;
        currentScreen = MealsCategoriesScreen(
          favoriteMeals: favoriteMealCategories,
          addRemoveFavorites: _addRemoveFavorites,
          currentTabIndex: currentScreenIndex,
          filteredMeals: filteredMeals,
        );
      });
    }

    if (index == 2) {
      currentAppBar = null;
      currentScreenIndex = 2;
      final mealsFilters = await Navigator.of(context).push<Map<String, bool>>(
        MaterialPageRoute(builder: (ctx) {
          return const FiltersScreenSFW();
        }),
      );
      if (mealsFilters != null) {
        final meals = ref.read(mealsProvider);
        filteredMeals = meals.where((meal) {
          return mealsFilters.entries.every((entry) {
            switch (entry.key) {
              case 'isGlutenFree':
                return !entry.value || meal.isGlutenFree;
              case 'isVegan':
                return !entry.value || meal.isVegan;
              case 'isVegetarian':
                return !entry.value || meal.isVegetarian;
              case 'isLactoseFree':
                return !entry.value || meal.isLactoseFree;
              default:
                return true;
            }
          });
        }).toList();
      }
      setState(() {
        currentAppBar = appBar;
        currentScreenIndex = 0;
        currentScreen = MealsCategoriesScreen(
          favoriteMeals: favoriteMealCategories,
          addRemoveFavorites: _addRemoveFavorites,
          currentTabIndex: currentScreenIndex,
          filteredMeals: filteredMeals,
        );
      });
    }
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

  void _addRemoveFavorites(MealModel mealDetails, int currentTabIndex) {
    if (favoriteMealCategories.contains(mealDetails)) {
      favoriteMealCategories.remove(mealDetails);
      _showToggleFavoriteSnackMsg('Meal removed from Favoriets.');
    } else {
      favoriteMealCategories.add(mealDetails);
      _showToggleFavoriteSnackMsg('Meal added to Favoriets.');
    }
    _setCurrentScreen(currentTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentAppBar,
      drawer: MainDrawer(
        onSelectMenuItem: _setCurrentScreen,
      ),
      body: currentScreen ??
          MealsCategoriesScreen(
            favoriteMeals: favoriteMealCategories,
            addRemoveFavorites: _addRemoveFavorites,
            currentTabIndex: currentScreenIndex,
            filteredMeals: const [],
          ),
      bottomNavigationBar: currentScreenIndex != 2
          ? BottomNavigationBar(
              currentIndex: currentScreenIndex,
              onTap: _setCurrentScreen,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.set_meal_rounded,
                  ),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.star_rate_rounded,
                  ),
                  label: 'Favorites',
                ),
              ],
              type: BottomNavigationBarType.fixed,
            )
          : null,
    );
  }
}
