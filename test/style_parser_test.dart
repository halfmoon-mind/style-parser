import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:style_parser/style_parser.dart';

void main() {
  test('cssToTextStyle_SingleTag', () {
    const originalText = '<p style="font-size:12pt; font-weight: 400">HI</p>';
    final textSpan = StyleParser.cssToTextSpan(originalText);
    for (var child in textSpan.children!) {
      expect(child.style!.fontSize, 12);
      expect(child.style!.fontWeight, FontWeight.w400);
    }
  });

  test('cssToTextStyle_MultiTag', () {
    const originalText = '<p style="font-size:12pt; font-weight: 400">HI</p>';
    final textSpan = StyleParser.cssToTextSpan(originalText);
    for (var child in textSpan.children!) {
      expect(child.style!.fontSize, 12);
      expect(child.style!.fontWeight, FontWeight.w400);
    }
  });

  test('cssToTextStyle_RecursiveTag', () {
    const originalText = '<p style="font-size:12pt; font-weight: 400">HI</p>';
    final textSpan = StyleParser.cssToTextSpan(originalText);
    for (var child in textSpan.children!) {
      expect(child.style!.fontSize, 12);
      expect(child.style!.fontWeight, FontWeight.w400);
    }
  });
  test('cssToTextStyle_RecursiveMultiTag', () {
    const originalText = '<p style="font-size:12pt; font-weight: 400">HI</p>';
    final textSpan = StyleParser.cssToTextSpan(originalText);
    for (var child in textSpan.children!) {
      expect(child.style!.fontSize, 12);
      expect(child.style!.fontWeight, FontWeight.w400);
    }
  });
}
