import 'package:flutter/material.dart';

class MultipleSelectionDropDown extends StatefulWidget {
  const MultipleSelectionDropDown({super.key});

  @override
  State<MultipleSelectionDropDown> createState() =>
      _MultipleSelectionDropDownState();
}

class _MultipleSelectionDropDownState extends State<MultipleSelectionDropDown> {

  List<String> selectedItems = [];
  List<String> menuItems = ['red', 'green', 'yellow', 'orange'];

  void _showMultiSelect(BuildContext context) async {
    final List<String> result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Item'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (BuildContext context, int index) {
                final String item = menuItems[index];
                return CheckboxListTile(
                  title: Text(item),
                  value: selectedItems.contains(item),
                  selected: selectedItems.contains(item),
                  onChanged: (value) {
                    if(value!){
                      selectedItems.add(item);
                    }else{
                      selectedItems.remove(item);
                    }
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedItems.toList());
              },
              child: const Text('Done'),
            ),
          ],
        );
      },);
    setState(() {
      selectedItems = result;
    });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Selected Item : '),
            const SizedBox(height: 10,),
            Wrap(
              children: selectedItems.map((item) {
                return Chip(
                  label: Text(item),
                  onDeleted: () {
                    setState(() {
                      selectedItems.remove(item);
                    });
                  },
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                _showMultiSelect(context);
              }, 
              child: const Text('Select Item')
            )
          ],
        ),
      ),
      //backgroundColor: Colors.black54,
    );
  }
}
