import 'package:flutter/material.dart';
import 'package:shopping_list/shopping_list_item.dart';
import 'package:shopping_list/shopping_list_service.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({
    required this.code,
    super.key,
  });

  final String code;

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  String itemName = '';
  int quantity = 0;
  double price = 0.0;

  Future<void> handleAddItem() async {
    popDialog() {
      Navigator.of(context).pop();
    }

    errorSnackbar() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error adding item'),
        ),
      );
    }

    final res = await ShoppingListService.addShoppingListItem(
      ShoppingListItem(
        name: itemName,
        quantity: quantity,
        price: price,
      ),
      widget.code,
    );

    if (res != null) {
      popDialog();
    } else {
      errorSnackbar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Item Name',
                    ),
                    onChanged: (value) {
                      itemName = value;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Quantity',
                    ),
                    onChanged: (value) {
                      quantity = int.parse(value);
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Price',
                    ),
                    onChanged: (value) {
                      price = double.parse(value);
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: handleAddItem,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                    ),
                    child: const Text('Add Item'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
