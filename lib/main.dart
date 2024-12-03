import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(BlinkitApp());
}

class BlinkitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blinkit',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
      ),
      home: BlinkitHomePage(),
    );
  }
}

class BlinkitHomePage extends StatefulWidget {
  @override
  _BlinkitHomePageState createState() => _BlinkitHomePageState();
}

class _BlinkitHomePageState extends State<BlinkitHomePage> {
  Map<String, dynamic>? data; 
  String errorMessage = ''; 
  bool isLoading = true; 
  int _currentBannerIndex = 0;
  int _currentOfferIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://raw.githubusercontent.com/WorkingYashSharma/DynamicUI/main/dynamic.json'));

      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Blinkit')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Blinkit')),
        body: Center(child: Text(errorMessage)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(data?['header']['title'] ?? 'Blinkit')),
      body: ListView(
        children: buildSections(),
      ),
    );
  }
  
  List<Widget> buildSections() {
    List<Widget> sectionWidgets = [];

    List<String> sectionsOrder = List<String>.from(data?['sectionsOrdering'] ?? []);

    for (var section in sectionsOrder) {
      switch (section) {
        case 'header':
          sectionWidgets.add(buildHeader());
          break;
        case 'banners':
          if (data?.containsKey('banners') ?? false) sectionWidgets.add(buildBanners());
          break;
        case 'offers':
          if (data?.containsKey('offers') ?? false) sectionWidgets.add(buildOffers());
          break;
        case 'categories':
          if (data?.containsKey('categories') ?? false) sectionWidgets.add(buildCategories());
          break;
        case 'products':
          if (data?.containsKey('products') ?? false) sectionWidgets.add(buildProducts());
          break;
        default:
          break;
      }
    }
    return sectionWidgets;
  }
  
  Widget buildHeader() {
    var header = data?['header'];
    print("Header Data: $header");
    
    var bgColorString = header?['backgroundColor'];
    print("Background Color String: $bgColorString");

    Color headerColor;
    try {
      if (bgColorString != null && bgColorString.startsWith('#')) {
        headerColor = Color(int.parse('0xFF${bgColorString.substring(1)}'));
      } else {
        headerColor = Colors.orange;  
      }
    } catch (e) {
      print("Error parsing background color: $e");
      headerColor = Colors.orange;  
    }

    return Container(
      color: headerColor, 
      height: header?['height']?.toDouble() ?? 60.0,
      child: Center(
        child: Text(
          header?['title'] ?? 'Blinkit',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  
  Widget buildBanners() {
    var banners = data?['banners'] ?? [];
    return Column(
      children: [
        Container(
          height: 150,
          child: PageView.builder(
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
            itemBuilder: (context, index) {
              var banner = banners[index];
              return Image.network(
                banner['imageUrl'],
                width: banner['width'].toDouble(),
                height: banner['height'].toDouble(),
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (index) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentBannerIndex == index
                    ? Colors.orange
                    : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
  
  Widget buildOffers() {
    var offers = data?['offers'] ?? [];
    return Column(
      children: [
        Container(
          height: 150,
          child: PageView.builder(
            itemCount: offers.length,
            onPageChanged: (index) {
              setState(() {
                _currentOfferIndex = index;
              });
            },
            itemBuilder: (context, index) {
              var offer = offers[index];
              return Column(
                children: [
                  Image.network(
                    offer['imageUrl'],
                    width: 200,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(offer['description'] ?? ''),
                  ),
                ],
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(offers.length, (index) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentOfferIndex == index
                    ? Colors.orange
                    : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
  
  Widget buildCategories() {
    var categories = data?['categories'] ?? [];
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          var category = categories[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ClipOval(
                  child: Image.network(
                    category['imageUrl'],
                    width: category['width'].toDouble(),
                    height: category['height'].toDouble(),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(category['name'] ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget buildProducts() {
    var products = data?['products'] ?? [];
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        var product = products[index];
        return Card(
          child: Column(
            children: [
              Image.network(
                product['imageUrl'],
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product['name'] ?? 'Product Name'),
                    Text('₹${product['price']}'),
                    if (product['discount'] != null)
                      Text('Discount: ${product['discount']}%'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
