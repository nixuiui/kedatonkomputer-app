import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {
  final String search;
  final int page;
  final int limit;
  final bool isRefresh;
  final bool isLoadMore;

  const LoadProducts({
    this.search = "",
    this.page,
    this.limit,
    this.isRefresh = false,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [search, page, limit, isRefresh, isLoadMore];
}

class LoadProductDetail extends ProductEvent {
  final String id;

  const LoadProductDetail({
    this.id
  });

  @override
  List<Object> get props => [id];
}