import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

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
        scaffoldBackgroundColor: Color(0xFFF5F5F5), // Light background color
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
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchData();
    _pageController = PageController(initialPage: 0);

    // Set up the automatic slider
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (data != null && data!['banners'] != null) {
        _currentPage++;
        if (_currentPage >= data!['banners'].length) {
          _currentPage = 0; // Loop back to the first banner
        }
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://raw.githubusercontent.com/WorkingYashSharma/DynamicUI/main/dynamic.json'));
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
        });
      } else {
        print("Error: Failed to fetch JSON, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data?['header']['title'] ?? 'Loading...'),
        backgroundColor: data != null
            ? Color(int.parse(
            data!['header']['backgroundColor'].replaceFirst('#', '0xff')))
            : Colors.orange,
        elevation: 4.0,
      ),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSearchBar(),
              SizedBox(height: 16),
              buildBanners(),
              SizedBox(height: 16),
              buildOffersSection(),
              SizedBox(height: 16),
              buildCategorySection(),
              SizedBox(height: 16),
              buildProductSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for products...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget buildBanners() {
    if (data == null || data!['banners'] == null) {
      return SizedBox.shrink();
    }

    final banners = data!['banners'];
    return Column(
      children: [
        SizedBox(
          height: 150, // Height of the banner slider
          child: PageView.builder(
            controller: _pageController,
            itemCount: banners.length,
            itemBuilder: (context, index) {
              final banner = banners[index];
              final width = banner['width']?.toDouble() ?? 350;
              final height = banner['height']?.toDouble() ?? 150;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: banner['imageUrl'],
                      width: width,
                      height: height,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8),
        buildPageIndicator(banners.length),
      ],
    );
  }

  Widget buildPageIndicator(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 12 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index ? Colors.orange : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget buildOffersSection() {
    if (data == null || data!['offers'] == null) {
      return SizedBox.shrink();
    }

    final offers = data!['offers'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Offers for You",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 120, // Height of the horizontal slider
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: offer['imageUrl'],
                          height: 80,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          offer['description'],
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildCategorySection() {
    if (data == null || data!['categories'] == null) {
      return SizedBox.shrink();
    }

    final categories = data!['categories'];
    return Padding(
        padding: const EdgeInsets.all(8.0),
    child: GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 4,
    childAspectRatio: 0.8,
    ),
    itemCount: categories.length,
    itemBuilder: (context, index) {
    final category = categories[index];
    return Column(
    children: [
    Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    boxShadow: [
    BoxShadow(
    color: Colors.grey.shade300,
    blurRadius: 10,
    offset: Offset(0, 5),
    )
    ],
    ),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: CachedNetworkImage(
    imageUrl: category['imageUrl'],
    width: 70,
    height: 70,
      fit: BoxFit.cover,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    ),
    ),
    ),
      SizedBox(height: 5),
      Text(category['name'], textAlign: TextAlign.center),
    ],
    );
    },
    ),
    );
  }

  Widget buildProductSection() {
    if (data == null || data!['products'] == null) {
      return SizedBox.shrink();
    }

    final products = data!['products'];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: 4,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: product['imageUrl'],
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(product['name'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("₹${product['price']}",
                      style: TextStyle(color: Colors.black87, fontSize: 14)),
                ),
                if (product['discount'] > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "${product['discount']}% OFF",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
