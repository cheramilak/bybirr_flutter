import 'package:bybirr_flutter/page/blog/blog_provider.dart';
import 'package:bybirr_flutter/page/blog/widgets/blog_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BlogProvider>(context, listen: false).initController();
      Provider.of<BlogProvider>(context, listen: false).fatchBloges();
      Provider.of<BlogProvider>(context, listen: false)
          .vAnimationProvider(this);
    });
  }

  updateIndex(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final blogProvider = Provider.of<BlogProvider>(context, listen: false);
      if (blogProvider.getCurrentIndex != index) {
        // blogProvider.setCurrentIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Blogs'),
        ),
        body: blogProvider.getBlogList.isEmpty
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: greenColor, size: 30),
              )
            : Stack(
                children: [
                  if (blogProvider.getCurrentIndex + 2 <
                      blogProvider.getBlogList.length)
                    Positioned.fill(
                      top: 5,
                      left: 30,
                      right: 30,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: BlogWidget(
                          blogModel: blogProvider
                              .getBlogList[blogProvider.getCurrentIndex + 2],
                          index: blogProvider.getCurrentIndex + 2,
                        ),
                      ),
                    ),
                  if (blogProvider.getCurrentIndex + 1 <
                      blogProvider.getBlogList.length)
                    Positioned.fill(
                      top: 15,
                      left: 10,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: transparentColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: BlogWidget(
                          blogModel: blogProvider
                              .getBlogList[blogProvider.getCurrentIndex + 1],
                          index: blogProvider.getCurrentIndex + 1,
                        ),
                      ),
                    ),
                  Positioned.fill(
                      top: 30,
                      child: PageView.builder(
                        itemCount: blogProvider.getBlogList.length,
                        //scrollBehavior: ,
                        reverse: true,
                        controller: blogProvider.getpageController,
                        onPageChanged: (value) {
                          blogProvider.setCurrentIndex = value;
                        },
                        // physics: blogProvider.getCurrentIndex + 3 >=
                        //         blogProvider.getBlogList.length
                        //     ? const NeverScrollableScrollPhysics()
                        //     : null,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return BlogWidget(
                            blogModel: blogProvider.getBlogList[index],
                            index: index,
                          );
                        },
                      )),
                ],
              ));
  }
}
