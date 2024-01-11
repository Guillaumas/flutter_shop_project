import 'dart:math';

class Article {
  String nom;
  String description;
  int prix;
  String image;
  String categorie;

  Article({
    required this.nom,
    required this.description,
    required this.prix,
    required this.image,
    required this.categorie,
  });

  String getPrix() => "${(prix / 100).toStringAsFixed(2)}€";


  String getNom() {
    return nom;
  }

  Map<String, dynamic> toJson() => {
        'nom': nom,
        'description': description,
        'prix': prix,
        'image': image,
        'categorie': categorie
      };

  Article.fromJson(Map<String, dynamic> json)
      : nom = json['nom'],
        description = json['description'],
        prix = json['prix'],
        image = json['image'],
        categorie = json['categorie'];




  static List<Article> articleGenerator(int count) {
    Random random = Random();
    List<Article> articles = [];

    List<Map<String, dynamic>> fruits = [
      {"nom": "Pomme", "image": "apple.svg"},
      {"nom": "Abricot", "image": "apricot.svg"},
      {"nom": "Avocat", "image": "avocado.svg"},
      {"nom": "Banane", "image": "banana.svg"},
      {"nom": "Myrtille", "image": "bilberry.svg"},
      {"nom": "Mûre", "image": "blackberry.svg"},
      {"nom": "Cassis", "image": "blackcurrant.svg"},
      {"nom": "Orange sanguine", "image": "bloodorange.svg"},
      {"nom": "Myrtille", "image": "blueberry.svg"},
      {"nom": "Mûre de Boysen", "image": "boysenberry.svg"},
      {"nom": "Fruit à pain", "image": "breadfruit.svg"},
      {"nom": "Cantaloup", "image": "cantaloupe.svg"},
      {"nom": "Chérimole", "image": "cherimoya.svg"},
      {"nom": "Cerise", "image": "cherry.svg"},
      {"nom": "Clémentine", "image": "clementine.svg"},
      {"nom": "Chicouté", "image": "cloudberry.svg"},
      {"nom": "Noix de coco", "image": "coconut.svg"},
      {"nom": "Canneberge", "image": "cranberry.svg"},
      {"nom": "Groseille", "image": "currant.svg"},
      {"nom": "Prune Damas", "image": "damson.svg"},
      {"nom": "Datte", "image": "date.svg"},
      {"nom": "Fruit du dragon", "image": "dragonfruit.svg"},
      {"nom": "Durian", "image": "durian.svg"},
      {"nom": "Baie de sureau", "image": "elderberry.svg"},
      {"nom": "Feijoa", "image": "feijoa.svg"},
      {"nom": "Figue", "image": "fig.svg"},
      {"nom": "Baie de goji", "image": "gojiberry.svg"},
      {"nom": "Groseille maquereau", "image": "gooseberry.svg"},
      {"nom": "Fruit de la passion", "image": "passionfruit.svg"},
      {"nom": "Pêche", "image": "peach.svg"},
      {"nom": "Poire", "image": "pear.svg"},
      {"nom": "Kaki", "image": "persimmon.svg"},
      {"nom": "Ananas", "image": "pineapple.svg"},
      {"nom": "Prune", "image": "plum.svg"},
      {"nom": "Grenade", "image": "pomegranate.svg"},
      {"nom": "Pomelo", "image": "pomelo.svg"},
      {"nom": "Coing", "image": "quince.svg"},
      {"nom": "Kiwi", "image": "kiwi.svg"},
      {"nom": "Kumquat", "image": "kumquat.svg"},
      {"nom": "Citron", "image": "lemon.svg"},
      {"nom": "Citron vert", "image": "lime.svg"},
      {"nom": "Nèfle", "image": "loquat.svg"},
      {"nom": "Litchi", "image": "lychee.svg"},
      {"nom": "Mandarine", "image": "mandarine.svg"},
      {"nom": "Mangue", "image": "mango.svg"},
      {"nom": "Mangoustan", "image": "mangosteen.svg"},
      {"nom": "Mûre", "image": "mulberry.svg"},
      {"nom": "Nectarine", "image": "nectarine.svg"},
      {"nom": "Orange", "image": "orange.svg"},
      {"nom": "Papaye", "image": "papaya.svg"},
      {"nom": "Pêche", "image": "peach.svg"},
      {"nom": "Poire", "image": "pear.svg"},
      {"nom": "Kaki", "image": "persimmon.svg"},
      {"nom": "Ananas", "image": "pineapple.svg"},
      {"nom": "Prune", "image": "plum.svg"},
      {"nom": "Grenade", "image": "pomegranate.svg"},
      {"nom": "Pomelo", "image": "pomelo.svg"},
      {"nom": "Coing", "image": "quince.svg"},
      {"nom": "Ramboutan", "image": "rambutan.svg"},
      {"nom": "Framboise", "image": "raspberry.svg"},
      {"nom": "Groseille rouge", "image": "redcurrant.svg"},
      {"nom": "Satsuma", "image": "satsuma.svg"},
      {"nom": "Carambole", "image": "starfruit.svg"},
      {"nom": "Fraise", "image": "strawberry.svg"},
      {"nom": "Mandarine", "image": "tangerine.svg"},
      {"nom": "Pastèque", "image": "watermelon.svg"}
    ];

    for (int i = 0; i < count; i++) {
      int index = random.nextInt(fruits.length);
      var fruit = fruits[index];
      articles.add(Article(
        nom: fruit['nom'],
        description: "Description pour ${fruit['nom']}",
        prix: random.nextInt(500) + 100,
        image: "https://github.com/aisamanra/fruit-icons/blob/🍌/images/${fruit['image']}?raw=true",
        categorie: "Fruit",
      ));
    }
    return articles;
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': this.nom,
      'description': this.description,
      'prix': this.prix,
      'image': this.image,
      'categorie': this.categorie,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      nom: map['title'] as String,
      description: map['description'] as String,
      prix: map['price'] as int,
      image: map['image'] as String,
      categorie: map['category'] as String,
    );
  }
}

void main() {
  List<Article> articles = [];
  articles.add(Article(
      nom: "Pomme",
      description: "Fruit",
      prix: 100,
      image: "pomme.jpg",
      categorie: "Fruit"));
  Map<String, dynamic> JsonArticle = articles[0].toJson();
  Article articleFromJson = new Article.fromJson(JsonArticle);

  print(articles[0].getNom());
  print(articleFromJson.getPrix());
  print(JsonArticle['description']);
}
