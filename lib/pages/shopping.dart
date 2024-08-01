import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// https://drive.google.com/file/d/1H7qkY4MDl97q8u_wuBQXYuNehUEJ8ukl/view?usp=drive_link
const String lightImg='https://drive.google.com/uc?export=view&id=10sivGGiQr-BAgx4ISxCx5vUQcF7if48C';
const String fanImg = 'https://drive.google.com/uc?export=view&id=136ST3URsYINM83hLx4xq4BViEfJsq-jU';
const String wireImg ='https://drive.google.com/uc?export=view&id=1dqoOVQVhzDKXkPQfjWuGs4WVMx68Q-To';
const String btnImg = 'https://drive.google.com/uc?export=view&id=1LgSVB6I0ds6swR-G1yOBWv04hM-Azf3B';
const String mcbImg='https://drive.google.com/uc?export=view&id=1q5xJNBgob3eWTt6weo1h8qip1RCRTn2l';
const String applinceImg = 'https://drive.google.com/uc?export=view&id=1Q2FxQAq-Mbrc77aBjK4levV91pHLaKt7';

Cart cart = Cart();

class SimpleEcommerce extends StatelessWidget {
  const SimpleEcommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Builder(
        builder: (context) => const Shopping(),
      ),
    );
  }
}

class Shopping extends StatefulWidget {
  const Shopping({super.key});

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  late String searchString;
  @override
  void initState() {
    searchString = '';
    super.initState();
  }

  void setSearchString(String value) => setState(() {
    searchString = value;
  });

  @override
  Widget build(BuildContext context) {
    var listViewPadding =
    const EdgeInsets.symmetric(horizontal: 16, vertical: 24);
    List<Widget> searchResultTiles = [];
    if (searchString.isNotEmpty) {
      searchResultTiles = products
          .where(
              (p) => p.name.toLowerCase().contains(searchString.toLowerCase()))
          .map(
            (p) => ProductTile(product: p),
      )
          .toList();
    }
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          onChanged: setSearchString,
        ),
        actions: const [
          CartAppBarAction(),
        ],
      ),
      body: searchString.isNotEmpty
          ? GridView.count(
        padding: listViewPadding,
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        childAspectRatio: .78,
        children: searchResultTiles,
      )
          : ListView(
        padding: listViewPadding,
        children: [
          Row(
            children: [

              Text(
                'Shop by Category',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: 10),
          CategoryTile(
            imageUrl: lightImg,
            category: lights,
            imageAlignment: Alignment.topCenter,
          ),
          const SizedBox(height: 10),
          CategoryTile(
            imageUrl: fanImg,
            category: fan,
            imageAlignment: Alignment.topCenter,
          ),
          const SizedBox(height: 10),
          CategoryTile(
            imageUrl: wireImg,
            category: wires,
            imageAlignment: Alignment.topCenter,
          ),
          const SizedBox(height: 10),
          CategoryTile(
            imageUrl: btnImg,
            category: switchh,
            imageAlignment: Alignment.topCenter,
          ),
          const SizedBox(height: 10),
          CategoryTile(
            imageUrl: mcbImg,
            category: mcb,
            imageAlignment: Alignment.topCenter,
          ),
          const SizedBox(height: 10),
          CategoryTile(
            imageUrl: applinceImg,
            category: applince,
            imageAlignment: Alignment.topCenter,
          ),
        ],
      ),
    );
  }
}

class CartAppBarAction extends StatefulWidget {
  const CartAppBarAction({super.key});

  @override
  State<CartAppBarAction> createState() => _CartAppBarActionState();
}

class _CartAppBarActionState extends State<CartAppBarAction> {
  // TODO: Setup cart to listen for changes based on your own state management. Could use riverpod, provider, bloc, etc..
  @override
  void initState() {
    cart.addListener(blankSetState);
    super.initState();
  }

  @override
  void dispose() {
    cart.removeListener(blankSetState);
    super.dispose();
  }

