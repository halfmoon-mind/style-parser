import 'package:flutter/rendering.dart';
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
    final textSpan = StyleParser.htmlTagToTextSpan(originalText);
    for (var child in textSpan.children!) {
      print("$child / ${child.toPlainText()}");
    }
  });

  test("태그 기존 정보들 추가된 경우", () {
    const originalText = '''
<h1 style="padding-bottom:10px;">ㅇㅇ</h1>
          <p>ㅇㅇㅇ</p>
''';
    final textSpan = StyleParser.htmlTagToTextSpan(originalText);
    for (var child in textSpan.children!) {
      print("$child / ${child.toPlainText()}");
    }
  });

  test("스트롱", () {
    const originalText = '''
<p><strong>HI</strong></p>
<p><em>HI</em></p>
<p><strong><em>HI</em></strong></p>
''';

    StyleParser.htmlTagToTextSpan(originalText, existingTagStyle: {
      "p": const TextStyle(fontSize: 12),
    });
  });

  test("파싱 로직 검사", () {
    const originalText =
        '''ol{margin:0;padding:0}table td,table th{padding:0}.c0{color:#000000;font-weight:400;text-decoration:none;vertical-align:baseline;font-size:11pt;font-family:"Arial";font-style:normal}.c5{padding-top:0pt;padding-bottom:3pt;line-height:1.15;page-break-after:avoid;orphans:2;widows:2;text-align:left}.c4{color:#000000;font-weight:400;text-decoration:none;vertical-align:baseline;font-size:26pt;font-family:"Arial";font-style:normal}.c1{padding-top:0pt;padding-bottom:0pt;line-height:1.15;text-align:left}.c3{orphans:2;widows:2;height:11pt}.c2{background-color:#ffffff}.title{padding-top:0pt;color:#000000;font-size:26pt;padding-bottom:3pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;orphans:2;widows:2;text-align:left}.subtitle{padding-top:0pt;color:#666666;font-size:15pt;padding-bottom:16pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;orphans:2;widows:2;text-align:left}li{color:#000000;font-size:11pt;font-family:"Arial"}p{margin:0;color:#000000;font-size:11pt;font-family:"Arial"}h1{padding-top:20pt;color:#000000;font-size:20pt;padding-bottom:6pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;orphans:2;widows:2;text-align:left}h2{padding-top:18pt;color:#000000;font-size:16pt;padding-bottom:6pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;orphans:2;widows:2;text-align:left}h3{padding-top:16pt;color:#434343;font-size:14pt;padding-bottom:4pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;orphans:2;widows:2;text-align:left}h4{padding-top:14pt;color:#666666;font-size:12pt;padding-bottom:4pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;orphans:2;widows:2;text-align:left}h5{padding-top:12pt;color:#666666;font-size:11pt;padding-bottom:4pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;orphans:2;widows:2;text-align:left}h6{padding-top:12pt;color:#666666;font-size:11pt;padding-bottom:4pt;font-family:"Arial";line-height:1.15;page-break-after:avoid;font-style:italic;orphans:2;widows:2;text-align:left}
''';
    StyleParser.cssToTextStyle(originalText);
  });
}
