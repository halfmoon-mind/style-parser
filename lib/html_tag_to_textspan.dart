part of 'style_parser.dart';

TextSpan _htmlTagToTextSpan(
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

/// Recursively converts an HTML element and its children to a TextSpan.
TextSpan _tourChildText(
  TextStyle textStyle,
  Element html, [
  Map<String, TextStyle>? existingClassStyle,
  Map<String, TextStyle>? existingTagStyle,
]) {
  // when the element is a text node
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
          backgroundColor: tagStyle.backgroundColor,
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
            backgroundColor: classStyle.backgroundColor,
          );
        }
      }
    }

    final style = html.attributes['style'] ?? "";

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

    if (html.localName == "strong") {
      textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
    }
    if (html.localName == "b") {
      textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
    }
    if (html.localName == "em") {
      textStyle = textStyle.copyWith(fontStyle: FontStyle.italic);
    }
    if (html.localName == "i") {
      textStyle = textStyle.copyWith(fontStyle: FontStyle.italic);
    }
    if (html.localName == "u") {
      textStyle = textStyle.copyWith(decoration: TextDecoration.underline);
    }
    if (html.localName == "strike") {
      textStyle = textStyle.copyWith(decoration: TextDecoration.lineThrough);
    }
    if (html.localName == "del") {
      textStyle = textStyle.copyWith(decoration: TextDecoration.lineThrough);
    }
    if (html.localName == "s") {
      textStyle = textStyle.copyWith(decoration: TextDecoration.lineThrough);
    }

    return TextSpan(
      text: html.text,
      style: textStyle,
    );
  }

  List<TextSpan> children = [];
  final nodeList = html.nodes;
  for (var node in nodeList) {
    if (node.nodeType == Node.TEXT_NODE) {
      children.add(TextSpan(text: node.text, style: textStyle));
    } else {
      final element = node as Element;
      if (element.localName == "br") {
        children.add(const TextSpan(text: "\n"));
        continue;
      }
      children.add(_tourChildText(textStyle, element));
    }
  }

  return TextSpan(children: children);
}
