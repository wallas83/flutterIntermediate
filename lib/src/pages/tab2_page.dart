import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/tema.dart';
import 'package:news_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    print('is loadin al entrar');
    print(newsService.isLoading);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _ListaCategorias(),
            if (!newsService.isLoading)
              Expanded(
                  child: ListaNoticias(
                      noticias: newsService.getArticulosCategoriaSeleccionada)),
            if (newsService.isLoading)
              Expanded(
                  child: Center(
                child: CircularProgressIndicator(),
              ))
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsServices = Provider.of<NewsService>(context);
    final categorias = newsServices.categorias;
    final selectedName = newsServices.selectedCategory;
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categorias.length,
          itemBuilder: (BuildContext context, int index) {
            final cName = categorias[index].name;
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  _CategoryButtom(categoria: categorias[index]),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${cName[0].toUpperCase()}${cName.substring(1)}',
                    style: TextStyle(
                        color: (selectedName == categorias[index].name)
                            ? miTema.accentColor
                            : Colors.white),
                  )
                ],
              ),
            );
          }),
    );
  }
}

class _CategoryButtom extends StatelessWidget {
  final Category categoria;

  const _CategoryButtom({@required this.categoria});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        // cuando el provider va en un evento como Ontab u otros el liste: va el false
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == this.categoria.name)
              ? miTema.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
