import 'package:dio/dio.dart';
import 'package:final_tutrorial/color.dart';
import 'package:final_tutrorial/screens/description_page.dart';
import 'package:final_tutrorial/services/product_service/product_repo_impl.dart';
import 'package:final_tutrorial/services/product_service/product_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../services/product_service/models/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

typedef GetSingleProductsFunction = Future<Response> Function(String id);

class MyClass {
  final GetSingleProductsFunction getSingleProducts;

  MyClass({required this.getSingleProducts});

  Future<Response> fetchSingleProduct(String id) async {
    return await getSingleProducts(id);
  }
}

class _HomePageState extends State<HomePage> {
  final ProductService _productService =
      ProductService(ProductRepositoryImplementation());

  List<Product> productList = <Product>[];
  List<Product> selectedProducts = <Product>[];
  List<String> categories = <String>[];
  List<String> selectedCategory = <String>[];

  @override
  void initState() {
    getAllProducts();
    getAllCategories();
    super.initState();
  }

  getAllProducts() async {
    var res = await _productService.getAllProducts();
    if (res.statusCode == 200) {
      productList =
          List<Product>.from(res.data.map((e) => Product.fromJson(e)));
      debugPrint('product is ===>>>> ${productList[0].toJson()}');
      setState(() {});
    } else {
      debugPrint('FAILED');
    }
  }

  toggleShimmer() {
    setState(() {
      shimmer = !shimmer;
    });
  }

  getAllCategories() async {
    var res = await _productService.getAllCategories();
    if (res.statusCode == 200) {
      categories = List<String>.from(res.data.map((e) => e));
      debugPrint('product is ===>>>> ${categories[0]}');

      selectedCategory.add(categories[0]);
      setState(() {});
    } else {
      debugPrint('FAILED');
    }
  }

  addCategory(String category) {
    selectedCategory.clear();
    selectedCategory.add(category);

    selectedProducts =
        productList.where((product) => product.category == category).toList();

    setState(() {});
    debugPrint(selectedCategory.first);
  }

// code for shimmer effect
  bool shimmer = false;
// future for loading screen
  Future<void> _refresh() {
    setState(() {
      shimmer = true;
    });
    return Future.delayed(Duration(seconds: 3)).then((value) => setState(() {
          shimmer = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(170.0),
        // Specify the desired height here
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 10),
          // decoration: BoxDecoration(color: blue),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 290,
                    child: Text(
                      'Find your suitable product now',
                      style: TextStyle(
                        fontSize: 36,
                        height: 1.1,
                        fontFamily: 'CabinetGrotesk-Bold',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration:
                          BoxDecoration(color: blue2, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              // * code for category list in app (look down)
              shimmer
                  ? Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.transparent,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(25)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: categories
                                  .map((category) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: InkWell(
                                            onTap: () async {
                                              addCategory(category);
                                            },
                                            child: Text(
                                              category,
                                              style: TextStyle(
                                                color: selectedCategory
                                                        .contains(category)
                                                    ? blue2
                                                    : Colors.grey,
                                                fontFamily:
                                                    'CabinetGrotesk-Bold',
                                              ),
                                            )),
                                      ))
                                  .toList(),
                            ),
                          )),
                    )
                  : Container(
                      child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: categories
                            .map((category) => Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: InkWell(
                                      onTap: () async {
                                        addCategory(category);
                                      },
                                      child: Text(
                                        category,
                                        style: TextStyle(
                                          color: selectedCategory
                                                  .contains(category)
                                              ? blue2
                                              : Colors.grey,
                                          fontFamily: 'CabinetGrotesk-Bold',
                                        ),
                                      )),
                                ))
                            .toList(),
                      ),
                    )),
            ],
          ),
        ),
      ),
      body: ListView(scrollDirection: Axis.vertical, children: [
        Container(
          height: MediaQuery.of(context).size.height * .7,
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: GridView.builder(
                itemCount: selectedProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DescriptionPage(
                                product: selectedProducts[index]))),
                    child: shimmer
                        ? Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(
                                          3, 3), // changes position of shadow
                                    ),
                                  ],
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 230, 226, 226))),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          selectedProducts[index].image!,
                                          height: 70,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              '${selectedProducts[index].title}...',
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'Campton-LightDEMO 2')),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            '\$${selectedProducts[index].price}',
                                            style: const TextStyle(
                                                fontFamily:
                                                    'Campton-BoldDEMO 2'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        3, 3), // changes position of shadow
                                  ),
                                ],
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 230, 226, 226))),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        selectedProducts[index].image!,
                                        height: 70,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            '${selectedProducts[index].title}...',
                                            style: const TextStyle(
                                                fontFamily:
                                                    'Campton-LightDEMO 2')),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          '\$${selectedProducts[index].price}',
                                          style: const TextStyle(
                                              fontFamily: 'Campton-BoldDEMO 2'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  );
                }),
          ),
        ),
      ]),
    );
  }
}
