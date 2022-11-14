import 'dart:math';

import 'package:days_21/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bean/toDo.dart';

class SingleToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ToDo todo = Get.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(todo.name),
              background: Image.asset(
                'images/bg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                todo.startDate.substring(0, 10),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                todo.endDate.substring(0, 10),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: 20,
                right: 10,
              ),
              child: LinearProgressIndicator(
                value: 0.5,
                backgroundColor: Colors.black38,
                minHeight: 20,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                sy[Random().nextInt(sy.length)],
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'detailNotice'.tr,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
        // floatingActionButton: FloatingActionButton(onPressed: () {}),
        // body: Text('---${todo.name}'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
