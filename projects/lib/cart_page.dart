import 'package:flutter/material.dart';
import 'package:projects/bo/article.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Cart with ChangeNotifier {
  List<Article> _items = [];

  List<Article> get items => _items;

  void addToCart(Article article) {
  _items.add(article);
  print('Article added: ${article.nom}');
  notifyListeners();
}

  void removeFromCart(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: Consumer<Cart>(
        builder: (context, cart, child) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Panier'),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: NotEmptyCart(
                  articles: cart.items,
                  removeArticle: cart.removeFromCart,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NotEmptyCart extends StatelessWidget {
  const NotEmptyCart({
    super.key,
    required this.articles,
    required this.removeArticle,
  });

  final List<Article> articles;
  final Function(int) removeArticle;

  @override
  Widget build(BuildContext context) {
    int total = articles.fold(0, (sum, item) => sum + item.prix);

    return Column(
      children: <Widget>[
        const Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: SvgPicture.network(
                  articles[index].image,
                  width: 40,
                ),
                title: Text(articles[index].nom),
                subtitle: Text(articles[index].getPrix()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ArticleDetailPage(article: articles[index]),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    removeArticle(index);
                  },
                ),
              );
            },
          ),
        ),
        const Divider(),
        Text('Total : ${(total / 100).toStringAsFixed(2)}€',
            style: const TextStyle(fontSize: 24)),
      ],
    );
  }
}

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  ArticleDetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.nom),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SvgPicture.network(
              article.image,
              width: 200,
            ),
            Text(article.nom, style: TextStyle(fontSize: 24)),
            Text(article.description),
            Text(article.getPrix(), style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}