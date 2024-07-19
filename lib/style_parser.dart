library style_parser;

import 'package:flutter/material.dart' hide Element;
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;

part 'css_to_textstyle.dart';
part 'html_tag_to_textspan.dart';

/// A utility class for parsing CSS and HTML to Flutter TextStyle and TextSpan.
/// It should be used as a static class.
class StyleParser {
  StyleParser._();

  static final _parser = _Parser.instance;

  /// Converts an HTML string with styles to a TextSpan.
  ///
  /// * [style] parameter is the HTML string to be converted.
  /// * [existingClassStyle] parameter is an optional map of class styles.
  /// * [existingTagStyle] parameter is an optional map of tag styles.
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

  /// Converts a CSS string to a map of TextStyle objects.
  ///
  /// * [style] parameter is the CSS string to be converted.
  static Map<String, TextStyle> cssToTextStyle(String style) {
    return _parser.cssToTextStyle(style);
  }
}
