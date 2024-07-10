import 'package:flutter/material.dart';
import 'package:style_parser/style_parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String css = """
      .bold { font-weight: bold; }
      .italic { font-style: italic; }
      .large { font-size: 24pt; }
    """;

    String html = """
      <p class="bold">This is bold text.</p>
      <p class="italic">This is italic text.</p>
      <p class="large">This is large text.</p>
    """;

    Map<String, TextStyle> styles = StyleParser.cssToTextStyle(css);
    TextSpan textSpan =
        StyleParser.htmlTagToTextSpan(html, existingClassStyle: styles);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('StyleParser Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: textSpan,
          ),
        ),
      ),
    );
  }
}
