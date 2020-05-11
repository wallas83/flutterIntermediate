import 'package:flutter/material.dart';

import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class TabHeadLine extends StatefulWidget {
  const TabHeadLine({Key key}) : super(key: key);

  @override
  _TabHeadLineState createState() => _TabHeadLineState();
}

class _TabHeadLineState extends State<TabHeadLine> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final headtline = Provider.of<NewsService>(context).headtlines;
    return Scaffold(
        body: (headtline.length == 0)
            ? Center( child: CircularProgressIndicator(),)
            : ListaNoticias(noticias: headtline));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
