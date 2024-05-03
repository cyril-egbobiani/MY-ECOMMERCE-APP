import 'package:final_tutrorial/screens/description_page.dart';
import 'package:final_tutrorial/screens/origin_page.dart';
import 'package:final_tutrorial/services/product_service/models/product_model.dart';
import 'package:final_tutrorial/services/product_service/product_repo_impl.dart';
import 'package:final_tutrorial/services/product_service/product_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final ProductService _productService =
      ProductService(ProductRepositoryImplementation());

  List<Product> productList = <Product>[];
  List<Product> selectedProducts = <Product>[];
  List<String> categories = <String>[];
  List<String> selectedCategory = <String>[];

  late bool _isLoading;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        getAllProducts();
        getAllCategories();
      });
    });
    // getAllProducts();
    // getAllCategories();
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

  bool shimmer = false;

  Future<void> _refresh() {
    return Future.delayed(Duration(seconds: 2)).then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => OriginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .7,
      child: GridView.builder(
          itemCount: selectedProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return shimmer
                ? Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.transparent,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DescriptionPage(
                                  product: selectedProducts[index]))),
                      child: Container(
                        height: 120,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(10),
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
                                color:
                                    const Color.fromARGB(255, 230, 226, 226))),
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
                                            fontFamily: 'Campton-LightDEMO 2')),
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
                    ),
                  )
                : GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DescriptionPage(
                                product: selectedProducts[index]))),
                    child: Container(
                      height: 120,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(10),
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
                              color: const Color.fromARGB(255, 230, 226, 226))),
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
                                          fontFamily: 'Campton-LightDEMO 2')),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
