import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:kedatonkomputer/core/bloc/cart/cart_bloc.dart';
import 'package:kedatonkomputer/core/bloc/cart/cart_event.dart';
import 'package:kedatonkomputer/core/bloc/cart/cart_state.dart';
import 'package:kedatonkomputer/core/models/cart_model.dart';
import 'package:kedatonkomputer/ui/screens/order/create_order.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/item/cart_item.dart';
import 'package:toast/toast.dart';

class CartPage extends StatefulWidget {

  const CartPage({
    Key key,
    this.cart,
  }) : super(key: key);
  
  final CartModel cart;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  var cartBloc = CartBloc();
  CartModel cart;
  var isStarting = true;

  var isDeleting = false;
  var indexDeleting = -1;
  
  var isUpdating = false;
  var indexUpdating = -1;

  @override
  void initState() {
    if(widget.cart != null) cart = widget.cart;
    cartBloc.add(LoadCarts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          cubit: cartBloc,
          listener: (context, state) {
            if(state is CartLoaded) {
              setState(() {
                cart = state.data;
                isStarting = false;
              });
            } else if(state is CartItemUpdated) {
              setState(() {
                isUpdating = false;
                indexUpdating = -1;
                cart = state.data;
                isStarting = false;
              });
            } else if(state is CartItemDeleted) {
              setState(() {
                isDeleting = false;
                indexDeleting = -1;
                cart = state.data;
                isStarting = false;
              });
            } else if (state is CartFailure) {
              setState(() {
                isDeleting = false;
                indexDeleting = -1;
                isStarting = false;
                Toast.show(state.error, context);
              });
            }
          }
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Keranjang Belanja"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(16),
                itemCount: cart?.cart?.length ?? 0,
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return CartItem(
                    cart: cart?.cart[index] ?? null,
                    isDeleting: isDeleting && indexDeleting == index,
                    isUpdating: isUpdating && indexUpdating == index,
                    onMin: () {
                      if((cart?.cart[index]?.quantity ?? 0) > 1) {
                        setState(() {
                          isUpdating = true;
                          indexUpdating = index;
                          cartBloc.add(UpdateCartItem(productId: cart?.cart[index]?.product?.id ?? "", quantity: (cart?.cart[index]?.quantity ?? 0)-1));
                        });
                      }
                    },
                    onAdd: () {
                      setState(() {
                        isUpdating = true;
                        indexUpdating = index;
                        cartBloc.add(UpdateCartItem(productId: cart?.cart[index]?.product?.id ?? "", quantity: (cart?.cart[index]?.quantity ?? 0)+1));
                      });
                    },
                    onDelete: (){
                      setState(() {
                        isDeleting = true;
                        indexDeleting = index;
                        cartBloc.add(DeleteCartItem(productId: cart?.cart[index]?.product?.id ?? ""));
                      });
                    },
                  );
                },
              ),
            ),
            Box(
              padding: 16,
              child: SafeArea(
                child: RaisedButtonPrimary(
                  text: "Beli Sekarang: ${rupiah(cart?.totalCost)}",
                  onPressed: isUpdating || isDeleting ? null : () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CreateOrderPage(cart: cart)
                    ));
                  },
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}