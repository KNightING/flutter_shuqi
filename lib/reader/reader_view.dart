import 'package:flutter/material.dart';
import 'package:shuqi/flutter_selectable_text.dart';

import 'package:shuqi/public.dart';
import 'reader_overlayer.dart';
import 'reader_utils.dart';
import 'reader_config.dart';

class ReaderView extends StatelessWidget {
  final Article article;
  final int page;
  final double topSafeHeight;

  ReaderView({this.article, this.page, this.topSafeHeight});

  final GlobalKey<SelectableTextState> _selectableKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: Image.asset('img/read_bg.png', fit: BoxFit.cover)),
        ReaderOverlayer(
            article: article, page: page, topSafeHeight: topSafeHeight),
        buildContent(article, page),
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  print(_selectableKey.currentState.selection);
                },
                child: Text("get selection"),
              ),
              MaterialButton(
                onPressed: () {
                  var ts = TextSelection(baseOffset: 1, extentOffset: 15);
                  _selectableKey.currentState.selection = ts;
                },
                child: Text("set selection"),
              ),
            ],
          ),
        )
      ],
    );
  }

  buildContent(Article article, int page) {
    var content = article.stringAtPageIndex(page);

    if (content.startsWith('\n')) {
      content = content.substring(1);
    }
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.fromLTRB(15, topSafeHeight + ReaderUtils.topOffset, 10,
          Screen.bottomSafeHeight + ReaderUtils.bottomOffset),
      child: SelectableText(content,
          key: _selectableKey,
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontSize: fixedFontSize(ReaderConfig.instance.fontSize))),
//      child: Text.rich(
//        TextSpan(children: [TextSpan(text: content, style: TextStyle(fontSize: fixedFontSize(ReaderConfig.instance.fontSize)))]),
//        textAlign: TextAlign.justify,
//      ),
    );
  }
}
