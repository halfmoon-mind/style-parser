# StyleParser

StyleParser is a Flutter package designed for parsing CSS styles and converting them into Flutter's `TextStyle` and `TextSpan` objects. This package provides an easy way to apply complex CSS styles to text widgets in Flutter, enabling rich text formatting based on HTML and CSS.

## Features

- Convert CSS strings to `TextStyle` objects.
- Convert HTML strings with embedded styles to `TextSpan` objects.
- Supports CSS class and tag selectors.
- Handles inline styles within HTML tags.

# Usage

## Importing the package

```dart
import 'package:style_parser/style_parser.dart';
```

## Converting CSS to TextStyle

To convert a CSS string to a map of `TextStyle` objects:

```dart
String css = """
  .bold { font-weight: bold; }
  .italic { font-style: italic; }
  .large { font-size: 24pt; }
""";

Map<String, TextStyle> styles = StyleParser.cssToTextStyle(css);
```

## Converting HTML to TextSpan

To convert an HTML string with styles to a `TextSpan` and apply existing tag styles:

```dart
String html = """
  <p class="bold">This is bold text.</p>
  <p class="italic">This is italic text.</p>
  <p class="large">This is large text.</p>
""";

Map<String, TextStyle> tagStyles = {
  'p': TextStyle(color: Colors.blue),
  'strong': TextStyle(fontWeight: FontWeight.bold),
};

TextSpan textSpan = StyleParser.htmlTagToTextSpan(html, existingClassStyle: styles, existingTagStyle: tagStyles);
```

## Example

Here is a full example demonstrating how to use the StyleParser package:

```dart
import 'package:flutter/material.dart';
import 'package:style_parser/style_parser.dart';

void main() {
runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
    TextSpan textSpan = StyleParser.htmlTagToTextSpan(html, existingClassStyle: styles);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('StyleParser Example'),
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
```

# API Reference

## StyleParser

**Methods**

- `htmlTagToTextSpan`

  - Converts an HTML string with styles to a TextSpan.

  - Parameters:
    - `style` (String): The HTML string to be converted.
    - `existingClassStyle` (Map<String, TextStyle>?): An optional map of class styles.
    - `existingTagStyle` (Map<String, TextStyle>?): An optional map of tag styles.

- `cssToTextStyle`

  - Converts a CSS string to a map of TextStyle objects.
  - Parameters:
    - `style` (String): The CSS string to be converted.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
