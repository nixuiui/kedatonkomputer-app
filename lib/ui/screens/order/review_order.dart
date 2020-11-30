import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedatonkomputer/core/bloc/order/order_bloc.dart';
import 'package:kedatonkomputer/core/bloc/order/order_event.dart';
import 'package:kedatonkomputer/core/bloc/order/order_state.dart';
import 'package:kedatonkomputer/core/models/order_model.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/form.dart';
import 'package:toast/toast.dart';

class ReviewOrderPage extends StatefulWidget {

  const ReviewOrderPage({
    Key key,
    this.order,
    this.bloc,
  }) : super(key: key);
  
  final OrderModel order;
  final OrderBloc bloc;

  @override
  _ReviewOrderPageState createState() => _ReviewOrderPageState();
}

class _ReviewOrderPageState extends State<ReviewOrderPage> {

  var controller = TextEditingController();
  var rating = 0;
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: widget.bloc,
      listener: (context, state) {
        if(state is OrderReviewed) {
          Navigator.pop(context);
        } else if(state is OrderFailure) {
          setState(() {
            isLoading = false;
            Toast.show(state.error, context);
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Review Order")
        ),
        body: SafeArea(
          child: Box(
            padding: 16,
            child: Column(
              children: [
                Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [1,2,3,4,5].map((e) {
                      return IconButton(
                        icon: Icon(
                          Icons.star,
                          color: rating >= e ? Colors.yellow : Colors.grey[300],
                          size: 40
                        ),
                        onPressed: () => setState(() => rating = e)
                      );
                    }).toList()
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: TextAreaBorderBottom(
                      textHint: "Tulis alasan dibatalkan",
                      minLines: 10,
                      controller: controller,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: RaisedButtonPrimary(
                    text: "Kirim Review",
                    isLoading: isLoading,
                    onPressed: isLoading ? null : () {
                      if(controller.text == null || controller.text == ""){
                        Toast.show("Isi alasan dulu", context);
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        widget.bloc.add(ReviewOrder(
                          id: widget.order.id, 
                          review: controller.text,
                          rating: rating
                        ));
                      }
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}