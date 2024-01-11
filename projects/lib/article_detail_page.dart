import 'package:flutter/material.dart';
import 'package:projects/bo/article.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:projects/cart_page.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    int countInCart = cart.items.where((item) => item == article).length;
    bool inCart = countInCart > 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(article.nom),
      ),
      body: Column(
          children: <Widget>[
            SvgPicture.network(
              article.image,
              width: 200,
            ),
            Text(article.nom, style: const TextStyle(fontSize: 24)),
            Text(article.description),
            Text(article.getPrix(), style: const TextStyle(fontSize: 24)),
            Center(
              child: inCart
                  ? Column(
                  children: [
                    Text('Quantity in Cart: $countInCart'),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            cart.addToCart(article, context);
                          },
                          child: const Text('Add to Cart'),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            cart.removeFromCart(cart.items.indexOf(article), context);
                          },
                          child: const Text('Remove from Cart'),
                        ),
                      ],
                    ),
                  ],
                )
              :
                ElevatedButton(
                  onPressed: () {
                    cart.addToCart(article, context);
                  },
                  child: const Text('Add to Cart'),
                ),
            ),
          ],
        ),
      );
  }
}