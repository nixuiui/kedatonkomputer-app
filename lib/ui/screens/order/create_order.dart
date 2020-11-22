import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:kedatonkomputer/core/bloc/order/order_bloc.dart';
import 'package:kedatonkomputer/core/bloc/order/order_event.dart';
import 'package:kedatonkomputer/core/bloc/order/order_state.dart';
import 'package:kedatonkomputer/core/models/cart_model.dart';
import 'package:kedatonkomputer/core/models/order_post_model.dart';
import 'package:kedatonkomputer/ui/screens/order/order_page.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/form.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';
import 'package:toast/toast.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({
    Key key,
    this.cart,
  }) : super(key: key);
  
  final CartModel cart;

  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {

  var bloc = OrderBloc();
  CartModel cart;
  var controller = TextEditingController();
  var isLoading = false;

  @override
  void initState() {
    cart = widget.cart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is OrderCreated) {
          setState(() {
            Navigator.pop(context);
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => OrderPage()
            ));
          });
        } else if (state is OrderFailure) {
          Toast.show(state.error, context);
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Buat Order"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: cart.cart.length,
                    separatorBuilder: (context, index) => Divider(height: 0), 
                    itemBuilder: (context, index) => Box(
                      padding: 16,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Box(
                            width: 60,
                            height: 60,
                            image: NetworkImage(cart.cart[index]?.product?.images[0] ?? ""),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BoldText(cart.cart[index].product.name),
                                SmallText("${cart.cart[index]?.quantity}x"),
                                TextCustom("${rupiah(cart.cart[index].product.sellPrice * cart.cart[index]?.quantity)}"),
                              ],
                            )
                          ),
                        ],
                      ),
                    ), 
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextCustom("Catatan Order"),
                        SizedBox(height: 8),
                        TextAreaBorderBottom(
                          controller: controller,
                          textHint: "Tulis catatan Anda disini",
                          minLines: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Box(
              padding: 16,
              child: SafeArea(
                child: RaisedButtonPrimary(
                  text: "Buat Order Sekarang",
                  isLoading: isLoading,
                  onPressed: isLoading ? null : () => order(),
                ),
              )
            )
          ],
        )
      ),
    );
  }

  order() {
    var order = OrderPost(
      orderNotes: controller.text,
      detailProducts: cart.cart.map((e) => DetailProduct(count: e.quantity, product: e.product.id)).toList()
    );
    bloc.add(CreateOrder(data: order));
    setState(() {
      isLoading = true;
    });
  }
}