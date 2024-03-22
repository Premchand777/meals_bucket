import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_bucket/data/meals.dart';

// Providers are access points to shared states.
final mealsProvider = Provider((ref) => meals);
