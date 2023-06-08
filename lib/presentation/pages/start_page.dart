import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ketkray_garden/constant/color_helper.dart';
import 'package:ketkray_garden/presentation/pages/manage_page.dart';
import 'package:ketkray_garden/services/api/call_api_center.dart';
import 'package:ketkray_garden/utils/function_widgets.dart';
import 'package:ketkray_garden/utils/keyboard_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:supercharged/supercharged.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  static const routeName = '/start';

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late double height;
  late double width;
  late bool isPortrait;
  late double textScaleFector;

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final StreamController _productController = StreamController.broadcast();
  final TextEditingController _searchController = TextEditingController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List _productList = [];
  List _searchProductList = [];

  _setProduct(product) {
    _searchProductList = product;
    _productController.add(_searchProductList);
  }

  final TextStyle _productStyle = const TextStyle(
    fontSize: 16.0,
  );

  @override
  void initState() {
    CallApiServiceCenter.fetchAllProduct((value) async {
      _productList = value;
      _setProduct(value);
    });

    super.initState();
  }

  _searchProduct(String query) {
    var productList = _productList;

    if (query.isNotEmpty) {
      final result = productList.where((element) {
        String name = element['name'];
        return name.contains(query);
      }).toList();

      _setProduct(result);
    } else {
      _setProduct(productList);
    }
  }

  void _onRefresh() async {
    CallApiServiceCenter.fetchAllProduct((value) async {
      _productList = value;
      _setProduct(value);
    });
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    height = screenHeight(context);
    width = screenWidth(context);
    isPortrait = screenIsPortrait(context);

    return SafeArea(
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _key.currentState?.openDrawer();
            },
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('รายการสินค้า'),
            ],
          ),
          backgroundColor: ColorHelper.primaryColor,
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Manage'),
                onTap: () {
                  Navigator.pushNamed(context, ManagePage.routeName);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    addVerticalSpace(20.0),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            22.0,
                          ),
                        ),
                      ),
                      child: TextFormField(
                        controller: _searchController,
                        onChanged: (value) {
                          // debugPrint(value.toString());
                          _searchProduct(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'ค้นหา',
                          suffixIcon: InkWell(
                              onTap: () {
                                _searchController.text = '';
                                _searchProduct('');
                                closeKeyboard();
                              },
                              child: const Icon(Icons.close)),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    addVerticalSpace(20.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: StreamBuilder(
                          stream: _productController.stream,
                          builder: (context, snapshot) {
                            return Column(
                              children: [
                                ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      elevation: 8,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 10,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'ชื่อ - ${_searchProductList[index]['name']}',
                                              style: _productStyle,
                                            ),
                                            addVerticalSpace(4.0),
                                            Text(
                                              'รายละเอียด - ${_searchProductList[index]['description']}',
                                              style: _productStyle,
                                            ),
                                            addVerticalSpace(4.0),
                                            Text(
                                              'ประเภท - ${_searchProductList[index]['type']}',
                                              style: _productStyle,
                                            ),
                                            addVerticalSpace(4.0),
                                            Text(
                                              'ลักษณะ - ${_searchProductList[index]['appearance']}',
                                              style: _productStyle,
                                            ),
                                            addVerticalSpace(4.0),
                                            Text(
                                              'วิธีใช้ - ${_searchProductList[index]['howToUse']}',
                                              style: _productStyle,
                                            ),
                                            addVerticalSpace(4.0),
                                            Text(
                                              'ปริมาณ - ${_searchProductList[index]['netWeight']}',
                                              style: _productStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10,
                                  ),
                                  itemCount: _searchProductList.length,
                                ),
                              ],
                            );
                          }),
                    ),
                    addVerticalSpace(20.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
