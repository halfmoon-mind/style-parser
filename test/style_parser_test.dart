import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:style_parser/style_parser.dart';

void main() {
  group('Parser tests', () {
    test('Test htmlTagToTextSpan method', () {
      const String htmlContent =
          '<strong>Bold text</strong><em>Italic text</em>';

      final textSpan = StyleParser.htmlTagToTextSpan(htmlContent);

      expect(textSpan.children, isNotNull);
      expect(textSpan.children!.length, 2);
      expect((textSpan.children![0] as TextSpan).text, 'Bold text');
      expect((textSpan.children![0] as TextSpan).style!.fontWeight,
          FontWeight.bold);
      expect((textSpan.children![1] as TextSpan).text, 'Italic text');
      expect((textSpan.children![1] as TextSpan).style!.fontStyle,
          FontStyle.italic);
    });

    test('Test cssToTextStyle method', () {
      const String cssContent = '''
        .boldClass { font-weight: bold; }
        .italicClass { font-style: italic; }
        .colorClass { color: #ff0000; }
        #idSelector { font-size: 16pt; }
      ''';

      final textStyles = StyleParser.cssToTextStyle(cssContent);

      expect(textStyles['.boldClass'], isNotNull);
      expect(textStyles['.boldClass']!.fontWeight, FontWeight.bold);

      expect(textStyles['.italicClass'], isNotNull);
      expect(textStyles['.italicClass']!.fontStyle, FontStyle.italic);

      expect(textStyles['.colorClass'], isNotNull);
      expect(textStyles['.colorClass']!.color, const Color(0xFFFF0000));

      expect(textStyles['#idSelector'], isNotNull);
      expect(textStyles['#idSelector']!.fontSize, 16);
    });
    test('htmlTagToTextSpan converts HTML to TextSpan', () {
      final result =
          StyleParser.htmlTagToTextSpan('<p>Hello <strong>World</strong></p>');

      expect(result, isA<TextSpan>());
      expect(result.children, isNotNull);
      expect(result.children!.length, 1);

      final pSpan = result.children![0] as TextSpan;
      expect(pSpan.children!.length, 2);
      expect(pSpan.children![0], isA<TextSpan>());
      expect((pSpan.children![0] as TextSpan).text, 'Hello ');
      expect(pSpan.children![1], isA<TextSpan>());
      expect((pSpan.children![1] as TextSpan).text, 'World');
      expect(
          (pSpan.children![1] as TextSpan).style!.fontWeight, FontWeight.bold);
    });

    test('htmlTagToTextSpan with existing styles', () {
      final existingClassStyle = {
        'highlight': const TextStyle(backgroundColor: Colors.yellow),
      };
      final existingTagStyle = {
        'p': const TextStyle(fontSize: 18),
      };

      final result = StyleParser.htmlTagToTextSpan(
        '<p class="highlight">Highlighted text</p>',
        existingClassStyle: existingClassStyle,
        existingTagStyle: existingTagStyle,
      );

      expect(result, isA<TextSpan>());
      expect(result.children, isNotNull);
      expect(result.children!.length, 1);

      final pSpan = result.children![0] as TextSpan;
      expect(pSpan.style!.backgroundColor, Colors.yellow);
      expect(pSpan.style!.fontSize, 18);
    });

    test('cssToTextStyle converts CSS to TextStyle', () {
      const css = '''
        .test1 { font-size: 16pt; color: #FF0000; }
        .test2 { font-weight: bold; font-style: italic; }
      ''';
      final result = StyleParser.cssToTextStyle(css);

      expect(result, isA<Map<String, TextStyle>>());
      expect(result['.test1'], isNotNull);
      expect(result['.test1']!.fontSize, 16.0);
      expect(result['.test1']!.color, const Color(0xFFFF0000));
      expect(result['.test2']!.fontWeight, FontWeight.bold);
      expect(result['.test2']!.fontStyle, FontStyle.italic);
    });
  });

  group('Complex HTML parsing', () {
    test('Nested elements with mixed styles', () {
      const html = '''
        <p style="color: #0000FF;">
          Blue text
          <span style="font-weight: bold;">Bold blue text</span>
          <em>Italic blue text</em>
        </p>
      ''';
      final result = StyleParser.htmlTagToTextSpan(html);

      expect(result, isA<TextSpan>());
      expect(result.children, isNotNull);
      expect(result.children!.length, 1);

      final pSpan = result.children![0] as TextSpan;
      expect(pSpan.style!.color, const Color(0xFF0000FF));
      expect(pSpan.children!.length, 4); // Text, span, Text, em
      expect(
          (pSpan.children![1] as TextSpan).style!.fontWeight, FontWeight.bold);
      expect(
          (pSpan.children![3] as TextSpan).style!.fontStyle, FontStyle.italic);
    });
  });

  group('CSS parsing edge cases', () {
    test('Multiple CSS classes', () {
      const css = '''
        .bold { font-weight: bold; }
        .italic { font-style: italic; }
        .large { font-size: 20pt; }
      ''';
      final styles = StyleParser.cssToTextStyle(css);
      const html = '<p class="bold italic large">Styled text</p>';
      final result =
          StyleParser.htmlTagToTextSpan(html, existingClassStyle: styles);

      expect(result, isA<TextSpan>());
      expect(result.children, isNotNull);
      expect(result.children!.length, 1);

      final pSpan = result.children![0] as TextSpan;
      expect(pSpan.style!.fontWeight, FontWeight.bold);
      expect(pSpan.style!.fontStyle, FontStyle.italic);
      expect(pSpan.style!.fontSize, 20.0);
    });

    test('Invalid CSS', () {
      const css = 'invalid css { this is not valid }';
      final result = StyleParser.cssToTextStyle(css);
      expect(result, isEmpty);
    });
  });
}
