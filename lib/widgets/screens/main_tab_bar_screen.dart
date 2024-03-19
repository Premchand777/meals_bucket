import 'package:flutter/material.dart';
import 'package:meals_bucket/models/meal_model.dart';
import 'package:meals_bucket/widgets/screens/category_meals_slw.dart';
import 'package:meals_bucket/widgets/screens/meals_categories_slw.dart';

class MainTabBarScreen extends StatefulWidget {
  const MainTabBarScreen({
    super.key,
  });

  @override
  State<MainTabBarScreen> createState() => _MainTabBarScreenState();
}

class _MainTabBarScreenState extends State<MainTabBarScreen> {
  int currentScreenIndex = 0;
  Widget? currentScreen;
  List<MealModel> favoriteMealCategories = [];
  AppBar? currentAppBar = AppBar(
    title: const Text(
      'Meals Categories',
    ),
  );

  void _setCurrentScreen(int index) {
    if (index == 1) {
      currentAppBar = null;
      setState(() {
        currentScreenIndex = 1;
        currentScreen = CategoryMealsScreen(
          favoriteMeals: favoriteMealCategories,
          addRemoveFavorites: _addRemoveFavorites,
        );
      });
    }
    if (index == 0) {
      setState(() {
        currentScreenIndex = 0;
        currentScreen = MealsCategoriesScreen(
          favoriteMeals: favoriteMealCategories,
          addRemoveFavorites: _addRemoveFavorites,
        );
      });
    }
  }

  void _showToggleFavoriteSnackMsg(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),duration: Durations.extralong2,
      ),
    );
  }

  void _addRemoveFavorites(MealModel mealDetails) {
    if (favoriteMealCategories.contains(mealDetails)) {
      setState(() {
        favoriteMealCategories.remove(mealDetails);
        currentScreenIndex = 0;
        currentScreen = CategoryMealsScreen(
          favoriteMeals: favoriteMealCategories,
          addRemoveFavorites: _addRemoveFavorites,
        );
      });
      _showToggleFavoriteSnackMsg('Meal removed from Favoriets.');
    } else {
      favoriteMealCategories.add(mealDetails);
      _showToggleFavoriteSnackMsg('Meal added to Favoriets.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentAppBar,
      body: currentScreen ??
          MealsCategoriesScreen(
            favoriteMeals: favoriteMealCategories,
            addRemoveFavorites: _addRemoveFavorites,
          ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}
