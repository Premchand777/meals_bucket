import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_bucket/providers/meals_providers.dart';

class FiltersScreenCW extends ConsumerWidget {
  const FiltersScreenCW({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtersProvider = ref.watch(filtersStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Apply Filters',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SwitchListTile(
              value: filtersProvider[Filters.isGlutenFree]!,
              onChanged: (isChecked) {
                // setState(() {
                //   filters['isGlutenFree'] = isChecked;
                // });
                ref
                    .read(filtersStateProvider.notifier)
                    .setFilters(Filters.isGlutenFree, isChecked);
              },
              title: const Text(
                'Gluten-free',
              ),
              subtitle: const Text(
                'Only includes gluten-free meals',
              ),
            ),
            SwitchListTile(
              value: filtersProvider[Filters.isLactoseFree]!,
              onChanged: (isChecked) {
                // setState(() {
                //   filters['isLactoseFree'] = isChecked;
                // });
                ref
                    .read(filtersStateProvider.notifier)
                    .setFilters(Filters.isLactoseFree, isChecked);
              },
              title: const Text(
                'Lactose-free',
              ),
              subtitle: const Text(
                'Only includes lactose-free meals',
              ),
            ),
            SwitchListTile(
              value: filtersProvider[Filters.isVegetarian]!,
              onChanged: (isChecked) {
                // setState(() {
                //   filters['isVegetarian'] = isChecked;
                // });
                ref
                    .read(filtersStateProvider.notifier)
                    .setFilters(Filters.isVegetarian, isChecked);
              },
              title: const Text(
                'Vegetarian',
              ),
              subtitle: const Text(
                'Only includes vegetarian meals',
              ),
            ),
            SwitchListTile(
              value: filtersProvider[Filters.isVegan]!,
              onChanged: (isChecked) {
                // setState(() {
                //   filters['isVegan'] = isChecked;
                // });
                ref
                    .read(filtersStateProvider.notifier)
                    .setFilters(Filters.isVegan, isChecked);
              },
              title: const Text(
                'Vegan',
              ),
              subtitle: const Text(
                'Only includes vegan meals',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