  void blankSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.shopping_cart,
          ),
          if (cart.itemsInCart.isNotEmpty)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                child: Center(
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Center(
                      child: Text(
                        cart.itemsInCart.length.toString(),
                        style: const TextStyle(
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      onPressed: () => _pushScreen(
        context: context,
        screen: const CartScreen(),
      ),
    );
  }
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({required this.product, super.key});
  final Product product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Product get product => widget.product;
  String? selectedImageUrl;
  String? selectedSize;

  @override
  void initState() {
    selectedImageUrl = product.imageUrls.first;
    selectedSize = product.sizes?.first;
    super.initState();
  }

  void setSelectedImageUrl(String url) {
    setState(() {
      selectedImageUrl = url;
    });
  }

  void setSelectedSize(String size) {
    setState(() {
      selectedSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> imagePreviews = product.imageUrls
        .map(
          (url) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onTap: () => setSelectedImageUrl(url),
          child: Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              border: selectedImageUrl == url
                  ? Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 1.75)
                  : null,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              url,
            ),
          ),
        ),
      ),
    )
        .toList();

    List<Widget> sizeSelectionWidgets = product.sizes
        ?.map(
          (s) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onTap: () {
            setSelectedSize(s);
          },
          child: Container(
            height: 42,
            width: 38,
            decoration: BoxDecoration(
              color: selectedSize == s
                  ? Theme.of(context).colorScheme.secondary
                  : null,
              border: Border.all(
                color: Colors.grey[350]!,
                width: 1.25,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                s,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: selectedSize == s ? Colors.white : null),
              ),
            ),
          ),
        ),
      ),
    )
        .toList() ??
        [];

    return Scaffold(
      appBar: AppBar(
        actions: const [
          CartAppBarAction(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            color: kGreyBackground,
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.network(
                    selectedImageUrl!,
                    fit: BoxFit.cover,
                    color: kGreyBackground,
                    colorBlendMode: BlendMode.multiply,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imagePreviews,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '\₹${product.cost}',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.description ??
                        'Contact the Dealer for more details about this product',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(height: 1.5),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  if (sizeSelectionWidgets.isNotEmpty) ...[
                    Text(
                      'Size',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: sizeSelectionWidgets,
                    ),
                  ],
                  const Spacer(),
                  Center(
                    child: CallToActionButton(
                      onPressed: () => cart.add(
                        OrderItem(
                          product: product,
                          selectedSize: selectedSize,
                        ),
                      ),
                      labelText: 'Add to Cart',
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CallToActionButton extends StatelessWidget {
  const CallToActionButton(
      {required this.onPressed,
        required this.labelText,
        this.minSize = const Size(266, 45),
        super.key});
  final Function onPressed;
  final String labelText;
  final Size minSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        minimumSize: minSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Text(
        labelText,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({required this.category, super.key});
  final Category category;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

enum Filters { popular, recent, sale }

class _CategoryScreenState extends State<CategoryScreen> {
  Category get category => widget.category;
  Filters filterValue = Filters.popular;
  String? selection;
  late List<Product> _products;

  @override
  void initState() {
    selection = category.selections.first;
    _products = products.where((p) => p.category == category).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductRow> productRows = category.selections
        .map((s) => ProductRow(
      productType: s,
      products: _products
          .where((p) => p.productType.toLowerCase() == s.toLowerCase())
          .toList(),
    ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(category.title),
        actions: const [
          CartAppBarAction(),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 18),
        itemCount: productRows.length,
        itemBuilder: (_, index) => productRows[index],
        separatorBuilder: (_, index) => const SizedBox(
          height: 18,
        ),
      ),
    );
  }
}

class ProductRow extends StatelessWidget {
  const ProductRow(
      {required this.products, required this.productType, super.key});
  final String productType;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    List<ProductTile> productTiles =
    products.map((p) => ProductTile(product: p)).toList();

    return productTiles.isEmpty
        ? const SizedBox.shrink()
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
          ),
          child: Text(
            productType,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 210,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            itemCount: productTiles.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => productTiles[index],
            separatorBuilder: (_, index) => const SizedBox(
              width: 24,
            ),
          ),
        ),
      ],
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        _pushScreen(
          context: context,
          screen: ProductScreen(product: product),
        );
      },
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(product: product),
            const SizedBox(
              height: 0,
            ),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Spacer(),
            Text(
              '\₹${product.cost.toString()}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            )
          ],
        ),
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: .95,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: kGreyBackground,
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          product.imageUrls.first,
          loadingBuilder: (_, child, loadingProgress) => loadingProgress == null
              ? child
              : const Center(child: CircularProgressIndicator()),
          color: kGreyBackground,
          colorBlendMode: BlendMode.multiply,
        ),
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    cart.addListener(updateState);
  }

  @override
  void dispose() {
    cart.removeListener(updateState);
    super.dispose();
  }

  void updateState() => setState(() {});

  @override
  Widget build(BuildContext context) {
    List<Widget> orderItemRows = cart.itemsInCart
        .map(
          (item) => Row(
        children: [
          SizedBox(
            width: 125,
            child: ProductImage(
              product: item.product,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '\₹${item.product.cost}',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => cart.remove(item),
            color: Colors.red,
          )
        ],
      ),
    )
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Column(
          children: [
            const Text('Cart'),
            Text(
              '${cart.itemsInCart.length} items',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          if (orderItemRows.isNotEmpty)
            Expanded(
              child: ListView.separated(
                padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                itemCount: orderItemRows.length,
                itemBuilder: (_, index) => orderItemRows[index],
                separatorBuilder: (_, index) => const SizedBox(
                  height: 16,
                ),
              ),
            )
          else
            const Expanded(
              child: Center(
                child: Text('Your cart is empty'),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '\₹${cart.totalCost.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                CallToActionButton(
                  onPressed: () {},
                  labelText: 'Check Out',
                  minSize: const Size(220, 45),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {required this.category,
        required this.imageUrl,
        this.imageAlignment = Alignment.center,
        super.key});
  final String imageUrl;
  final Category category;

  /// Which part of the image to prefer
  final Alignment imageAlignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _pushScreen(
        context: context,
        screen: CategoryScreen(
          category: category,
        ),
      ),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              color: kGreyBackground,
              colorBlendMode: BlendMode.darken,
              alignment: imageAlignment,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                category.title.toUpperCase(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({required this.onChanged, super.key});
  final Function(String) onChanged;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextField(
            onChanged: widget.onChanged,
            controller: _textEditingController,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding:
              kIsWeb ? const EdgeInsets.only(top: 10) : EdgeInsets.zero,
              prefixIconConstraints: const BoxConstraints(
                minHeight: 36,
                minWidth: 36,
              ),
              prefixIcon: const Icon(
                Icons.search,
              ),
              hintText: 'Search for a product',
              suffixIconConstraints: const BoxConstraints(
                minHeight: 36,
                minWidth: 36,
              ),
              suffixIcon: IconButton(
                constraints: const BoxConstraints(
                  minHeight: 36,
                  minWidth: 36,
                ),
                splashRadius: 24,
                icon: const Icon(
                  Icons.clear,
                ),
                onPressed: () {
                  _textEditingController.clear();
                  widget.onChanged(_textEditingController.text);
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Category {
  final String title;
  final List<String> selections;

  Category({required this.title, required this.selections});
}

void _pushScreen({required BuildContext context, required Widget screen}) {
  ThemeData themeData = Theme.of(context);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => Theme(data: themeData, child: screen),
    ),
  );
}

class Product {
  final String name;
  final List<String> imageUrls;
  final double cost;
  final String? description;
  final List<String>? sizes;

  /// Which overall category this product belongs in. e.g - Men, Women, Pets, etc.
  final Category category;

  /// Represents type of product such as shirt, jeans, pet treats, etc.
  final String productType;

  Product(
      {required this.name,
        required this.imageUrls,
        required this.cost,
        this.description,
        this.sizes,
        required this.category,
        required this.productType});
}

class Cart with ChangeNotifier {
  List<OrderItem> itemsInCart = [];

  double get totalCost {
    double total = 0;
    for (var item in itemsInCart) {
      total += item.product.cost;
    }
    return total;
  }

  void add(OrderItem orderItem) {
    itemsInCart.add(orderItem);
    notifyListeners();
  }

  void remove(OrderItem orderItem) {
    // print(orderItem.product.name);
    itemsInCart.remove(orderItem);
    // print(t);
    notifyListeners();
  }
}

class OrderItem {
  Product product;

  /// Selected size of product; This can be null
  String? selectedSize;

  /// Selected color of product; This can be null
  String? selectedColor;

  OrderItem({required this.product, this.selectedSize, this.selectedColor});
}

// TODO: Come up with your own categories
Category lights = Category(title: "Lights", selections: [
  'Arya-LED-Lamp',
  'Arya Spot Light',
  'Arya Street Light',
  'Arya High Bay',
  'Arya TubeLight',
  "Arya Lantern",
]);
Category fan = Category(title: 'Fan', selections: [
  'Polar Ceiling Fan',
  'Polar Table Fan',
  'Polar Wall Fan',
  'Polar Exhaust Fan',
  'Havells Ceiling Fan',
  'Havells Table Fan',
  'Havells Wall Fan',
  'Havells Exhaust Fan',
]);
Category wires = Category(title: 'Wires', selections: [
  'Polycab Wires',
  'Pressfit Wires',
  'Lan Cable',
  'Coaxial Cable',
]);
Category switchh = Category(title: 'Switch', selections: [
  'Toys',
  'Treats',
]);
Category mcb = Category(title: 'MCB', selections: [
  'Toys',
  'Treats',
]);
Category applince = Category(title: 'Other Applinces', selections:[
  'Oven',
  'Mixer Grinder',
  'Induction'
  'Iron',
  'Airfryer',
  'Juicer',
  'Miscellenious'
]);
final kGreyBackground = Colors.grey[200];

// TODO: Fetch products and feed into widgets
List<Product> products = [
  Product(
      name: 'Arya Led lights',
      imageUrls: [
        'https://drive.google.com/uc?export=view&id=1-Ldu_ciz2PlcLHpUDEphdhlK1SMX6fQJ',
        'https://drive.google.com/uc?export=view&id=19oT7Iyc217K-cFCGuvs4Bq3smh5SJFhc',

      ],
      cost: 100,
      description: 'Arya LED Lamp is a smart lamp that can be controlled via an app.',
      category: lights,
      productType: 'Arya-LED-Lamp',
  ),
  Product(
    name: 'Arya LED Lamp',
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1ld19icEZ9dsqTodgQ1jdZj0DGNLbSYSK',
      'https://drive.google.com/uc?export=view&id=1qXIqlbQ4z3-n8ZPekgMp7rG_6Jn0mcs5',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya-LED-Lamp',
  ),
  Product(
    name: 'Rota-M Spot Light' ,
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1H9I2GKuNjKXWNGlt1CW5c3rthC8cPZCV',
      'https://drive.google.com/uc?export=view&id=1pxcqHdlXsI2KMwhy9UvHf3XSUDfO15or',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya Spot Light',
  ),
  Product(
    name: 'Spoton-M Spot Light',
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1ocMFN3chTbiW0GP2Yfu425ehCXkz3ZD9',
      'https://drive.google.com/uc?export=view&id=1KeaJykoM7kJUF3c3UGtdIxBCzHqziLdo',
    ],
    cost: 29.99,
    category: lights,
    productType: 'Arya Spot Light',
  ),
  Product(
    name: "Spoton-Gold Spot Light",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1eYuuOfYpX9DO62dcvTM2NfV5FPKvgAiR',
      'https://drive.google.com/uc?export=view&id=1Qggv4SukK9jclnet51G9fp0DR6OnTRtB',

    ],
    cost: 300,
    category: lights,
    productType: 'Arya Spot Light',
  ),
  Product(
    name: "Cylinder Spot Light",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=18Zkt-Vs1nNgWni1emLvPXQc7Hghk9bj5',
      'https://drive.google.com/uc?export=view&id=1Qvn6cChJot6A6ax3ipBmWNjayQZtPjj7',

    ],
    cost: 300,
    category: lights,
    productType: 'Arya Spot Light',
  ),
  Product(
    name: 'Street Light',
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1k92b35aetl6FVcTuy_IDyskKrKgQZBPw',
    ],
    cost: 500,
    category: lights,
    productType: 'Arya Street Light',
  ),
  Product(
    name: "Dolphin Street Light",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1eAixB_LHwxfKBOxuATdaCkbQb8eGR-Cm',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya Street Light',
  ),
  Product(
    name: "XBeam Street Light",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1LC3rnnkcUgu6tNCFT-Rzkxps2B76t5Oi',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya Street Light',
  ),
  Product(
    name: "Solar Street Light",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1o1-KzfJK2Uru2juiohCdnBfWs-DvbBCd',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya Street Light',
  ),
  Product(
    name: "Integrated Solar Street Light",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1kf5Cn5CHAeBLaKJcy0eoxVcjZrFwp3Ji',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya Street Light',
  ),
  Product(
    name: "Robo-1 High Bay",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=15lvos9fmsrdMuPiSwT5l0lz9gDRAr2D_',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya High Bay',
  ),
  Product(
    name: "Sudarshan High Bay",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1Vxyp8BmJ-PGJknEzLLL4BEhf3w5tgiTd',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya High Bay',
  ),
  Product(
    name: "Lentis High Bay",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1sCbZcUQ3k-Gcst6VinMhjluUad8HDwyI',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya High Bay',
  ),
  Product(
    name: "Tube Light-PC",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1QMx0W_D4Y3x5ak2TQkgurPRz8lZziqou',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya TubeLight',
  ),
  Product(
    name: "Retro Tube Light(Al)",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1YQx5CYbdaX24eF_SECL2Gk5sJkE_u_sR',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya TubeLight',
  ),
  Product(
    name: "Linear Tube Light",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1nXeRmDYvIgE48lbxHBBEg2XDHHDVv480',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya TubeLight',
  ),
  Product(
    name: "Post Top Lantern",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1qGCjkNTOvemRJwpJDloDldfAk6ii1pSP',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya Lantern',
  ),
  Product(
    name: "Hanging Lantern",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1MoEf2ONvu_E_lrnvAjVcNVJWQjK0G0Rx',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya Lantern',
  ),
  Product(
    name: "Bollard Lantern",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=13sq51YLVzHk8c3u875r0ZuwD2ITm9wIa',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya Lantern',
  ),
  Product(
    name: "Decorative Pole Lantern",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1awwgDGqDYyPPtRu2yrVzu1KurBARGA2P',
    ],
    cost: 200,
    category: lights,
    productType: 'Arya Lantern',
  ),
  Product(
    name: 'EfiSlim Ceiling Fan',
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1KULu3KYplIhlkp2NCEtcnKWPy8xQbL0D',
      'https://drive.google.com/uc?export=view&id=1PcpuG3pHk2zvt1NBpqTNzPfZjG8EqrUA',
    ],
    cost: 16.99,
    category: fan,
    productType: 'Polar Ceiling Fan',
  ),
  Product(
    name: 'Prolific Ceiling Fan',
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1Z7ghwfAojEt1hFzxZ8n0ZLfR1DC878Q5',
      'https://drive.google.com/uc?export=view&id=1KjzT785hRFI719UdY1MfhnVNSEFljYJI',
    ],
    cost: 22.99,
    category: fan,
    productType: 'Polar Ceiling Fan',
  ),
  Product(
    name: 'PS-31 Ceiling Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1Z9VriKGzA2Ad6a7aq9sSt1mK5tMyCobd',
      'https://drive.google.com/uc?export=view&id=1QSRqwY4buQOUZ8mPXPli9nrhP2QECwqs',
    ],
    cost: 28.99,
    category: fan,
    productType: 'Polar Ceiling Fan',
  ),
  Product(
    name: 'Efysavy Anit-Dust Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1cSf_uWGGkbgwSpa2f-kjIddA_Y65HEv3',
      'https://drive.google.com/uc?export=view&id=1xJjP7-1DgxyQXQ1OZz-Z93Ed6gDtD7Ca',
    ],
    cost: 28.99,
    category: fan,
    productType: 'Polar Ceiling Fan',
  ),
  Product(
    name: 'Winaire++ Ceiling Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1yAjheYyT--EXyHnCwAPjEr0UScsTlAze',
      'https://drive.google.com/uc?export=view&id=1ig4FXelLalNFfqOITAEWNY9ZzFDy8ZcA',
    ],
    cost: 28.99,
    category: fan,
    productType: 'Polar Ceiling Fan',
  ),
  Product(
    name: 'Mini Ceiling Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1yyH4k6OO0uefmzKUWjykdbGrcAwJuvaa',
      'https://drive.google.com/uc?export=view&id=1sxlF8JH3G4Dc8wisW7Kv3XBph7gVrNzV',
    ],
    cost: 28.99,
    category: fan,
    productType: 'Polar Ceiling Fan',
  ),
  Product(
    name: 'Pinnacle Table Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=19_LzL89Crnf3JmHmP1KqFdbwsw67lBd5',
      'https://drive.google.com/uc?export=view&id=1xmfGLjxy_BeQj0K7KNBVHaaVgLSgVbvB',
    ],
    cost: 28.99,
    category: fan,
    productType: 'Polar Table Fan',
  ),
  Product(
    name: 'Annexer-MB Table Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1GRg_ZXZmfh6xTdc7t4R_3PD42y3qNVyu',
      'https://drive.google.com/uc?export=view&id=1r6H22S2icRfwzGbRLSwV3lVSqD9e_UuC',
    ],
    cost: 28.99,
    category: fan,
    productType: 'Polar Table Fan',
  ),
  Product(
    name: 'Conquest Table Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1QzDlM9GlJu7ZV7ciseHKNufyDRXnsejz',
      'https://drive.google.com/uc?export=view&id=1_a1tIiAEjPtKT-9DhhPwTV9pzKFdAP_K',
    ],
    cost: 28.99,
    category: fan,
    productType: 'Polar Table Fan',
  ),
  Product(
    name: 'Stormy-Neo Table Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=17u3xEBoonuBneCZprEnDhH30Phi4s_85',
      'https://drive.google.com/uc?export=view&id=1O0hgp8WdHgXadSQIjYc1tazktDdrk3Ts',
    ],
    cost: 28.99,
    category: fan,
    productType: 'Polar Table Fan',
  ),
  Product(
    name: 'Fanny Wall Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1RxS40DgKZeaM3ZMr7yhFCEE_R2-xKmHq',
      'https://drive.google.com/uc?export=view&id=1wuEa9sK3inYFzB7T98XQ3KbZrKG8clM6',
    ],
    cost: 28.99,
    category: fan,
    productType: 'Polar Wall Fan',
  ),
  Product(
    name: 'Conquest-Pro Wall Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1qh8CluJB0z9RYG_XvRztyYjN-lXWbvBq',
      'https://drive.google.com/uc?export=view&id=1ap_kRBTnSrMLbkStqZTFyVsRkrCgi0kw',
    ],
    cost: 28.99,
    category: fan,
    productType: 'Polar Wall Fan',
  ),
  Product(
    name: 'Exhaust Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1tpYJSpCiwX5Jis0klT_kn8ukqKqTFyPu',
      'https://drive.google.com/uc?export=view&id=1kk2iJpZbtFr88yL5kV0xIhpEd1rZklmi',
    ],
    cost: 28.99,
    category: fan,
    productType: 'Polar Exhaust Fan',
  ),
  Product(
    name: "Stealth Puro Ceiling Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1Mqx1unniCTEsOXfEDG0YAEtOniv0uUal',
      'https://drive.google.com/uc?export=view&id=1zCJzJ6S4kvYIaRoH039aJjO2Qw33EHS1',
    ],
    cost: 34.99,
    category: fan,
    productType: 'Havells Ceiling Fan',
  ),
  Product(
    name: "ALbus BLDC Ceiling Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1yMuWPS7VMzVZwh5k-e4UBeAZ-E1kkVZ7',
      'https://drive.google.com/uc?export=view&id=1dP62jbdZGC_Vom0wWup1mpV1rl9eHwhL',
    ],
    cost: 34.99,
    category: fan,
    productType: 'Havells Ceiling Fan',
  ),
  Product(
    name: "Lumeno Ceiling Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1OkROYF3R-1GjiLcus4cDcvvWuaJddo1W',
      'https://drive.google.com/uc?export=view&id=1HSGaHVOyCzkkPanULgMuqLCAcnBLGbDh',
    ],
    cost: 34.99,
    category: fan,
    productType: 'Havells Ceiling Fan',
  ),
  Product(
    name: "Kids Room Ceiling Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1y2CtsJAIWoi2eaPgy7S7xvDWPeaGJ4VU',
      'https://drive.google.com/uc?export=view&id=1_54Pk6jMbkv0T2maF1fvcWcKBmF_RRjU',
      'https://drive.google.com/uc?export=view&id=1Z1gw_OyBdYzEJw1P6Bcjh2bJrP4QmOtV',
    ],
    cost: 34.99,
    category: fan,
    productType: 'Havells Ceiling Fan',
  ),
  Product(
    name: "Festiva-ES Ceiling Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1NhEIq4Btj3lpori371nLe1DutPSY9XMv',
      'https://drive.google.com/uc?export=view&id=1Dj7voMuEwCT6grdILOIo1SnmiwSAiFg0',
      'https://drive.google.com/uc?export=view&id=1wSpTLvQtmsllQRyzxFQm5Wgotk-6tD3t',
    ],
    cost: 34.99,
    category: fan,
    productType: 'Havells Ceiling Fan',
  ),
  Product(
    name: "ES-40-50 Ceiling Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1LZyJIxBuQ-C6rXOxZpgbNtnB8WEaks9S',
      'https://drive.google.com/uc?export=view&id=1twXOiQmzK98TNHA9dKHwAAUawMNO8l6R',
      'https://drive.google.com/uc?export=view&id=1CvBhhtP8SUg_X89Mv_C180qSDel7lbLq',
    ],
    cost: 34.99,
    category: fan,
    productType: 'Havells Ceiling Fan',
  ),
  Product(
    name: "Girik-Gold Wall Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1HzM9FrHWY7qmtgeZMaeaZ28MivRUnRhu',
    ],
    cost: 34.99,
    category: fan,
    productType: 'Havells Wall Fan',
  ),
  Product(
    name: "AinDrila Wall Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1aGbO1y9k8hOWhh_hNvFROKB60rLQUHOD',
    ],
    cost: 34.99,
    category: fan,
    productType: 'Havells Wall Fan',
  ),
  Product(
    name: "Ciera-HS Wall Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1iC-dJs7KC5voNV6lwmKFbVzKT-kan-5Y',
    ],
    cost: 34.99,
    category: fan,
    productType: 'Havells Wall Fan',
  ),
  Product(
    name: "Ventiliar Exhaust Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1KHw31SIG6kKL6eXWkUAabQF9E73aTEfs',
    ],
    cost: 34.99,
    category: fan,
    productType: 'Havells Exhaust Fan',
  ),
  Product(
    name: "Ventiliar-DX Exhaust Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1Ip9G2vyzUhuz7WwvBa5JIIS9unC6os_U',
    ],
    cost: 34.99,
    category: fan,
    productType: 'Havells Exhaust Fan',
  ),
  Product(
    name: "Ventiliar-DB Exhaust Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=12Aaa4-n2SzyOj6Ehaz24XMmh4OdmlC9E',
    ],
    cost: 34.99,
    category: fan,
    productType: 'Havells Exhaust Fan',
  ),
  Product(
    name: "Ventiliar-DX-C Exhaust Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1HX5Mhh0a_7vo8-MTJzisop_lnjcwPZ8i',
      'https://drive.google.com/uc?export=view&id=1ToMGvUVdUHHn_0cTcW2HtLzaluCS5sMm',
    ],
    cost: 34.99,
    category: fan,
    productType: 'Havells Exhaust Fan',
  ),
  Product(
    name: 'HR-FR-LSH green wires',
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1cQsiU3UvLRN17psWC2kjffQN7i_0KdQD',
    ],
    cost: 9.99,
    category: wires,
    productType: 'Polycab Wires',
  ),
  Product(
    name: 'FR-LSH High_Performence Wires',
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=195P0cdg7cXw7pu_RZ09MFXMuOVSSvwB_',
    ],
    cost: 11.99,
    category: wires,
    productType: 'Polycab Wires',
  ),
  Product(
    name: 'FR-LF single-core Wires',
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1tIDqdmMDKauYSvFI5GrkK7rh5Za92X_I',
    ],
    cost: 8.99,
    category: wires,
    productType: 'Polycab Wires',
  ),
  Product(
    name: "Building Wires",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1xabiJ1UK_Hu_i1Y8bPCtDRkQF92bd6Zi',
      'https://drive.google.com/uc?export=view&id=1ourCqx445ftiswGGs0hNZE1HfoXzjTZt',
    ],
    cost: 10.99,
    category: wires,
    productType: 'Pressfit Wires',
  ),
  Product(
    name: "Industrial Cable Wires",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1tX0j9-fitAtu_cZ_OPMyKcZQkmsGfwEZ',
      'https://drive.google.com/uc?export=view&id=1nwXDOdaFmHrquMw5abYa5Yz7jA50Ov3R',
      'https://drive.google.com/uc?export=view&id=1zQ42jMQBAhmtvUQpYs7UT4SAnnzjb1vn',
    ],
    cost: 10.99,
    category: wires,
    productType: 'Pressfit Wires',
  ),
  Product(
    name: "Aluminium Cables",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1V7yc6A6xFORNiP_xmkGbt1NXcSKEOh_D',
      'https://drive.google.com/uc?export=view&id=18ZL-WZZdAlcDXC5HYjU-8XJNT4BAz9wd',
    ],
    cost: 10.99,
    category: wires,
    productType: 'Pressfit Wires',
  ),
  Product(
    name: "Twisted-Pair Cables",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1gTAT6wb4v0lEGNa5BwQJWxHOc8Lr16gn',
      'https://drive.google.com/uc?export=view&id=18ZL-WZZdAlcDXC5HYjU-8XJNT4BAz9wd',
    ],
    cost: 10.99,
    category: wires,
    productType: 'Pressfit Wires',
  ),
  Product(
    name: "Lan Cables",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=12MgEc0Enn4WAt4XCezANWyf9MLedOfmN',
      'https://drive.google.com/uc?export=view&id=1-AgWzU5Yw4o9MV43GLX8GtHl2Ug2lU9a',
    ],
    cost: 10.99,
    category: wires,
    productType: 'Lan Cable',
  ),
  Product(
    name: "RG6 Coaxial Cable",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1qN7fgjBEh0X4QtbBQEYH9Q_1ngYkKXAv',
      'https://drive.google.com/uc?export=view&id=1-AgWzU5Yw4o9MV43GLX8GtHl2Ug2lU9a',
    ],
    cost: 10.99,
    category: wires,
    productType: 'Coaxial Cable',
  ),
];
