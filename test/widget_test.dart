import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stack_ui/main.dart';

void main() {
  testWidgets('Check for AppBar title', (WidgetTester tester) async {
    await tester.pumpWidget(StackUIApp());
    expect(find.text('Stack UI'), findsOneWidget);
  });
}
