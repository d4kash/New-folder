import 'package:flutter/material.dart';

class DropdownDemo extends StatefulWidget {
  const DropdownDemo({super.key});

  @override
  _DropdownDemoState createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<DropdownDemo> {
  String _selectedItem = 'Apple';
  final List<String> _dropdownItems = ['Apple', 'Ball', 'Cat', 'Dog'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Flutter Dropdown Demo'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected Item : $_selectedItem',
              style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedItem,
              onChanged: (newValue) {
                setState(() {
                  _selectedItem = newValue.toString();
                });
              },
              items: _dropdownItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
