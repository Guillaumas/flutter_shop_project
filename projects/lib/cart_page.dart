import 'package:flutter/material.dart';
import 'package:projects/bo/article.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:projects/article_detail_page.dart';

class Cart with ChangeNotifier {
  final List<Article> _items = [];

  List<Article> get items => _items;

  void addToCart(Article article, BuildContext context) {
    _items.add(article);
    SnackBar snackBar = SnackBar(
      content: Text('Article ajouté: ${article.nom}'),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print('Article added: ${article.nom}');
    notifyListeners();
  }

  void removeFromCart(int index, BuildContext context) {
    _items.removeAt(index);
    SnackBar snackBar = const SnackBar(
      content: Text('Article supprimé'),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    notifyListeners();
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Panier'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: cart.items.length > 0 ? NotEmptyCart(
                articles: cart.items,
                removeArticle: cart.removeFromCart,
              ) : EmptyCart(),
            ),
          ),
        );
      },
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
  final Function(int, BuildContext) removeArticle;

  @override
  Widget build(BuildContext context) {
    int total = articles.fold(0, (sum, item) => sum + item.prix);

    void removeArticleWrapper(int index) {
      removeArticle(index, context);
    }

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
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    removeArticleWrapper(index);
                  },
                ),
              );
            },
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Total : ${(total / 100).toStringAsFixed(2)}€',
                style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                minimumSize: const Size(200, 50),
              ),
              onPressed: () {

              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.shopping_cart),
                  SizedBox(width: 10),
                  Text('Valider le panier'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          const Text(
            'Votre panier est vide \n Ajoutez des articles ! 😄',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,
              minimumSize: const Size(200, 50),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: const Text(
              'Ajouter des articles',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
