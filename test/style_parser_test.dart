import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:style_parser/style_parser.dart';

void main() {
  test('cssToTextStyle', () {
    const originalText =
        '<p style="font-size:12pt; font-weight: 400"><strong>HI</strong>WOW</p><p>Awesome</p>';
    print("original string : $originalText");
    final textSpan = StyleParser.cssToTextSpan(originalText);
    for (var child in textSpan.children!) {
      expect(child.style!.fontSize, 12);
      expect(child.style!.fontWeight, FontWeight.w400);
    }
  });
}
