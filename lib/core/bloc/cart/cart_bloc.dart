import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:kedatonkomputer/core/api/cart_api.dart';
import 'package:kedatonkomputer/core/bloc/cart/cart_event.dart';
import 'package:kedatonkomputer/core/bloc/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final api = CartApi();

  CartBloc() : super(CartUninitialized());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {

    if (event is LoadCarts) {
      yield CartLoading();
      try {
        var response = await api.loadCarts();
        yield CartLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield CartFailure(error: error.toString());
      }
    }
    
    if (event is AddToCart) {
      yield CartLoading();
      try {
        var response = await api.addToCart(product: event.productId, quantity: event.quantity);
        yield CartItemAdded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield CartFailure(error: error.toString());
      }
    }
    
    if (event is UpdateCartItem) {
      yield CartLoading();
      try {
        var response = await api.updateCartItem(product: event.productId, quantity: event.quantity);
        yield CartItemUpdated(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield CartFailure(error: error.toString());
      }
    }
    
    if (event is DeleteCartItem) {
      yield CartLoading();
      try {
        var response = await api.deleteToCart(event.productId);
        yield CartItemDeleted(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield CartFailure(error: error.toString());
      }
    }

  }
}