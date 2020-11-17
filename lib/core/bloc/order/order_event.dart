import 'package:equatable/equatable.dart';
import 'package:kedatonkomputer/core/models/order_post_model.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadMyOrders extends OrderEvent {
  final String status;
  final int page;
  final int limit;
  final bool isRefresh;
  final bool isLoadMore;

  const LoadMyOrders({
    this.status = "",
    this.page,
    this.limit,
    this.isRefresh = false,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [status, page, limit, isRefresh, isLoadMore];
}

class LoadDetailOrder extends OrderEvent {
  final String id;

  const LoadDetailOrder({
    this.id
  });

  @override
  List<Object> get props => [id];
}

class CreateOrder extends OrderEvent {
  final OrderPost data;

  const CreateOrder({
    this.data
  });

  @override
  List<Object> get props => [data];
}

class CancelOrder extends OrderEvent {
  final String id;
  final String cancelReason;

  const CancelOrder({
    this.id,
    this.cancelReason,
  });

  @override
  List<Object> get props => [id, cancelReason];
}

class FinishTransaction extends OrderEvent {
  final String id;

  const FinishTransaction({
    this.id,
  });

  @override
  List<Object> get props => [id];
}