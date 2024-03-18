import 'package:flutter/material.dart';

import 'package:meals_bucket/models/meals_category_model.dart';
// import 'package:meals_bucket/widgets/screens/category_meals_slw.dart';

class MealsCategoryItemSLW extends StatelessWidget {
  const MealsCategoryItemSLW({
    super.key,
    required this.category,
    required this.onSelect,
  });

  final MealsCategoryModel category;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSelect,
        splashColor: Colors.black54,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: category.categoryColor.withOpacity(0.75),
            border: Border.all(
              color: category.categoryColor.withOpacity(0.75),
              width: 2,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                category.categoryColor.withOpacity(0.55),
                category.categoryColor.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Text(
            category.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.white.withOpacity(0.99),
            ),
          ),
        ),
      ),
    );
  }
}
