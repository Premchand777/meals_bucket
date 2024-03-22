import 'package:flutter/material.dart';

final Map<String, bool> filters = {
  'isGlutenFree': false,
  'isVegan': false,
  'isVegetarian': false,
  'isLactoseFree': false,
};

class FiltersScreenSFW extends StatefulWidget {
  const FiltersScreenSFW({
    super.key,
  });

  @override
  State<FiltersScreenSFW> createState() => _FiltersScreenSFWState();
}

class _FiltersScreenSFWState extends State<FiltersScreenSFW> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Apply Filters',
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          Navigator.of(context).pop(filters);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SwitchListTile(
                value: filters['isGlutenFree']!,
                onChanged: (isChecked) {
                  setState(() {
                    filters['isGlutenFree'] = isChecked;
                  });
                },
                title: const Text(
                  'Gluten-free',
                ),
                subtitle: const Text(
                  'Only includes gluten-free meals',
                ),
              ),
              SwitchListTile(
                value: filters['isLactoseFree']!,
                onChanged: (isChecked) {
                  setState(() {
                    filters['isLactoseFree'] = isChecked;
                  });
                },
                title: const Text(
                  'Lactose-free',
                ),
                subtitle: const Text(
                  'Only includes lactose-free meals',
                ),
              ),
              SwitchListTile(
                value: filters['isVegetarian']!,
                onChanged: (isChecked) {
                  setState(() {
                    filters['isVegetarian'] = isChecked;
                  });
                },
                title: const Text(
                  'Vegetarian',
                ),
                subtitle: const Text(
                  'Only includes vegetarian meals',
                ),
              ),
              SwitchListTile(
                value: filters['isVegan']!,
                onChanged: (isChecked) {
                  setState(() {
                    filters['isVegan'] = isChecked;
                  });
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
      ),
    );
  }
}
