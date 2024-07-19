import 'package:flutter/material.dart';
import 'package:style_parser/style_parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String css = """
      .bold { font-weight: bold; }
      .italic { font-style: italic; }
      .large { font-size: 24pt; }
    """;

    String html = """
      <p class="bold">This is bold text.</p>
      <p class="italic">This is italic text.</p>
      <p class="large">This is large text.</p>
    """;

    Map<String, TextStyle> styles = StyleParser.cssToTextStyle(css);
    TextSpan textSpan =
        StyleParser.htmlTagToTextSpan(html, existingClassStyle: styles);
    String target = """
<p>
<p>아니 뭐지 <strong>왜 이러지?</strong>  ㅋㅋㅋㅋ<em>ㅋㅋㅋ</em>   아아아아<strong><em>아아아아</em></strong>  오오오오ㅇ<strong> 오오오</strong></p>
</p>
""";

    String target2 = """
<?xml version='1.0' encoding='utf-8'?>
      <!DOCTYPE html>
      <html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" epub:prefix="z3998: http://www.daisy.org/z3998/2012/vocab/structure/#" lang="ko" xml:lang="ko">
        <head>
          <title>ㅇㅇ</title>
        </head>
        <body>
          <h1 style="padding-bottom:10px;">ㅇㅇ</h1>
          <p>아니 뭐지 <strong>왜 이러지?</strong>  ㅋㅋㅋㅋ<em>ㅋㅋㅋ</em>   아아아아<strong><em>아아아아</em></strong>  오오오오ㅇ<strong> 오오오</strong></p>
        </body>
      </html>
      , <?xml version='1.0' encoding='utf-8'?>
      <!DOCTYPE html>
      <html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" lang="ko" xml:lang="ko">
        <head>
          <title></title>
        </head>
        <body>
          <nav epub:type="toc" id="id" role="doc-toc">
            <h2></h2>
            <ol/>
          </nav>
        </body>
      </html>
""";

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('StyleParser Example'),
        ),
        body: Column(
          children: [
            Text.rich(textSpan),
            Text.rich(
              StyleParser.htmlTagToTextSpan(target2),
            ),
          ],
        ),
      ),
    );
  }
}
