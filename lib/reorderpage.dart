import 'package:flutter/material.dart';
import 'package:drag_and_drop_gridview/devdrag.dart';

class ReorderPage extends StatefulWidget {
  @override
  _ReorderPageState createState() => _ReorderPageState();
}

class _ReorderPageState extends State<ReorderPage> {
  List<String> scannedPages = ["Red", "Green", "Blue", "Yellow", "Vilot"];

  @override
  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    setState(() {
      String temp = scannedPages[oldIndex];
      scannedPages.removeAt(oldIndex);
      scannedPages.insert(newIndex, temp);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reordering Pages'),
        ),
        body: ReorderableListView(
          children: getListItems(),
          onReorder: (int oldIndex, int newIndex) {
            onReorder(oldIndex, newIndex);
          },
          scrollDirection: Axis.vertical,
        ));
  }

  List<ListTile> getListItems() {
    return scannedPages
        .asMap()
        .map((index, item) => MapEntry(index, buildListTile(item, index)))
        .values
        .toList();
  }

  ListTile buildListTile(String item, int index) {
    return ListTile(
      key: ValueKey(item),
      title: Text(item),
      leading: Text("#${index + 1}"),
    );
  }
}
