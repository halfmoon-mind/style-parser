// ignore_for_file: unused_field

part of 'style_parser.dart';

/// Internal parser class for handling the conversion logic.
class _Parser {
  _Parser._();

  static final instance = _Parser._();

  /// Converts an HTML string with styles to a TextSpan.
  ///
  /// * [style] parameter is the HTML string to be converted.
  /// * [existingClassStyle] parameter is an optional map of class styles.
  /// * [existingTagStyle] parameter is an optional map of tag styles.
  TextSpan htmlTagToTextSpan(
    String style, {
    Map<String, TextStyle>? existingClassStyle,
    Map<String, TextStyle>? existingTagStyle,
  }) {
    final classStyle = existingClassStyle ?? {};
    // remove . and # from the class and id selectors
    for (var key in classStyle.keys.toList()) {
      if (key.startsWith('.')) {
        final newKey = key.substring(1);
        classStyle[newKey] = classStyle.remove(key)!;
      }
    }
    return _htmlTagToTextSpan(
      style,
      existingClassStyle: existingClassStyle,
      existingTagStyle: existingTagStyle,
    );
  }

  /// Converts a CSS string to a map of TextStyle objects.
  ///
  /// * [style] parameter is the CSS string to be converted.
  Map<String, TextStyle> cssToTextStyle(String style) {
    return _getTextStyleFromCss(style);
  }
}

/// Parses a CSS string and converts it into a map of TextStyle objects.
Map<String, TextStyle> _getTextStyleFromCss(String style) {
  Map<String, TextStyle> result = {};
  RegExp exp = RegExp(r'([a-zA-Z0-9\.\#]+)\s*\{([^}]*)\}');
  Iterable<Match> matches = exp.allMatches(style);

  if (matches.isEmpty) {
    return result;
  }

  for (Match match in matches) {
    String selector = match.group(1)!;
    String properties = match.group(2)!;
    TextStyle textStyle = const TextStyle();

    final fontWeight = RegExp(r'font-weight:[ ]?(\w+);?')
        .firstMatch(properties)
        ?.group(1)
        ?.trim();
    if (fontWeight != null) {
      textStyle =
          textStyle.copyWith(fontWeight: _FontWeight.fontWeight(fontWeight));
    }

    final size = RegExp(r'font-size:[ ]?(\d+)pt;?')
        .firstMatch(properties)
        ?.group(1)
        ?.trim();
    if (size != null) {
      textStyle = textStyle.copyWith(fontSize: double.parse(size));
    }

    // font color
    final color = RegExp(r'color:[ ]?#([0-9a-fA-F]{6});?')
        .firstMatch(properties)
        ?.group(1)
        ?.trim();
    if (color != null) {
      textStyle = textStyle.copyWith(color: Color(int.parse('0xFF$color')));
    }

    final fontStyle = RegExp(r'font-style:[ ]?(\w+);?')
        .firstMatch(properties)
        ?.group(1)
        ?.trim();
    if (fontStyle != null) {
      textStyle = textStyle.copyWith(
        fontStyle: fontStyle == 'italic' ? FontStyle.italic : FontStyle.normal,
      );
    }

    // font family
    final family =
        RegExp(r'font-family:[ ]?(\d+);?').firstMatch(style)?.group(1)?.trim();
    if (color != null) {
      textStyle = textStyle.merge(
        TextStyle(
          fontFamily: family,
        ),
      );
    }

    if (textStyle != const TextStyle()) {
      result[selector] = textStyle;
    }
  }
  return result;
}

/// Utility enum for converting CSS font-weight values to Flutter FontWeight.
enum _FontWeight {
  w100,
  w200,
  w300,
  w400,
  w500,
  w600,
  w700,
  w800,
  w900;

  /// Converts a string representation of font-weight to a Flutter FontWeight.
  ///
  /// * [fontWeight] parameter is the font-weight string to be converted.
  static FontWeight fontWeight(String fontWeight) {
    switch (fontWeight) {
      case 'w100':
      case '100':
        return FontWeight.w100;
      case 'w200':
      case '200':
        return FontWeight.w200;
      case 'w300':
      case '300':
        return FontWeight.w300;
      case 'w400':
      case '400':
      case 'normal':
        return FontWeight.w400;
      case 'w500':
      case '500':
      case 'medium':
        return FontWeight.w500;
      case 'w600':
      case '600':
      case 'semi-bold':
        return FontWeight.w600;
      case 'w700':
      case '700':
      case 'bold':
        return FontWeight.w700;
      case 'w800':
      case '800':
      case 'extra-bold':
        return FontWeight.w800;
      case 'w900':
      case '900':
      case 'black':
        return FontWeight.w900;
      default:
        return FontWeight.w400;
    }
  }
}
