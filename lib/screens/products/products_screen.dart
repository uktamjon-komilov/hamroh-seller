import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hamroh_seller/core/colors.dart';
import 'package:hamroh_seller/core/http_exception.dart';
import 'package:hamroh_seller/models/create_order_item_model.dart';
import 'package:hamroh_seller/models/product_model.dart';
import 'package:hamroh_seller/providers/create_order_provider.dart';
import 'package:hamroh_seller/providers/products_provider.dart';
import 'package:hamroh_seller/screens/orders/order_items_screen.dart';
import 'package:hamroh_seller/screens/products/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProductsScreen extends StatefulWidget {
  static const String routeName = "/products";

  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _isInit = true;
  Timer? timer;
  String? _error;
  String _previousText = "";
  TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _isInit = false;
      _controller.addListener(() => _searchControllerListener(context));
    }
  }

  void _searchControllerListener(BuildContext context) {
    if (_controller.text.isEmpty) {
      Provider.of<ProductsProvider>(context, listen: false).clearProducts();
    } else if (_previousText != _controller.text) {
      _previousText = _controller.text;
      if (timer != null) {
        timer!.cancel();
        timer = null;
      }
      timer = Timer(Duration(milliseconds: 700), () => _search(context));
    }
  }

  _search(BuildContext context) async {
    setState(() {
      _error = null;
    });
    try {
      await Provider.of<ProductsProvider>(context, listen: false)
          .getProducts(term: _controller.text);
    } on HttpException catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(() => _searchControllerListener(context));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProductsProvider productsProvider = Provider.of<ProductsProvider>(context);
    CreateOrderProvider createOrderProvider =
        Provider.of<CreateOrderProvider>(context);

    print(createOrderProvider.order!.items);

    return Scaffold(
      appBar: AppBar(
        title: Text("Mahsulotlar"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: createOrderProvider.order!.items.length == 0
                ? null
                : () {
                    Navigator.of(context).pushNamed(OrderItemsScreen.routeName);
                  },
            icon: Stack(
              children: [
                Icon(
                  Icons.shopping_basket,
                  color: Colors.white,
                ),
                Visibility(
                  visible: createOrderProvider.order!.items.length > 0,
                  child: Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kYellowColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(3),
                      child: Text(
                        createOrderProvider.order!.items.length.toString(),
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            _buildSearchInput(),
            Expanded(
              child: productsProvider.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : (_error == null
                      ? ListView(
                          children: [
                            ...productsProvider.products
                                .map((product) =>
                                    SearchListItem(product: product))
                                .toList()
                          ],
                        )
                      : Text(
                          _error.toString(),
                        )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _controller,
        style: TextStyle(
          fontSize: 22,
          color: kSecondaryColor,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          hintText: "Qidiruv",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          suffixIcon: IconButton(
            onPressed: _controller.clear,
            icon: Icon(Icons.clear),
          ),
        ),
      ),
    );
  }
}

class SearchListItem extends StatefulWidget {
  final ProductModel product;

  const SearchListItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<SearchListItem> createState() => _SearchListItemState();
}

class _SearchListItemState extends State<SearchListItem> {
  void toggleChooseOption() {
    Provider.of<CreateOrderProvider>(context, listen: false)
        .toggleItem(CreateOrderItemModel(product: widget.product, quantity: 1));
  }

  @override
  Widget build(BuildContext context) {
    bool chosen = Provider.of<CreateOrderProvider>(context, listen: false)
        .itemExists(widget.product);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetailScreen.routeName);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: kGreyColor, width: 1),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          dense: true,
          title: Text(
            widget.product.title,
            maxLines: 2,
            style: TextStyle(
              fontSize: 20,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Qoldiq x ${widget.product.quantity}",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          trailing: chosen
              ? IconButton(
                  color: kRedColor,
                  icon: Icon(
                    Icons.delete,
                    size: 35,
                  ),
                  onPressed: toggleChooseOption,
                )
              : Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                    onPressed: toggleChooseOption,
                    icon: Icon(Icons.add),
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
