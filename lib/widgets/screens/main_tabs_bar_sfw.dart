import 'package:flutter/material.dart';

import 'package:meals_bucket/widgets/screens/category_meals_cw.dart';
import 'package:meals_bucket/widgets/screens/filters_cw.dart';
import 'package:meals_bucket/widgets/screens/meals_categories_cw.dart';
import 'package:meals_bucket/widgets/widgets/main_drawer_slw.dart';

AppBar appBar = AppBar(
  title: const Text(
    'Meals Categories',
  ),
);

class MainTabBarScreenSFW extends StatefulWidget {
  const MainTabBarScreenSFW({
    super.key,
  });

  @override
  State<MainTabBarScreenSFW> createState() => _MainTabBarScreenState();
}

class _MainTabBarScreenState extends State<MainTabBarScreenSFW> {
  int currentScreenIndex = 0;
  Widget? currentScreen;
  AppBar? currentAppBar = appBar;

  void _setCurrentScreen(int index) async {
    if (index == 1) {
      currentAppBar = null;
      setState(() {
        currentScreenIndex = 1;
        currentScreen = const CategoryMealsScreenCW(
          filteredMeals: [],
        );
      });
    }

    if (index == 0) {
      currentAppBar = appBar;
      setState(() {
        currentScreenIndex = 0;
        currentScreen = const MealsCategoriesScreenCW();
      });
    }

    if (index == 2) {
      currentAppBar = null;
      currentScreenIndex = 2;
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) {
          return const FiltersScreenCW();
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentAppBar,
      drawer: MainDrawerSLW(
        onSelectMenuItem: _setCurrentScreen,
      ),
      body: currentScreen ?? const MealsCategoriesScreenCW(),
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
