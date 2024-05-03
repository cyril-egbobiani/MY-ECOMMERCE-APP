// import 'package:final_tutrorial/services/product_service/models/product_detail.dart';
// import 'dart:ffi';

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_tutrorial/color.dart';
import 'package:final_tutrorial/components/snackbar.dart';
// import 'package:final_tutrorial/screens/bottomNavBar.dart';
import 'package:final_tutrorial/services/product_service/models/product_detail.dart';
import 'package:final_tutrorial/services/product_service/models/product_model.dart';
// import 'package:final_tutrorial/services/product_service/product_repo_impl.dart';
// import 'package:final_tutrorial/services/product_service/product_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/product_service/models/cart_model.dart';
import '../services/product_service/product_repo_impl.dart';
import '../services/product_service/product_usecase.dart';

class DescriptionPage extends StatefulWidget {
  final Product product;
  const DescriptionPage({super.key, required this.product});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  final ProductService _productService =
      ProductService(ProductRepositoryImplementation());

  List<ProductDetails> productList = <ProductDetails>[];
  List<String> categories = <String>[];
  List<ProductDetails> selectedProducts = <ProductDetails>[];
  List<dynamic> cartList = <CartModel>[];

  fetchCart() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    String? cartString = _prefs.getString('userCart');
    if (cartString != null) {
      cartList = jsonDecode(cartString);
      cartList = cartList.map((item) => CartModel.fromMap(item!)).toList();
      print("fetch cart length ${cartList.length}");
      showSnackBar('Items fetched');
    }
    setState(() {});
  }

  addToCart() async {
    Response res = await _productService.addToCart({});

    debugPrint(res.data);
  }

  addProductToCart(Product product) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      var itemList = cartList.where((e) => e.product.id == product.id).toList();
      if (itemList.isEmpty) {
        cartList.add(CartModel(product: product, quantity: 1, id: product.id.toString()));
      } else {
        itemList.first.quantity = itemList.first.quantity + 1;
      }

      String cartString = jsonEncode(cartList);

      await _prefs.setString("userCart", cartString);

      showSnackBar('Item added');

      setState(() {});
    } catch (e) {
      debugPrint("i am pressing here $e");
    }
  }

  @override
  void initState() {
    debugPrint(widget.product.price.toString());
    debugPrint(widget.product.description.toString());
    fetchCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products Details',
          style: TextStyle(fontFamily: 'CabinetGrotesk-Bold'),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(scrollDirection: Axis.vertical, children: [
        Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 180,
                    child: Center(
                      child: Image.network(
                        widget.product.image.toString(),
                        fit: BoxFit.contain,
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Mulberry Clutch',
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'CabinetGrotesk-Bold'),
                    ),
                    Text("\$${widget.product.price}",
                        style: const TextStyle(
                            fontSize: 18, fontFamily: 'Campton-BoldDEMO 2')),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Text('Details',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: blue2,
                                    fontFamily: 'Campton-LightDEMO 2')),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        const Text('Reviews',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Campton-LightDEMO 2')),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.grey,
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    widget.product.description.toString(),
                    style: const TextStyle(fontFamily: 'Campton-LightDEMO 2'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      'Seller',
                      style: TextStyle(
                          fontFamily: 'CabinetGrotesk-Bold', fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(50),
                              image: const DecorationImage(
                                  image: AssetImage('images/lady.jpg'),
                                  fit: BoxFit.fill)),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          'Sarah Patricia Evans',
                          style: TextStyle(fontFamily: 'Campton-LightDEMO 2'),
                        ),
                      ],
                    )),
                    Container(
                        child: const Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                        ),
                        Icon(
                          Icons.star_border_outlined,
                          size: 20,
                        ),
                      ],
                    )),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        addProductToCart(widget.product);
                        //addToCart();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             CartSection(productCart: widget.product)));
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                            )),
                        child: const Center(
                            child: Text('Add to Cart',
                                style: TextStyle(
                                    fontFamily: 'CabinetGrotesk-Bold'))),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [blue, blue2])),
                        child: const Center(
                            child: Text(
                          'Check out',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'CabinetGrotesk-Bold'),
                        )),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ]),
    );
  }
}
