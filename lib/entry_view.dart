import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list/constants/colors.dart';
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
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                // color: Colors.black12,
                color: kSecondaryColor,
                blurRadius: 10,
                spreadRadius: 3,
                offset: Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(
              color: kQuaternaryColor,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter a room code',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kSecondaryColor,
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                style: TextStyle(
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusColor: kPrimaryColor,
                  hoverColor: kPrimaryColor,
                  labelText: 'Room code',
                  labelStyle: TextStyle(
                    color: kSecondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  floatingLabelStyle: TextStyle(
                    color: kQuaternaryColor,
                    decorationColor: kSecondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kSecondaryColor,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kQuaternaryColor,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kTernaryColor,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Enter'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kSecondaryColor,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Create'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
