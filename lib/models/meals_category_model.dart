import 'package:flutter/material.dart';

class MealsCategoryModel {
  const MealsCategoryModel({
    required this.id,
    required this.name,
    required this.categoryColor,
  });

  final String id;
  final String name;
  final Color categoryColor;
}
