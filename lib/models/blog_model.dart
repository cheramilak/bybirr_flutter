import 'dart:convert';

// Blog Model
class BlogModel {
  final int id;
  final String title;
  final String image;
  final String slug;
  final int status;
  int likeCounter;
  final int categoryId;
  bool hasLiked;
  final DateTime createdAt;
  final BlogCategory category;
  final List<BlogMessage> messages;

  BlogModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.slug,
      required this.status,
      required this.likeCounter,
      required this.categoryId,
      required this.createdAt,
      required this.category,
      required this.messages,
      required this.hasLiked});

  // Factory method to parse JSON
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      slug: json['slug'] ?? '',
      status: json['status'] ?? 0,
      likeCounter: json['likeCounter'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      hasLiked: json['has_liked'] ?? false,
      createdAt: DateTime.parse(json['created_at']), // Updated here
      category: BlogCategory.fromJson(json['category'] ?? {}),
      messages: (json['messages'] as List<dynamic>)
          .map((item) => BlogMessage.fromJson(item))
          .toList(),
    );
  }
}

// Category Model
class BlogCategory {
  final int id;
  final String name;
  final String image;

  BlogCategory(
      {required this.id,
      required this.name,
      required this.image});

  // Factory method to parse JSON
  factory BlogCategory.fromJson(Map<String, dynamic> json) {
    return BlogCategory(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        image: json['image'].toString());
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

// Message Model
class BlogMessage {
  final int id;
  final String message;
  final String image;
  final int blogId;

  BlogMessage({
    required this.id,
    required this.message,
    required this.image,
    required this.blogId,
  });

  // Factory method to parse JSON
  factory BlogMessage.fromJson(Map<String, dynamic> json) {
    return BlogMessage(
      id: json['id'] ?? 0,
      message: json['message'] ?? '',
      image: json['image'] ?? '',
      blogId: json['blog_id'] ?? 0,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'blog_id': blogId,
    };
  }
}


final demoBlog = BlogModel(
  id: 1,
  title: 'Exploring Flutter 5.0: What’s New?',
  image: 'https://example.com/images/flutter5.jpg',
  slug: 'exploring-flutter-5',
  status: 1,
  likeCounter: 120,
  categoryId: 101,
  hasLiked: true,
  createdAt: DateTime.now().subtract(Duration(days: 2)),
  category: BlogCategory(
    id: 101,
    name: 'Technology',
    image: 'https://example.com/images/flutter5.jpg'
  ),
  messages: [
    BlogMessage(
      id: 1,
      blogId: 5,
      message: 'Great article! Really informative.',
      image: ''
    ),

    BlogMessage(
      id: 1,
      blogId: 5,
      message: 'Great article! Really informative.',
      image: ''
    ),
  ],
);


final List<BlogModel> blogListDemo = List.generate(15, (index) {
  final id = index + 1;
  final titles = [
    'Exploring Flutter 5.0: What’s New?',
    'Understanding Null Safety in Dart',
    'State Management Showdown: Provider vs Riverpod',
    'Building Responsive UI in Flutter',
    'Integrating Firebase with Flutter',
    'Animations in Flutter: A Practical Guide',
    'Top 10 Flutter Packages in 2025',
    'How to Use Isolates for Background Tasks',
    'Creating Custom Widgets in Flutter',
    'Mastering Flutter Layouts',
    'Building Chat Apps with Flutter',
    'Dart Collections: Tips and Tricks',
    'Offline Storage with Hive in Flutter',
    'Theme Management in Flutter',
    'Deploying Flutter Apps to Web',
  ];

  final categoryId = 100 + (id % 3);
  final categoryNames = ['Technology', 'Development', 'Design'];
  final imageUrls = [
    'https://picsum.photos/id/$id/200/300',
    'https://picsum.photos/id/$id/200/300',
    'https://picsum.photos/id/$id/200/300',
    'https://picsum.photos/id/$id/200/300',
    'https://picsum.photos/id/$id/200/300',
    'https://picsum.photos/id/$id/200/300',
    'https://picsum.photos/id/$id/200/300',
    'https://picsum.photos/id/$id/200/300',
    'https://picsum.photos/id/$id/200/300',
    'https://picsum.photos/id/$id/200/300',
  ];

  return BlogModel(
    id: id,
    title: titles[index],
    image: imageUrls[id % 3],
    slug: titles[index].toLowerCase().replaceAll(' ', '-').replaceAll(RegExp(r'[^\w\-]'), ''),
    status: 1,
    likeCounter: 50 + id * 3,
    categoryId: categoryId,
    hasLiked: id % 2 == 0,
    createdAt: DateTime.now().subtract(Duration(days: id)),
    category: BlogCategory(
      id: categoryId,
      name: categoryNames[id % 3],
      image: imageUrls[id % 3],
    ),
    messages: [
      BlogMessage(
        id: 1,
        blogId: id,
        message: 'Great article! Really informative.',
        image: '',
      ),
      BlogMessage(
        id: 2,
        blogId: id,
        message: 'Thanks for the insights!',
        image: '',
      ),
    ],
  );
});
