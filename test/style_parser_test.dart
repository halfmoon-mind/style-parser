import 'package:flutter_test/flutter_test.dart';

import 'package:style_parser/style_parser.dart';

void main() {
  // test('cssToTextStyle_SingleTag', () {
  //   const originalText = '<p style="font-size:12pt; font-weight: 400">HI</p>';
  //   final textSpan = StyleParser.cssToTextSpan(originalText);
  //   for (var child in textSpan.children!) {
  //     expect(child.style!.fontSize, 12);
  //     expect(child.style!.fontWeight, FontWeight.w400);
  //   }
  // });

  // test('cssToTextStyle_MultiTag', () {
  //   const originalText = '<p style="font-size:12pt; font-weight: 400">HI</p>';
  //   final textSpan = StyleParser.cssToTextSpan(originalText);
  //   for (var child in textSpan.children!) {
  //     expect(child.style!.fontSize, 12);
  //     expect(child.style!.fontWeight, FontWeight.w400);
  //   }
  // });

  // test('cssToTextStyle_RecursiveTag', () {
  //   const originalText = '<p style="font-size:12pt; font-weight: 400">HI</p>';
  //   final textSpan = StyleParser.cssToTextSpan(originalText);
  //   for (var child in textSpan.children!) {
  //     expect(child.style!.fontSize, 12);
  //     expect(child.style!.fontWeight, FontWeight.w400);
  //   }
  // });
  // test('cssToTextStyle_RecursiveMultiTag', () {
  //   const originalText = '<p style="font-size:12pt; font-weight: 400">HI</p>';
  //   final textSpan = StyleParser.cssToTextSpan(originalText);
  //   for (var child in textSpan.children!) {
  //     expect(child.style!.fontSize, 12);
  //     expect(child.style!.fontWeight, FontWeight.w400);
  //   }
  // });

  test('태그 데이터 확인', () {
    const originalText = '''
<p style="padding:0;margin:0;color:#000000;font-size:11pt;font-family:&quot;Arial&quot;;line-height:1.15;orphans:2;widows:2;text-align:left">
            <span style="color:#000000;font-weight:400;text-decoration:none;vertical-align:baseline;font-size:11pt;font-family:&quot;Arial&quot;;font-style:normal">  “오케이. 여학생은 덕분에 살았네?”</span>
          </p>
''';
    final textSpan = StyleParser.cssToTextSpan(originalText);
    for (var child in textSpan.children!) {
      print("$child / ${child.toPlainText()}");
    }
  });

  test("태그 기존 정보들 추가된 경우", () {
    const originalText = '''
<h1 style="padding-bottom:10px;">ㅇㅇ</h1>
          <p>ㅇㅇㅇ</p>
''';
    final textSpan = StyleParser.cssToTextSpan(originalText);
    for (var child in textSpan.children!) {
      print("$child / ${child.toPlainText()}");
    }
  });

  test("스트롱", () {
    const originalText = '''
<p><strong>HI</strong></p>
<p><em>HI</em></p>
<p>
  <strong>
    <em>
    HI
    </em>
  </strong>
</p>
''';
    final textSpan = StyleParser.cssToTextSpan(originalText);
    for (var child in textSpan.children!) {
      print("${child.style} / ${child.toPlainText()}");
    }
  });
}
