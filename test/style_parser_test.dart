import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:style_parser/style_parser.dart';

void main() {
  test('cssToTextStyle', () {
    final textSpan = StyleParser.cssToTextSpan(
        '<p style="font-size:12pt; font-weight: 400">HI</p>');
    expect(textSpan.style!.fontSize, 12);
    expect(textSpan.style!.fontWeight, FontWeight.w400);
  });
}
