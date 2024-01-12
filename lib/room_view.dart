import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list/add_item_dialog.dart';
import 'package:shopping_list/shopping_list_item.dart';
import 'package:shopping_list/shopping_list_service.dart';

class RoomView extends StatefulWidget {
  const RoomView({
    required this.code,
    super.key,
  });

  final String code;

  @override
  State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
  late Future<List<ShoppingListItem>> itemsFuture;

  @override
  void initState() {
    super.initState();

    itemsFuture = ShoppingListService.getShoppingList(widget.code);
    // setFuture();
  }

  void setFuture() {
    setState(() {
      itemsFuture = ShoppingListService.getShoppingList(widget.code);
    });
  }

  void handleAddItem() {
    showDialog(
      context: context,
      builder: (context) => AddItemDialog(
        code: widget.code,
      ),
    ).then((value) => setFuture());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room ${widget.code}'),
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () => setFuture(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleAddItem,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: Center(
          child: FutureBuilder<List<ShoppingListItem>>(
        future: itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(snapshot.data![index].quantity.toString()),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      )),
    );
  }
}
