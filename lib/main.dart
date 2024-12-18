import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'stack_item_model.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(StackUIApp());
}

class StackUIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack UI',
      theme: ThemeData.dark(), // Enable dark mode
      home: StackView(),
    );
  }
}

class StackView extends StatefulWidget {
  @override
  _StackViewState createState() => _StackViewState();
}

class _StackViewState extends State<StackView> {
  List<StackItem> items = [];
  List<bool> isExpanded = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    // Replace with your mock API URL
    final response =
        await http.get(Uri.parse('https://api.mocklets.com/p6764/test_mint'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonItems = json.decode(response.body)['items'];
      items = jsonItems.map((item) => StackItem.fromJson(item)).toList();
      isExpanded = List<bool>.filled(items.length, false);
      setState(() {});
    } else {
      throw Exception('Failed to load items');
    }
  }

  void _toggleExpansion(int index) {
    setState(() {
      isExpanded = List<bool>.filled(items.length, false);
      isExpanded[index] = !isExpanded[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stack UI'),
      ),
      body: items.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => _toggleExpansion(index),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            isExpanded[index]
                                ? item.openState.body.title
                                : item.closedState.body.title,
                            style: GoogleFonts.openSans(color: Colors.white),
                          ),
                          subtitle: isExpanded[index]
                              ? Text(item.openState.body.subtitle,
                                  style: TextStyle(color: Colors.grey))
                              : null,
                          trailing: Icon(
                            isExpanded[index]
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: Colors.grey,
                          ),
                        ),
                        if (isExpanded[index]) _buildExpandedContent(item),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildExpandedContent(StackItem item) {
    return Column(
      children: [
        // Your gauge widget goes here
        Container(
          height: 100, // Adjust height as necessary
          color: Colors.blue,
          child: Center(
              child: Text('Gauge here', style: TextStyle(color: Colors.white))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.ctaText, style: TextStyle(color: Colors.blue)),
        ),
        // Add more widgets as necessary for items
        if (item.openState.body.items != null)
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: item.openState.body.items!.length,
              itemBuilder: (context, index) {
                final cardItem = item.openState.body.items![index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(cardItem.title),
                      Text(cardItem.subtitle),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
