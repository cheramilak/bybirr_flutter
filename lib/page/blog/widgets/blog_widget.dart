import 'package:bybirr_flutter/models/blog_model.dart';
import 'package:bybirr_flutter/page/blog/blog_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class BlogWidget extends StatefulWidget {
  final BlogModel blogModel;
  final int index;
  const BlogWidget({super.key, required this.blogModel, required this.index});

  @override
  State<BlogWidget> createState() => _BlogWidgetState();
}

class _BlogWidgetState extends State<BlogWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final BlogProvider blogProvider = Provider.of<BlogProvider>(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: widget.blogModel.image.isEmpty
                ? size.height * 0.15
                : size.height * 0.23,
            child: Stack(
              children: [
                // Background image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "${widget.blogModel.image.isEmpty ? widget.blogModel.category.image : widget.blogModel.image}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Top-to-bottom gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.04), // Dark at the top
                        Colors.white
                            .withOpacity(0.8), // Transparent at the bottom
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                // Bottom-aligned content
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left container
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            '${widget.blogModel.category.name}',
                            style: TextStyle(color: white),
                          ),
                        ),
                        // Right container
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.only(
                              top: 8, left: 12, right: 12, bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '${widget.blogModel.likeCounter}',
                                style: TextStyle(color: black),
                              ),
                              3.width,
                              Icon(
                                widget.blogModel.hasLiked
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                size: 18,
                                color: widget.blogModel.hasLiked
                                    ? redColor
                                    : isDark
                                        ? black
                                        : black,
                              ).onTap(() {
                               // blogProvider.rateBlog(widget.index);
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          12.height,
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                widget.blogModel.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
          12.height,
          Expanded(
            flex: 1,
            child: PageView.builder(
                itemCount: widget.blogModel.messages.length,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                        child: GestureDetector(
                          onDoubleTap: () {
                            //blogProvider.onDoubleTap(widget.index);
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 5, right: 5, bottom: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(width: 0.8, color: purple)),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0.0, vertical: 0.0),
                                child: widget
                                        .blogModel.messages[index].image.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 5.0),
                                        child: SingleChildScrollView(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          child: Text(
                                            widget.blogModel.messages[index]
                                                .message,
                                            style: theme.textTheme.bodySmall,
                                            //textAlign: TextAlign.justify,
                                            // Justify text for a clean block appearance
                                          ).paddingAll(10),
                                        ),
                                      )
                                    : PhotoViewGallery.builder(
                                        itemCount: 1,
                                        builder: (context, indexImage) {
                                          return PhotoViewGalleryPageOptions
                                              .customChild(
                                            child: GestureDetector(
                                              onDoubleTap: () {
                                                blogProvider
                                                    .onDoubleTap(widget.index);
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: PhotoView(
                                                  imageProvider:
                                                      CachedNetworkImageProvider(
                                                          "${widget.blogModel.messages[index].image}"),
                                                  backgroundDecoration:
                                                      const BoxDecoration(),
                                                  minScale:
                                                      PhotoViewComputedScale
                                                          .contained,
                                                  maxScale:
                                                      PhotoViewComputedScale
                                                              .covered *
                                                          2,
                                                  disableGestures: true,
                                                  enablePanAlways: false,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        scrollPhysics: BouncingScrollPhysics(),
                                        backgroundDecoration: BoxDecoration(
                                            color: Colors.transparent),
                                        pageController:
                                            PageController(initialPage: 0),
                                      )),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 30,
                          top: -13,
                          child: CircleAvatar(
                            radius: 15,
                            child: Text(
                              '${index + 1}/${widget.blogModel.messages.length}',
                              style: TextStyle(fontSize: 10),
                            ),
                          )),
                      Positioned(
                          right: 30,
                          bottom: -3,
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              DateFormat.yMMMd()
                                  .format(widget.blogModel.createdAt),
                              style: TextStyle(fontSize: 11),
                            ),
                          )),
                      if (blogProvider.showHeart)
                        Center(
                          child: ScaleTransition(
                            scale: blogProvider.scaleAnimation,
                            child: const Icon(
                              Icons.favorite_outline,
                              color: Colors.red,
                              size: 100,
                            ),
                          ),
                        ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
