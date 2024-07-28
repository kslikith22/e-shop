import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:e_shop/core/theme.dart';
import 'package:e_shop/models/products.dart';
import 'package:e_shop/providers/product_provider.dart';
import 'package:e_shop/providers/user_provider.dart';
import 'package:e_shop/utils/common.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _initRemoteConfig;
  late FirebaseRemoteConfig _remoteConfig;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    });
    _initRemoteConfig = _initializeRemoteConfig();
  }

  Future<void> _initializeRemoteConfig() async {
    setState(() {
      isLoading = true;
    });
    try {
      _remoteConfig = FirebaseRemoteConfig.instance;

      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 20),
      ));
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      print('Failed to fetch remote config: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _handleLogout() async {
    String? result =
        await Provider.of<UserProvider>(context, listen: false).logout();
    if (result == null || result == 'success') {
      Navigator.pushReplacementNamed(context, '/signin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "e-shop",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        actions: [
          InkWell(onTap: () => _handleLogout(), child: Icon(Icons.logout)),
        ],
        foregroundColor: Colors.white,
        backgroundColor: ThemeConstants.blueColor,
      ),
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          if (value.isLoading || isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: ThemeConstants.blueColor,
              ),
            );
          }
          if (value.products.length == 0) {
            return Text("No products");
          }
          return AutoHeightGridView(
            itemCount: value.products.length,
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            builder: (context, index) {
              ProductModel products = value.products[index];
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: ThemeConstants.snow,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(10),
                        Center(
                          child: Image.network(
                            products.thumbnail,
                            width: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ThemeConstants.grayDark,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                products.brand,
                                style: TextStyle(
                                  color: ThemeConstants.grayDark,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              Gap(5),
                              Text(
                                products.description.substring(0, 30) + "...",
                                style: TextStyle(
                                  color: ThemeConstants.grayDark,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              Gap(10),
                              FutureBuilder(
                                future: _initRemoteConfig,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("Error");
                                  } else {
                                    final bool showDiscountedPrice =
                                        _remoteConfig
                                            .getBool('showDiscountedPrice');
                                    print(showDiscountedPrice);

                                    return Row(
                                      children: [
                                        if (showDiscountedPrice) Text("r"),
                                        Text(
                                          "\$${products.price.toStringAsFixed(0)}",
                                          style: TextStyle(
                                            fontSize:
                                                showDiscountedPrice ? 12 : 14,
                                            decoration: showDiscountedPrice
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        Gap(5),
                                        if (showDiscountedPrice)
                                          Text(
                                            '\$${calculateDiscount(discountPercentage: products.discountPercentage, price: products.price).toStringAsFixed(0)}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        Gap(8),
                                        if (showDiscountedPrice)
                                          Text(
                                            '${products.discountPercentage}%off',
                                            style: TextStyle(
                                                color: Colors.green[400],
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.italic),
                                          )
                                      ],
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
