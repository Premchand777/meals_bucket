import 'package:flutter/material.dart';
import 'package:meals_bucket/models/meal_model.dart';
import 'package:meals_bucket/widgets/screens/category_meals_slw.dart';
import 'package:meals_bucket/widgets/screens/meals_categories_slw.dart';

AppBar appBar = AppBar(
  title: const Text(
    'Meals Categories',
  ),
);

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
  AppBar? currentAppBar = appBar;

  void _setCurrentScreen(int index) {
    if (index == 1) {
      currentAppBar = null;
      setState(() {
        currentScreenIndex = 1;
        currentScreen = CategoryMealsScreen(
          favoriteMeals: favoriteMealCategories,
          addRemoveFavorites: _addRemoveFavorites,
          currentTabIndex: currentScreenIndex,
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
      body: currentScreen ??
          MealsCategoriesScreen(
            favoriteMeals: favoriteMealCategories,
            addRemoveFavorites: _addRemoveFavorites,
            currentTabIndex: currentScreenIndex,
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
