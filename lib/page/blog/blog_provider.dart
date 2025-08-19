import 'package:bybirr_flutter/models/blog_model.dart';
import 'package:bybirr_flutter/models/pagination_model.dart';
import 'package:flutter/material.dart';


class BlogProvider extends ChangeNotifier {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  //final BlogRepository blogRepository = BlogRepository();
  bool _showHeart = false;
  bool get showHeart => _showHeart;
  Animation<double> get scaleAnimation => _scaleAnimation;
  PageController _pageController = PageController(viewportFraction: 1);
  BlogProvider() {
    // _pageController =
    //     PageController(viewportFraction: 1, initialPage: getCurrentIndex);
    _pageController.addListener(_onPageChanged);
  }

  initController() {
    _pageController =
        PageController(viewportFraction: 1, initialPage: getCurrentIndex);
    _pageController.addListener(_onPageChanged);
  }

  vAnimationProvider(TickerProvider vsync) {
    // Initialize AnimationController
    _controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    notifyListeners();
  }

  void onDoubleTap(int index) {
    if (paginationModel.data[index].hasLiked) {
      return;
    }
    paginationModel.data[index].hasLiked = true;
    paginationModel.data[index].likeCounter++;
    _showHeart = true;
    notifyListeners();
    _controller.forward(from: 0.0);
    Future.delayed(const Duration(milliseconds: 600), () {
      _showHeart = false;
      notifyListeners();
    });
   // blogRepository.rateBlog(paginationModel.data[index].slug);
  }

  void rateBlog(int index) {
    if (paginationModel.data[index].hasLiked) {
      paginationModel.data[index].hasLiked = false;
      paginationModel.data[index].likeCounter--;
    } else {
      paginationModel.data[index].hasLiked = true;
      paginationModel.data[index].likeCounter++;
    }
    notifyListeners();
   // blogRepository.rateBlog(paginationModel.data[index].slug);
  }

  PaginationModel<BlogModel> paginationModel =
      PaginationModel(currentPage: 0, data: [], nextPageUrl: true);
  bool isLoading = false;
  bool isLoadingNew = false;
  int currentIndex = 0;
  double scaleValue = 0.0;

  List<BlogModel> get getBlogList => paginationModel.data;
  int get getCurrentIndex => currentIndex;
  PageController get getpageController => _pageController;
  double get getScaleValue => scaleValue;
  bool get getIsLoading => isLoading;
  bool get getIsLoadingNew => isLoadingNew;

  set setCurrentIndex(int index) {
    if (index.toInt() + 2 < getBlogList.length) {
      currentIndex = index;
      notifyListeners();
    }
  }

  set setPaginationModel(PaginationModel<BlogModel> model) {
    paginationModel.data.addAll(model.data);
    paginationModel.currentPage = model.currentPage;
    notifyListeners();
  }

  fatchBloges() async {

    await Future.delayed(Duration(seconds: 3));
    setPaginationModel = PaginationModel(currentPage: 1, data: blogListDemo, nextPageUrl: false);
  //   if (paginationModel.nextPageUrl == null) {
  //     return;
  //   }

  //   if (paginationModel.currentPage! > 0) {
  //     isLoadingNew = true;
  //   } else {
  //     isLoading = true;
  //   }
  //   notifyListeners();
  //   try {
  //     var res =
  //         await blogRepository.getBloges(paginationModel.currentPage! + 1);
  //     res.fold((l) {
  //       isLoading = false;
  //       isLoadingNew = false;
  //       notifyListeners();
  //     }, (r) {
  //      // setPaginationModel = r;
  //       isLoading = false;
  //       isLoadingNew = false;
  //       notifyListeners();
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //     isLoading = false;
  //     notifyListeners();
  //   }
   }

  void _onPageChanged() {
    if (getCurrentIndex + 3 < getBlogList.length) {
      if (_pageController.position.haveDimensions) {
        scaleValue = getCurrentIndex.toDouble() - (_pageController.page ?? 0);
        scaleValue = scaleValue.abs();
        scaleValue = (scaleValue * 0.2).clamp(0, 1);

        notifyListeners();
      }
    } else {
      _pageController.keepPage;
     // fatchBloges();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
