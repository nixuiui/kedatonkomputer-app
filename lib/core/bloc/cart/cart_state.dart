import 'package:equatable/equatable.dart';
import 'package:kedatonkomputer/core/models/cart_model.dart';
import 'package:meta/meta.dart';

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object> get props => [];
}

class CartUninitialized extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartModel data;

  const CartLoaded({
    @required this.data,
  });

  @override
  List<Object> get props => [data];
}

class CartItemAdded extends CartState {
  final CartModel data;

  const CartItemAdded({
    @required this.data,
  });

  @override
  List<Object> get props => [data];
}

class CartItemUpdated extends CartState {
  final CartModel data;

  const CartItemUpdated({
    @required this.data,
  });

  @override
  List<Object> get props => [data];
}

class CartItemDeleted extends CartState {
  final CartModel data;

  const CartItemDeleted({
    @required this.data,
  });

  @override
  List<Object> get props => [data];
}

class CartFailure extends CartState {
  final String error;

  const CartFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
