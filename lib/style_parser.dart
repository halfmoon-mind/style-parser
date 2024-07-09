library style_parser;

import 'package:flutter/material.dart' hide Element;
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;

part 'css_to_textstyle.dart';

class StyleParser {
  StyleParser._();

  static final _parser = _Parser.instance;

  static TextSpan htmlTagToTextSpan(
    String style, {
    Map<String, TextStyle>? existingClassStyle,
    Map<String, TextStyle>? existingTagStyle,
  }) {
    return _parser.htmlTagToTextSpan(
      style,
      existingClassStyle: existingClassStyle,
      existingTagStyle: existingTagStyle,
    );
  }

  static Map<String, TextStyle> cssToTextStyle(String style) {
    return _parser.cssToTextStyle(style);
  }
}
