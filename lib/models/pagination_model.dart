class PaginationModel<T> {
  int currentPage;
  final List<T> data;
  bool nextPageUrl;

  PaginationModel({
    required this.currentPage,
    required this.data,
    required this.nextPageUrl,
  });

  factory PaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginationModel(
      currentPage: json['current_page'],
      data: List<T>.from(json['data'].map((x) => fromJsonT(x))),
      nextPageUrl: json['next_page_url'] == null ? false : true,
    );
  }
}
