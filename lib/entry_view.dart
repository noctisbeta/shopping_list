import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list/room_service.dart';

class EntryView extends StatefulWidget {
  const EntryView({super.key});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> {
  String enterCode = '';
  String createCode = '';

  Future<void> handleEnterRoom() async {
    log('Entering room with access code: $enterCode');

    optimisticPush() {
      context.go('/room/$enterCode');
    }

    final String? code = await RoomService.getRoomByCode(enterCode);

    if (code != null) {
      optimisticPush();
    } else {
      log('Room with access code $enterCode does not exist');
    }
  }

  Future<void> handleCreateRoom() async {
    log('Creating room with access code: $createCode');

    optimisticPush() {
      context.go('/room/$createCode');
    }

    final String? code = await RoomService.createRoom(createCode);

    if (code != null) {
      optimisticPush();
    } else {
      log('Room with access code $enterCode already exists');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: MediaQuery.of(context).size.width > 600
              ? const BoxConstraints(maxWidth: 300)
              : BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Enter access code"),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Access code',
                ),
                onChanged: (value) {
                  setState(() {
                    enterCode = value;
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: handleEnterRoom,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                child: const Text('Enter'),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Create group with access code"),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Access code',
                ),
                onChanged: (value) {
                  setState(() {
                    createCode = value;
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: handleCreateRoom,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
