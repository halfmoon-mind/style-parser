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

    test('Invalid CSS', () {
      const css = 'invalid css { this is not valid }';
      final result = StyleParser.cssToTextStyle(css);
      expect(result, isEmpty);
    });
  });

  test('wos', () {
    const text = """
<p>
<p>아니 뭐지 <strong>왜 이러지?</strong>  ㅋㅋㅋㅋ<em>ㅋㅋㅋ</em>   아아아아<strong><em>아아아아</em></strong>  오오오오ㅇ<strong> 오오오</strong></p>
</p>
""";
    final result = StyleParser.htmlTagToTextSpan(text);
    for (var child in result.children!) {
      print(child);
    }
  });
}
