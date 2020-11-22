import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:kedatonkomputer/core/api/order_api.dart';
import 'package:kedatonkomputer/core/bloc/order/order_event.dart';
import 'package:kedatonkomputer/core/bloc/order/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final api = OrderApi();

  OrderBloc() : super(OrderUninitialized());

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {

    if (event is LoadMyOrders) {
      yield OrderLoading();
      try {
        var response = await api.getOrders();
        yield OrderLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield OrderFailure(error: error.toString());
      }
    }
    
    if (event is LoadDetailOrder) {
      yield OrderLoading();
      try {
        var response = await api.detailOrder(event.id);
        yield OrderDetailLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield OrderFailure(error: error.toString());
      }
    }
    
    if (event is CreateOrder) {
      yield OrderLoading();
      try {
        await api.createOrder(event.data);
        yield OrderCreated();
      } catch (error) {
        print("ERROR: $error");
        yield OrderFailure(error: error.toString());
      }
    }
    
    if (event is CancelOrder) {
      yield OrderLoading();
      try {
        await api.cancelOrder(id: event.id, cancelReason: event.cancelReason);
        yield OrderCanceled();
      } catch (error) {
        print("ERROR: $error");
        yield OrderFailure(error: error.toString());
      }
    }
    
    if (event is FinishTransaction) {
      yield OrderLoading();
      try {
        await api.transactionDone(event.id);
        yield TransactionFinished();
      } catch (error) {
        print("ERROR: $error");
        yield OrderFailure(error: error.toString());
      }
    }

  }
}