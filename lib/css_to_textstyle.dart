// ignore_for_file: unused_field

part of 'style_parser.dart';

class _Parser {
  _Parser._();

  static final instance = _Parser._();

  TextSpan htmlTagToTextSpan(
    String style, {
    Map<String, TextStyle>? existingClassStyle,
    Map<String, TextStyle>? existingTagStyle,
  }) {
    final List<Element> parsedHtml = parser.parse(style).body!.children;
    List<TextSpan> textSpans = [];
    for (var child in parsedHtml) {
      textSpans.add(_tourChildText(
        const TextStyle(),
        child,
        existingClassStyle,
        existingTagStyle,
      ));
    }

    return TextSpan(children: textSpans);
  }

  Map<String, TextStyle> cssToTextStyle(String style) {
    return _getTextStyleFromCss(style);
  }
}

TextSpan _tourChildText(
  TextStyle textStyle,
  Element html, [
  Map<String, TextStyle>? existingClassStyle,
  Map<String, TextStyle>? existingTagStyle,
]) {
  if (html.children.isEmpty) {
    if (existingTagStyle != null) {
      final localName = html.localName;
      final tagStyle = existingTagStyle[localName];
      if (tagStyle != null) {
        textStyle = textStyle.copyWith(
          fontSize: tagStyle.fontSize,
          fontWeight: tagStyle.fontWeight,
          color: tagStyle.color,
          fontStyle: tagStyle.fontStyle,
        );
      }
    }

    if (existingClassStyle != null) {
      final className = (html.attributes['class'] ?? "").split(' ');
      for (final name in className) {
        final classStyle = existingClassStyle[name];
        if (classStyle != null) {
          textStyle = textStyle.copyWith(
            fontSize: classStyle.fontSize,
            fontWeight: classStyle.fontWeight,
            color: classStyle.color,
            fontStyle: classStyle.fontStyle,
          );
        }
      }
    }

    if (html.localName == "strong") {
      textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
    }
    if (html.localName == "em") {
      textStyle = textStyle.copyWith(fontStyle: FontStyle.italic);
    }

    return TextSpan(
      text: html.text,
      style: textStyle,
    );
  }

  List<TextSpan> children = [];
  for (var child in html.children) {
    if (child.localName == "br") {
      children.add(const TextSpan(text: "\n"));
      continue;
    }

    if (existingTagStyle != null) {
      final localName = html.localName;
      final tagStyle = existingTagStyle[localName];
      if (tagStyle != null) {
        textStyle = textStyle.copyWith(
          fontSize: tagStyle.fontSize,
          fontWeight: tagStyle.fontWeight,
          color: tagStyle.color,
          fontStyle: tagStyle.fontStyle,
        );
      }
    }

    if (existingClassStyle != null) {
      final className = (html.attributes['class'] ?? "").split(' ');
      for (final name in className) {
        final classStyle = existingClassStyle[name];
        if (classStyle != null) {
          textStyle = textStyle.copyWith(
            fontSize: classStyle.fontSize,
            fontWeight: classStyle.fontWeight,
            color: classStyle.color,
            fontStyle: classStyle.fontStyle,
          );
        }
      }
    }

    final style = child.attributes['style'] ?? "";

    // font size
    final size =
        RegExp(r'font-size:[ ]?(\d+)pt;?').firstMatch(style)?.group(1)?.trim();
    if (size != null) {
      textStyle = textStyle.merge(
        TextStyle(fontSize: double.parse(size)),
      );
    }

    // font weight
    final fontWeight =
        RegExp(r'font-weight:[ ]?(\d+);?').firstMatch(style)?.group(1)?.trim();
    if (fontWeight != null) {
      textStyle = textStyle.merge(
        TextStyle(
          fontWeight: _FontWeight.fontWeight(fontWeight),
        ),
      );
    }

    // font color
    final color = RegExp(r'color:[ ]?#([0-9a-fA-F]{6});?')
        .firstMatch(style)
        ?.group(1)
        ?.trim();
    if (color != null) {
      textStyle = textStyle.merge(
        TextStyle(
          color: Color(int.parse('0xFF$color')),
        ),
      );
    }

    if (child.localName == "strong") {
      textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
    }
    if (child.localName == "em") {
      textStyle = textStyle.copyWith(fontStyle: FontStyle.italic);
    }

    children.add(_tourChildText(textStyle, child));
  }

  return TextSpan(
    children: children,
    style: textStyle,
  );
}

Map<String, TextStyle> _getTextStyleFromCss(String style) {
  Map<String, TextStyle> result = {};
  RegExp exp = RegExp(r'([a-zA-Z0-9\.\#]+)\s*\{([^}]*)\}');
  Iterable<Match> matches = exp.allMatches(style);

  for (Match match in matches) {
    String selector = match.group(1)!;
    String properties = match.group(2)!;
    TextStyle textStyle = const TextStyle();

    final fontWeight = RegExp(r'font-weight:[ ]?(\d+);?')
        .firstMatch(properties)
        ?.group(1)
        ?.trim();
    if (fontWeight != null) {
      textStyle = textStyle
          .merge(TextStyle(fontWeight: _FontWeight.fontWeight(fontWeight)));
    }

    final size =
        RegExp(r'font-size:[ ]?(\d+)pt;?').firstMatch(style)?.group(1)?.trim();
    if (size != null) {
      textStyle = textStyle.merge(TextStyle(fontSize: double.parse(size)));
    }

    // font color
    final color = RegExp(r'color:[ ]?#([0-9a-fA-F]{6});?')
        .firstMatch(properties)
        ?.group(1)
        ?.trim();
    if (color != null) {
      textStyle = textStyle.merge(
        TextStyle(color: Color(int.parse('0xFF$color'))),
      );
    }
    result[selector] = textStyle;
  }
  return result;
}

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
