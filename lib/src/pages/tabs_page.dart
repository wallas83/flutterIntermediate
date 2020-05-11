import 'package:flutter/material.dart';
import 'package:news_app/src/pages/tab1_page.dart';
import 'package:news_app/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class Tabspage extends StatelessWidget {
  const Tabspage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
          child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //simula un singleton
    //solo cuando se le llam de esta manera el provider escucha que decierta forma haria el rebuild para actualizar el estado
    final navegacionModel = Provider.of<_NavegacionModel>(context);
   
    // print('muestra la navegacionModel');
    // print(navegacionModel._paginaActual);
     return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual ,
      onTap: (i) => navegacionModel.paginaActual = i ,
      items: [
      BottomNavigationBarItem(
          icon: Icon(Icons.person_outline), title: Text('para ti')),
      BottomNavigationBarItem(
          icon: Icon(Icons.public), title: Text(' Encabezados'))
    ]);
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    
  final navigationModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navigationModel.pageController ,
     // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        TabHeadLine(),
        Tab2page()
      ],
    );
  }
}



class _NavegacionModel with ChangeNotifier{

  int _paginaActual = 0;
  PageController _pageController =  PageController(); 
  int get paginaActual => this._paginaActual;

  PageController get pageController => this._pageController;
  
  set paginaActual( int valor) {
    this._paginaActual = valor;
    _pageController.animateToPage(valor, duration: Duration(microseconds: 3000), curve:Curves.easeOut );    //notifica a todos los que lo escuchan
    notifyListeners();
  }
}