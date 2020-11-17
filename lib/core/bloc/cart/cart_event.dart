import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCarts extends CartEvent {}

class AddToCart extends CartEvent {
  final String productId;
  final int quantity;

  const AddToCart({
    this.productId,
    this.quantity
  });

  @override
  List<Object> get props => [productId, quantity];
}

class UpdateCartItem extends CartEvent {
  final String productId;
  final int quantity;

  const UpdateCartItem({
    this.productId,
    this.quantity
  });

  @override
  List<Object> get props => [productId, quantity];
}

class DeleteCartItem extends CartEvent {
  final String productId;

  const DeleteCartItem({
    this.productId,
  });

  @override
  List<Object> get props => [productId];
}