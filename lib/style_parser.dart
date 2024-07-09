library style_parser;

import 'package:flutter/material.dart' hide Element;
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;

part 'css_to_textstyle.dart';

class StyleParser {
  StyleParser._();

  static final _parser = _Parser.instance;

  static TextSpan cssToTextSpan(
    String style, {
    Map<String, TextStyle>? existingClassStyle,
    Map<String, TextStyle>? existingTagStyle,
  }) {
    return _parser.cssToTextStyle(
      style,
      existingClassStyle: existingClassStyle,
      existingTagStyle: existingTagStyle,
    );
  }
}
