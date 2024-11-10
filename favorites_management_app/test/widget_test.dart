import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:favorites_management_app/main.dart';
import 'package:favorites_management_app/favorites.dart';

void main() {
  testWidgets('Product List screen displays products and favorites correctly', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => Favorites(),
        child: MyApp(),
      ),
    );

    // Verify if "Product List" title appears
    expect(find.text('Product List'), findsOneWidget);

    // Verify if a few products appear
    expect(find.text('Product 0'), findsOneWidget);
    expect(find.text('Product 1'), findsOneWidget);

    // Tap on the first product's favorite icon to add it to favorites
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump(); // Rebuild the widget after the state change

    // Verify that the product is now a favorite (icon has changed)
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // Navigate to the Favorites screen by tapping the floating action button
    await tester.tap(find.byIcon(Icons.favorite).last);
    await tester.pumpAndSettle(); // Wait for the navigation animation to finish

    // Verify if "Favorites" screen displays the favorited product
    expect(find.text('Product 0'), findsOneWidget);
  });
}