import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:kedatonkomputer/core/bloc/cart/cart_bloc.dart';
import 'package:kedatonkomputer/core/bloc/cart/cart_event.dart';
import 'package:kedatonkomputer/core/bloc/cart/cart_state.dart';
import 'package:kedatonkomputer/core/bloc/product/product_bloc.dart';
import 'package:kedatonkomputer/core/bloc/product/product_event.dart';
import 'package:kedatonkomputer/core/bloc/product/product_state.dart';
import 'package:kedatonkomputer/core/models/cart_model.dart';
import 'package:kedatonkomputer/core/models/product_model.dart';
import 'package:kedatonkomputer/helper/app_consts.dart';
import 'package:kedatonkomputer/ui/screens/cart_page.dart';
import 'package:kedatonkomputer/ui/screens/order/order_page.dart';
import 'package:kedatonkomputer/ui/screens/product_detail.dart';
import 'package:kedatonkomputer/ui/screens/profile_page.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/item/product_item.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var productBloc = ProductBloc();
  var products = <Product>[];
  
  var cartBloc = CartBloc();
  CartModel cart;

  bool  isStarting = true,
        isLoadMore = false,
        hasReachedMax = false;

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  // final _searchController = TextEditingController();

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    cartBloc.add(LoadCarts());
    productBloc.add(LoadProducts(isRefresh: true));
    super.initState();
  }

  loadProduct() {
    if(!isStarting) {
      setState(() {
        isStarting = true;
      });
      cartBloc.add(LoadCarts());
      productBloc.add(LoadProducts(isRefresh: true));
    }
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold && !hasReachedMax && !isLoadMore) {
      if(!isStarting) {
        productBloc.add(LoadProducts(
          isLoadMore: true,
        ));
      }
      setState(() {
        isLoadMore = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          cubit: productBloc,
          listener: (context, state) {
            if(state is ProductLoaded) {
              setState(() {
                _refreshController.refreshCompleted();
                isStarting = false;
                isLoadMore = false;
                products = state.data;
              });
            } else if(state is ProductFailure) {
              setState(() {
                _refreshController.refreshCompleted();
                isLoadMore = false;
                isStarting = false;
              });
            }
          }
        ),
        BlocListener(
          cubit: cartBloc,
          listener: (context, state) {
            if(state is CartLoaded) {
              setState(() {
                cart = state.data;
              });
            } else if(state is CartFailure) {
              Toast.show(state.error, context);
            }
          }
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.account_circle), 
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => ProfilePage()
            ))
          ),
          title: Text("Kedaton Komputer"),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart), 
              onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => OrderPage()
              ))
            )
          ],
        ),
        body: Stack(
          children: [
            SmartRefresher(
              controller: _refreshController,
              onRefresh: loadProduct,
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 160),
                childAspectRatio: 3/4.1,
                physics: ClampingScrollPhysics(),
                children: List.generate(products.length, (index) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    child: ProductItem(
                      product: products[index],
                      onPressed: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: products[index])
                      )).then((value) => cartBloc.add(LoadCarts())),
                    )
                  );
                })
              ),
            ),
            (cart?.cart?.length ?? 0) <= 0 ? Container() : Positioned(
              bottom: 0,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Box(
                    padding: 16,
                    borderRadius: 8,
                    width: MediaQuery.of(context).size.width-32,
                    color: Colors.green,
                    boxShadow: [AppBoxShadow.type3],
                    onPressed: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CartPage(cart: cart)
                    )).then((value) => cartBloc.add(LoadCarts())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        TextCustom(
                          "${cart?.totalCart} pcs",
                          color: Colors.white
                        ),
                        Expanded(
                          child: TextCustom(
                            rupiah(cart?.totalCost),
                            color: Colors.white,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}