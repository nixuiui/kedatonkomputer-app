import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:kedatonkomputer/core/bloc/order/order_bloc.dart';
import 'package:kedatonkomputer/core/bloc/order/order_event.dart';
import 'package:kedatonkomputer/core/bloc/order/order_state.dart';
import 'package:kedatonkomputer/core/models/order_model.dart';
import 'package:kedatonkomputer/ui/screens/order/cancel_order.dart';
import 'package:kedatonkomputer/ui/screens/order/review_order.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/loading.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';

class OrderDetailPage extends StatefulWidget {

  const OrderDetailPage({
    Key key,
    this.id,
  }) : super(key: key);
  
  final String id;

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {

  var bloc = OrderBloc();
  OrderModel order;
  var isAccepting = false;
  var isStarting = true;

  @override
  void initState() {
    bloc.add(LoadDetailOrder(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          cubit: bloc,
          listener: (context, state) {
            if(state is OrderDetailLoaded) {
              setState(() {
                order = state.data;
                isStarting = false;
              });
            } else if(state is OrderCanceled) {
              bloc.add(LoadDetailOrder(id: order.id));
            } else if(state is TransactionFinished) {
              bloc.add(LoadDetailOrder(id: order.id));
            } else if(state is OrderReviewed) {
              bloc.add(LoadDetailOrder(id: order.id));
            }
          }
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detail Order"),
        ),
        body: isStarting ? Center(child: LoadingCustom()) : ListView(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: order.detailProducts.length,
              separatorBuilder: (context, index) => Divider(height: 0), 
              itemBuilder: (context, index) => Box(
                padding: 16,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (order?.detailProducts[index]?.product?.images?.length ?? 0) > 0 ? Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Box(
                        width: 60,
                        height: 60,
                        image: NetworkImage(order?.detailProducts[index]?.product?.images[0] ?? ""),
                      ),
                    ) : Container(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustom(
                            order?.detailProducts[index]?.product?.name ?? "",
                            maxLines: 3,
                          ),
                          SmallText("${order?.detailProducts[index]?.count ?? ''}x"),
                          TextCustom("${rupiah(order?.detailProducts[index]?.price ?? '')}"),
                        ],
                      )
                    ),
                  ],
                ),
              ), 
            ),
            Divider(height: 0),
            SizedBox(height: 16),
            Divider(height: 0),
            Box(
              padding: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  LabelText("Metode Pembayaran"),
                  TextCustom(order?.paymentMethod?.toUpperCase() ?? ""),
                  SizedBox(height: 12),
                  LabelText("Status"),
                  TextCustom(order?.statusTransaction?.toUpperCase()?.replaceAll("-", " ") ?? ""),
                  SizedBox(height: 12),
                  LabelText("Total Bayar"),
                  TextCustom(rupiah(order?.totalPrice)),
                  SizedBox(height: 12),
                  LabelText("Catatan"),
                  TextCustom(order?.orderNotes ?? "-"),
                  order?.cancelReason != null && order?.cancelReason != "" ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12),
                      LabelText("Alasan Dibatalkan"),
                      TextCustom(order?.cancelReason ?? "-"),
                    ],
                  ) : Container(),
                ],
              )
            ),
            Divider(height: 0),
            SizedBox(height: 16),
            order?.statusTransaction == "menunggu-konfirmasi" ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 0),
                Box(
                  padding: 16,
                  child: ErrorText("Cancel Order"),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CancelOrderPage(order: order, bloc: bloc)
                  )),
                ),
                Divider(height: 0),
              ],
            ) : Container(),
            order?.statusTransaction == "sudah-diterima" ? Padding(
              padding: const EdgeInsets.all(16),
              child: RaisedButtonAccent(
                text: "Konfirmasi Barang Sudah Diterima",
                isLoading: isAccepting,
                onPressed: () {
                  setState(() {
                    isAccepting = true;
                    bloc.add(FinishTransaction(id: order?.id));
                  });
                },
              ),
            ) : Container(),
            order?.statusTransaction == "selesai" ? (
              order?.ulasan == null || order?.ulasan == "" ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 0),
                  Box(
                    padding: 16,
                    child: PrimaryText("Review Order"),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ReviewOrderPage(order: order, bloc: bloc)
                    )),
                  ),
                  Divider(height: 0),
                ],
              ) : Box(
                padding: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelText("Ulasan"),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.yellow[700]),
                        Text(order?.rating?.toString() ?? "0")
                      ],
                    ),
                    TextCustom(order?.ulasan ?? "-"),
                  ],
                ),
              )
            ) : Container(),
            SizedBox(height: 16),
            Divider(height: 0),
            order?.proofItemReceived != null ? Box(
              padding: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bukti Kedatangan"),
                  SizedBox(height: 16),
                  Image.network(order?.proofItemReceived ?? "")
                ],
              ),
            ) : Container(),
            Divider(height: 0),
          ],
        ),
      ),
    );
  }
}