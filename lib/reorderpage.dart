import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

class ReorderPage extends StatefulWidget {
  @override
  _ReorderPageState createState() => _ReorderPageState();
}

class _ReorderPageState extends State<ReorderPage> {
  List<String> images = [
    'assets/images/lake.jpg',
    'assets/images/leaves.jpg',
    'assets/images/space.jpg',
    'assets/images/tropics.jpg',
    'assets/images/leopard.jpg',
    'assets/images/sunset.jpg',
    'assets/images/wolf.jpg',
  ];

  int variableSet = 0;
  ScrollController _scrollController;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reorder Pages'),
        ),
        body: DragAndDropGridView(
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4.5,
          ),
          padding: EdgeInsets.all(20),
          itemBuilder: (context, index) => Card(
            elevation: 2,
            child: LayoutBuilder(builder: (context, costrains) {
              if (variableSet == 0) {
                height = costrains.maxHeight;
                width = costrains.maxWidth;
                variableSet++;
              }
              return GridTile(
                child: Image.asset(
                  images[index],
                  height: height,
                  width: width,
                ),
              );
            }),
          ),
          itemCount: images.length,
          onWillAccept: (oldIndex, newIndex) => true,
          onReorder: (oldIndex, newIndex) {
            int indexOfFirstItem = images.indexOf(images[oldIndex]);
            int indexOfSecondItem = images.indexOf(images[newIndex]);

            if (indexOfFirstItem > indexOfSecondItem) {
              for (int i = images.indexOf(images[oldIndex]);
                  i > images.indexOf(images[newIndex]);
                  i--) {
                var tmp = images[i - 1];
                images[i - 1] = images[i];
                images[i] = tmp;
              }
            } else {
              for (int i = images.indexOf(images[oldIndex]);
                  i < images.indexOf(images[newIndex]);
                  i++) {
                var tmp = images[i + 1];
                images[i + 1] = images[i];
                images[i] = tmp;
              }
            }
            setState(() {});
          },
        ));
  }
}
