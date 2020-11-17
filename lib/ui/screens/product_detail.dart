import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:kedatonkomputer/core/bloc/cart/cart_bloc.dart';
import 'package:kedatonkomputer/core/bloc/cart/cart_event.dart';
import 'package:kedatonkomputer/core/bloc/cart/cart_state.dart';
import 'package:kedatonkomputer/core/models/product_model.dart';
import 'package:kedatonkomputer/ui/screens/cart_page.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';
import 'package:toast/toast.dart';

class ProductDetailPage extends StatefulWidget {

  const ProductDetailPage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  Product product;
  var cartBloc = CartBloc();
  var isAddingToCart = false;

  @override
  void initState() {
    product = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: cartBloc,
      listener: (context, state) {
        if(state is CartItemAdded) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => CartPage(cart: state.data)
          ));
        } else if(state is CartFailure) {
          setState(() {
            isAddingToCart = false;
            Toast.show(state.error, context);
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detail Produk")
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Box(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.grey[200],
                    borderRadius: 8,
                    image: NetworkImage(product?.images[0] ?? ""),
                  ),
                  SizedBox(height: 16),
                  TitleText(product?.name ?? "", maxLines: 3),
                  LabelText(product?.category?.name ?? ""),
                  SizedBox(height: 16),
                  TextCustom(
                    rupiah(product?.sellPrice),
                    fontSize: 24,
                    fontWeight: FontWeight.w700
                  ),
                  SizedBox(height: 16),
                  TextCustom(product?.description ?? "", maxLines: 100),
                ],
              ),
            ),
            Box(
              padding: 16,
              child: SafeArea(
                child: RaisedButtonPrimary(
                  icon: Icons.add_shopping_cart,
                  isLoading: isAddingToCart,
                  text: "Tambah ke Keranjang Belanja",
                  onPressed: () {
                    setState(() {
                      isAddingToCart = true;
                      cartBloc.add(AddToCart(productId: product?.id, quantity: 1));
                    });
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}