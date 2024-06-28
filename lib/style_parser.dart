library style_parser;

import 'package:flutter/material.dart';

part 'css_to_textstyle.dart';

class StyleParser {
  StyleParser._();

  static final _parser = Parser.instance;

  static Map<String, TextStyle> cssToTextStyle(String style,
      {TextStyle? defaultStyle}) {
    return _parser.cssToTextStyle(style, defaultStyle: defaultStyle);
  }
}
