// ignore_for_file: unused_field

part of 'style_parser.dart';

class _Parser {
  _Parser._();

  static final instance = _Parser._();

  TextSpan cssToTextStyle(
    String style, {
    Map<String, TextStyle>? existingClassStyle,
  }) {
    final List<Element> parsedHtml = parser.parse(style).body!.children;
    List<TextSpan> textSpans = [];
    for (var child in parsedHtml) {
      textSpans.add(tourChildText(const TextStyle(), child));
    }

    return TextSpan(children: textSpans);
  }
}

TextSpan tourChildText(TextStyle textStyle, Element html) {
  if (html.children.isEmpty) {
    return TextSpan(
      text: html.text,
      style: textStyle,
    );
  }

  List<TextSpan> children = [];
  for (var child in html.children) {
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

    children.add(tourChildText(textStyle, child));
  }

  return TextSpan(
    children: children,
    style: textStyle,
  );
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
