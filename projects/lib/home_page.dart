import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:projects/cart_page.dart';
import 'package:projects/bo/article.dart';
import 'package:projects/article_detail_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Article> articles = Article.articleGenerator(100);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shop'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                Navigator.pushNamed(context,'/info');
              },
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context,'/cart');
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(articles[index].nom),
                subtitle: Text(articles[index].getPrix()),
                leading: SvgPicture.network(articles[index].image, width: 40),
                trailing: IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    Provider.of<Cart>(context, listen: false)
                        .addToCart(articles[index], context);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleDetailPage(article: articles[index]),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

//body: Column(
//             children: [
//               FutureBuilder<List<Article>>(
//               future: fetchListArticles(),
//                   builder: (context, snapshot) =>
//                   snapshot.hasData ?
//                   ListView.separated(
//                     itemCount: snapshot.data!.length,
//                     separatorBuilder: (_, __) => const Divider(),
//                     itemBuilder: (context,int index) =>
//                         ItemArticle(article: snapshot.data![index])),
//                       : const Icon(Icons.error)
//               ),
//             ],
//           ),
//
// Future<List<Article>> fetchListArticles() async {
//   final response = await get(Uri.parse('https://fakestoreapi.com/products'));
//   if (response.statusCode == 200 && response.body.isNotEmpty) {
//     final listMapArticles = jsonDecode(response.body) as List<dynamic>;
//     return listMapArticles.map((article) => Article.fromMap(article)).toList();

//   else {
//     throw Exception('Failed to load album');

