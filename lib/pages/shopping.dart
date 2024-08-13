import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  child: InteractiveViewer(
                    minScale: 1,
                    maxScale: 5,
                    child: Image.network(
                      selectedImageUrl!,
                      fit: BoxFit.cover,
                      color: kGreyBackground,
                      colorBlendMode: BlendMode.multiply,
                    ),
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
                    '₹${product.cost}',
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
              '₹${product.cost.toString()}',
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
  void _openDialPad() async {
    const phoneNumber = 'tel:+918964930559';
    final Uri url = Uri.parse(phoneNumber);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {// Debugging output
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
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
                  '₹${item.product.cost}',
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
                      '₹${cart.totalCost.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                CallToActionButton(
                  onPressed: () {
                    _openDialPad();
                  },
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

  /// Which overall category this product belongs
  final Category category;

  /// Represents type of product
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
  'Surya LED Lamp',
  'Surya TubeLight',
  'Surya Ceiling Light',
  'Surya Spot Light',
  'Surya Street Light',
  "Surya Flood Light",
]);
Category fan = Category(title: 'Fan', selections: [
  'Polar Economy Fan',
  'Polar Regular Fan',
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
  'Pressfit Switch',
  'Pressfit Switch Plate',
  'Pressfit Modular Switch',
]);
Category mcb = Category(title: 'MCB', selections: [
  'MCB',
  'RCCB',
  'Isolator',
  'Changeover',
  'Fuse',
  'Distribution Box',
]);
Category applince = Category(title: 'Other Applinces', selections:[
  'Iron',
  'Mixer Grinder',
  'Water Heater',
  'Induction',
  'Oven',
  'Air Fryer',
  'Toaster',
  'Rice Cooker',
  'Juicer',
  'Miscellaneous'
]);
final kGreyBackground = Colors.grey[200];

// TODO: Fetch products and feed into widgets
List<Product> products = [
  Product(
      name: 'Surya Neo MAXX 10W LED',
      imageUrls: [
        'https://drive.google.com/uc?export=view&id=1vLr-oXx0YQWrOvTkspcWakS0YKt_-2tO',
      ],
      cost: 163,
      description: '10W - ₹163 | 12W - ₹275 | 15W - ₹320 | 18W - ₹450',
      category: lights,
      productType: 'Surya LED Lamp',
  ),
  Product(
    name: 'Surya DURO 30W LED Lamp',
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1JvBNGHPl4dp3Y97C95LS8zN7WsTC9Psh',
    ],
    cost: 750,
    description: '30W - ₹750 | 40W - ₹850 | 50W - ₹999 ',
    category: lights,
    productType: 'Surya LED Lamp',
  ),
  Product(
    name: 'Surya 0.5W LED Lamp',
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1AFEbDw1DF6QyDuDsyNICGK87uZEeGmw5',
      'https://drive.google.com/uc?export=view&id=1NGIrENIQwquy_bN7Trnqkshf1yW94ISu',
      'https://drive.google.com/uc?export=view&id=1ZRqoiHrRf-hPRf3tSG8bMyZaAIp1K8He',
    ],
    cost: 55,
    description: 'Single Colour 0.5W - ₹55 | Rainbow auto colour changing RGB 0.5W - ₹75',
    category: lights,
    productType: 'Surya LED Lamp',
  ),
  Product(
    name: 'ECO Prime 4W SpotLight' ,
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1nSfY0SK-5X-UBxUuPTmVqIv4qAxuyOud',
    ],
    cost: 425,
    description: '4W - ₹425 | 6W - ₹475 | 9W - ₹750 | 12W - ₹900 ',
    category: lights,
    productType: 'Surya Spot Light',
  ),
  Product(
    name: 'Aura Prime 4W SpotLight',
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1u8F3QK7tCMl-yumzcRTUgPsMu9zvEC1D',
    ],
    cost: 300,
    description: '4W - ₹300 | 6W - ₹400 | 12W - ₹550 ',
    category: lights,
    productType: 'Surya Spot Light',
  ),
  Product(
    name: "Prime Spot 1W SpotLight",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1fcHD4HLqvTEvY3MOhBn34FUuLfgU8hHh',
    ],
    cost: 199,
    category: lights,
    productType: 'Surya Spot Light',
  ),
  Product(
    name: 'Surya GeNXT 20W Street Light',
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1Ke61OryX6txNcxrpjQYHoSwzfd6Otg-p',
    ],
    cost: 2000,
    description: '20W - ₹2000 | 30W - ₹2500 |  50W - ₹4000',
    category: lights,
    productType: 'Surya Street Light',
  ),
  Product(
    name: "Surya GeNXT 30W Flood Light",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1gIHQNvo478p_Rdc71b06fTa0-HdJcPpC',
    ],
    cost: 2500,
    description: '30W - ₹2500 | 50W - ₹4000 | 100W - ₹7000',
    category: lights,
    productType: 'Surya Flood Light',
  ),
  Product(
    name: "Surya GeNXT 10W Flood Light",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1chF-WAww722QumxRcjlfhDZML1ZhTgo_',
    ],
    cost: 1500,
    description: '10W - ₹1500 | 20W - ₹2000 | 30W - ₹2500 | 50W - ₹3500',
    category: lights,
    productType: 'Surya Flood Light',
  ),
  Product(
    name: "Surya Dazzle Round 3W Ceiling Light",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=18MWmnbEPE87MjD2ja54nQwswG53wlAfK',
    ],
    cost: 400,
    description: '3W - ₹400 | 6W - ₹500 | 10W - ₹600 | 12W - ₹725 | 15W - ₹850 | 22W - ₹1000',
    category: lights,
    productType: 'Surya Ceiling Light',
  ),
  Product(
    name: "Surya Dazzle Square 3W Ceiling Light",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1dfiCXBflubJdBkOifmV_jDX3omdzNIck',
    ],
    cost: 400,
    description: '3W - ₹400 | 6W - ₹500 | 10W - ₹600 | 12W - ₹725 | 15W - ₹850 | 22W - ₹1000',
    category: lights,
    productType: 'Surya Ceiling Light',
  ),
  Product(
    name: "Surya SuperStriker 4W Ceiling Light",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1lgIUw8q4OsAxVpyj5xncpgELz-25Ugsb',
    ],
    cost: 225,
    description: '4W - ₹225 | 8W - ₹300 ',
    category: lights,
    productType: 'Surya Ceiling Light',
  ),
  Product(
    name: "Surya Smart Downlight 15W ",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1Zg7eMZ6eXZLnb-_GWhnIpXesWxJgYEbK',
    ],
    cost: 1500,
    description: '15W LED* - ₹1500 + Remote - ₹500 ',
    category: lights,
    productType: 'Surya Ceiling Light',
  ),
  Product(
    name: "Surya G-Line ECO 5W",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=12Q0oG3isNWsXF2st_33wCPNLYj1k0IqR',
    ],
    cost: 300,
    description: '5W - ₹300 | 10W - ₹350 | 20W - ₹450 | 25W - ₹500',
    category: lights,
    productType: 'Surya TubeLight',
  ),
  Product(
    name: "Surya G-Line ECO Colour 20W",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1ot19bddjE_YNJ8PWP-wNY_snAttduXvJ',
      'https://drive.google.com/uc?export=view&id=16EV4kieeSde_C8hQSYwo2G2hw8zyTaPT',
    ],
    cost: 450,
    category: lights,
    productType: 'Surya TubeLight',
  ),
  Product(
    name: "Surya AMAZE 40W LED",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1CccpNzoajtDkAjv38DLZp7rxm0XI0ylK',
    ],
    cost: 999,
    description: '40W - ₹999 | 48W - ₹1200 | 60W - ₹2500 ',
    category: lights,
    productType: 'Surya TubeLight',
  ),
  Product(
    name: 'Meganite-HS 600MM Ceiling Fan',
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1ta9tlEiI5hvGMKjk9fx6qDWwxHwVU2fG',
      'https://drive.google.com/uc?export=view&id=1Ay83anh-Sd4DRVC3qBq6DBUevE1rbyE9',
    ],
    cost: 700,
    description: '600MM - ₹700 | 900MM - ₹750 | 1200MM - ₹800',
    category: fan,
    productType: 'Polar Economy Fan',
  ),
  Product(
    name: 'Meganite-DECO 900MM Ceiling Fan',
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1LYNpPUJ7QDomerXBwRn4q2_7Y-CV_98g',
      'https://drive.google.com/uc?export=view&id=1_QBPkfYyNb8ufnRGlMqIzuqMPhrbUm86',
    ],
    cost: 750,
    category: fan,
    productType: 'Polar Economy Fan',
  ),
  Product(
    name: 'Winchester 1200MM Ceiling Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1H2hnU20lPpKX3zzHppC3ernwTdKDBi90',
      'https://drive.google.com/uc?export=view&id=1Y5QIwff7YbbnpCw35gqq4KoIs88dHBuz',
    ],
    cost: 950,
    category: fan,
    productType: 'Polar Economy Fan',
  ),
  Product(
    name: 'Pavilion-HS 900MM Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1CD3OKmmL7FXQK3Q2L8tvTn6rrSESWYa7',
      'https://drive.google.com/uc?export=view&id=1uwBR0xeLnkMZvcTWsiElKo87L5yaSEA_',
    ],
    cost: 800,
    category: fan,
    productType: 'Polar Economy Fan',
  ),
  Product(
    name: 'Payton 1400MM Ceiling Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1KMOAgerDY-5HyK2OqUUs0N0FK1fdYXfG',
      'https://drive.google.com/uc?export=view&id=19__lRXAir1THRj0Vx-IiAs07Wu9H4iD9',
    ],
    cost: 700,
    category: fan,
    productType: 'Polar Economy Fan',
  ),
  Product(
    name: 'Prolific 1200MM Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1LTZ9SPv0rG8kC8x03b0UgWhnswQIAsQy',
      'https://drive.google.com/uc?export=view&id=1MBRUOTzIkWoddxfpu8PikvZDdxz0UFvs',
    ],
    cost: 700,
    category: fan,
    productType: 'Polar Regular Fan',
  ),
  Product(
    name: 'Corvette Anti Dust 1200MM Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1LULQ1ygkbYaaiZaeAJWFbo535GsnDfDC',
      'https://drive.google.com/uc?export=view&id=1ET-fJOL2SaxWn9OFmuxSnpW4g3V54pQ1',
    ],
    cost: 900,
    category: fan,
    productType: 'Polar Regular Fan',
  ),
  Product(
    name: 'Winpro MX 1200MM Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=10j7bUkKhI82idKQgLnwqnsgRHOoSj1Jl',
      'https://drive.google.com/uc?export=view&id=1R7JdQKBnlRrQm2LVppIPzjt-grLRYRV6',
    ],
    cost: 800,
    category: fan,
    productType: 'Polar Regular Fan',
  ),
  Product(
    name: 'Winpro 900MM Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1k1JZw4jPouRkYWngOQBhb_vsjuDp4EzR',
      'https://drive.google.com/uc?export=view&id=1An0RnM89nD2imcZdbp-EQ20egTisMONQ',
    ],
    cost: 500,
    category: fan,
    productType: 'Polar Regular Fan',
  ),
  Product(
    name: 'Radiant 1200MM Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=12ZoSXQQWTxJA7mb1OysXi-SG7VECRmLd',
      'https://drive.google.com/uc?export=view&id=1007fx455D1G5tTEuRUxHBZdzKO3pU7vy',
    ],
    cost: 700,
    category: fan,
    productType: 'Polar Regular Fan',
  ),
  Product(
    name: 'Exhaust 150MM Fan',
    imageUrls: [
      //TODO links not working returning null
      'https://drive.google.com/uc?export=view&id=1tpYJSpCiwX5Jis0klT_kn8ukqKqTFyPu',
      'https://drive.google.com/uc?export=view&id=1kk2iJpZbtFr88yL5kV0xIhpEd1rZklmi',
    ],
    cost: 300,
    description: '150MM - ₹300 | 200MM - ₹350 | 250MM - ₹500',
    category: fan,
    productType: 'Polar Exhaust Fan',
  ),
  Product(
    name: "Stealth Puro Ceiling Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1Mqx1unniCTEsOXfEDG0YAEtOniv0uUal',
      'https://drive.google.com/uc?export=view&id=1zCJzJ6S4kvYIaRoH039aJjO2Qw33EHS1',
    ],
    cost: 0,
    category: fan,
    productType: 'Havells Ceiling Fan',
  ),
  Product(
    name: "ALbus BLDC Ceiling Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1yMuWPS7VMzVZwh5k-e4UBeAZ-E1kkVZ7',
      'https://drive.google.com/uc?export=view&id=1dP62jbdZGC_Vom0wWup1mpV1rl9eHwhL',
    ],
    cost: 0,
    category: fan,
    productType: 'Havells Ceiling Fan',
  ),
  Product(
    name: "Lumeno Ceiling Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1OkROYF3R-1GjiLcus4cDcvvWuaJddo1W',
      'https://drive.google.com/uc?export=view&id=1HSGaHVOyCzkkPanULgMuqLCAcnBLGbDh',
    ],
    cost: 0,
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
    cost: 0,
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
    cost: 0,
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
    cost: 0,
    category: fan,
    productType: 'Havells Ceiling Fan',
  ),
  Product(
    name: "Girik-Gold Wall Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1HzM9FrHWY7qmtgeZMaeaZ28MivRUnRhu',
    ],
    cost: 0,
    category: fan,
    productType: 'Havells Wall Fan',
  ),
  Product(
    name: "AinDrila Wall Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1aGbO1y9k8hOWhh_hNvFROKB60rLQUHOD',
    ],
    cost: 0,
    category: fan,
    productType: 'Havells Wall Fan',
  ),
  Product(
    name: "Ciera-HS Wall Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1iC-dJs7KC5voNV6lwmKFbVzKT-kan-5Y',
    ],
    cost: 0,
    category: fan,
    productType: 'Havells Wall Fan',
  ),
  Product(
    name: "Ventiliar Exhaust Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1KHw31SIG6kKL6eXWkUAabQF9E73aTEfs',
    ],
    cost: 0,
    category: fan,
    productType: 'Havells Exhaust Fan',
  ),
  Product(
    name: "Ventiliar-DX Exhaust Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1Ip9G2vyzUhuz7WwvBa5JIIS9unC6os_U',
    ],
    cost: 0,
    category: fan,
    productType: 'Havells Exhaust Fan',
  ),
  Product(
    name: "Ventiliar-DB Exhaust Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=12Aaa4-n2SzyOj6Ehaz24XMmh4OdmlC9E',
    ],
    cost: 0,
    category: fan,
    productType: 'Havells Exhaust Fan',
  ),
  Product(
    name: "Ventiliar-DX-C Exhaust Fan",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1HX5Mhh0a_7vo8-MTJzisop_lnjcwPZ8i',
      'https://drive.google.com/uc?export=view&id=1ToMGvUVdUHHn_0cTcW2HtLzaluCS5sMm',
    ],
    cost: 0,
    category: fan,
    productType: 'Havells Exhaust Fan',
  ),
  Product(
    name: 'OptimaPlus 90M Wires',
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1Dvaqmz_uAU9jRkjFHNHrMdnmK0cSPgL5',
    ],
    cost: 1003 ,
    description: 'All prices for 90 Metres wire, 0.75MM - ₹1003 | 1MM - ₹1355 | 1.5MM - ₹1978 | 2.5MM - ₹3130 | 4MM - ₹4577 | 6MM - ₹6838 | 10MM - ₹10227 ',
    category: wires,
    productType: 'Polycab Wires',
  ),
  Product(
    name: "Building 90M Wires",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1xabiJ1UK_Hu_i1Y8bPCtDRkQF92bd6Zi',
      'https://drive.google.com/uc?export=view&id=1ourCqx445ftiswGGs0hNZE1HfoXzjTZt',
    ],
    cost: 897,
    description: 'All prices for 90 Metres wire, 0.75MM - ₹897 | 1MM - ₹1128 | 1.5MM - ₹1725 | 2.5MM - ₹2476 | 4MM - ₹4117 | 6MM - ₹6300 ',
    category: wires,
    productType: 'Pressfit Wires',
  ),
  Product(
    name: "Cat-6 Lan Cables 1M",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=12MgEc0Enn4WAt4XCezANWyf9MLedOfmN',
      'https://drive.google.com/uc?export=view&id=1-AgWzU5Yw4o9MV43GLX8GtHl2Ug2lU9a',
    ],
    cost: 71,
    description: '1M - ₹71  | 2M - ₹90 | 10M - ₹230 ',
    category: wires,
    productType: 'Lan Cable',
  ),
  Product(
    name: "RG6 Coaxial Cable 90M",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1qN7fgjBEh0X4QtbBQEYH9Q_1ngYkKXAv',
      'https://drive.google.com/uc?export=view&id=1-AgWzU5Yw4o9MV43GLX8GtHl2Ug2lU9a',
    ],
    cost: 700,
    description: '90M - ₹700 | 100M - ₹999 ',
    category: wires,
    productType: 'Coaxial Cable',
  ),
  Product(
    name: "Switch Button",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1danXpOnTdfW_vMiCHwb36O38NaXUxSNu',
      'https://drive.google.com/uc?export=view&id=1jC-SiaTxFwKlRHCTlTUOZbuNddworQaP',
    ],
    cost: 25,
    category: switchh,
    productType: 'Pressfit Switch',
  ),
  Product(
    name: "Doorbell Button",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=18V9K6ujTjcuSrlx8ppIPONbnblWlqIgg',
      'https://drive.google.com/uc?export=view&id=1bUdgZh_UEroLrV7H_SceJcy-fusjwm_6',
    ],
    cost: 55,
    category: switchh,
    productType: 'Pressfit Switch',
  ),
  Product(
    name: "Socket",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1Nad5GHnZm0MXccw7KJAk65If-BmV0VVK',
    ],
    cost: 45-75,
    category: switchh,
    productType: 'Pressfit Switch',
  ),
  Product(
    name: "Fan Regulator",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=11lClPfBYg08wGrEf--zk-kGz_h4Xeshr',
    ],
    cost: 205,
    category: switchh,
    productType: 'Pressfit Switch',
  ),
  Product(
    name: "Lamp & Indicator",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1EgRQ-qA7kQMBi0dBU4vgbSeT1lBc0gW3',
    ],
    cost: 45,
    category: switchh,
    productType: 'Pressfit Switch',
  ),
  Product(
    name: "Pattern Switch",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1AeUVLcitdGRC2fASU5h5FCwr8SFybSXH',
      'https://drive.google.com/uc?export=view&id=1giBza6hxuwljQtX11iwsBqIO6brVxffy',
      'https://drive.google.com/uc?export=view&id=1_msPkQbpjh4lCVb0n8RhH1e4WaU3NYqT',
    ],
    cost: 215,
    description: '2M - ₹215 | 3M - ₹258 | 4M - ₹360 | 6M - ₹560 | 8M(HOR) - ₹613 | 8M(sqr) - ₹613',
    category: switchh,
    productType: 'Pressfit Switch Plate',
  ),
  Product(
    name: "Solid Color Switch",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1ppwEA8WU3Nr4NVHzt-j8FLRLEYlbSgGT',
      'https://drive.google.com/uc?export=view&id=1BevB2F2OPw9JM0TqQMdU71939LqqE5Yh',
      'https://drive.google.com/uc?export=view&id=1tFxz321If7RxBjnjHPAEuF9Ej8h1wc2K',
    ],
    cost: 51,
    description: '1M - ₹51 | 2M - ₹51 | 3M - ₹54 | 4M - ₹60 | 6M - ₹83 | 8M(HOR) - ₹104 | 8M(sqr) - ₹100 | 12M - ₹142 | 16M - ₹177 | 18M - ₹204',
    category: switchh,
    productType: 'Pressfit Switch Plate',
  ),
  Product(
    name: "MCB",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1XSwbLM7UbqagLQX9ALyb4yKBSQq9ehFe',
      'https://drive.google.com/uc?export=view&id=1tv3LVVWogcqjlKGXo0TvsQqCee0-r4JY',
    ],
    cost: 120,
    category: mcb,
    productType: 'MCB',
  ),
  Product(
    name: "Mini MCB",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1gDMF28gHPgX_JtZT9ndQIqBnRTIA5xBo',
    ],
    cost: 150,
    category: mcb,
    productType: 'MCB',
  ),
  Product(
    name: "RCCB",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1iPaefiU5Q9WDBJAmqUSzPZcn8clIF89K',
    ],
    cost: 2500,
    category: mcb,
    productType: 'RCcB',
  ),
  Product(
    name: "Isolator",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1qr3BUYuAGNlxcb-xdfJbYVyouo_1757r',
      'https://drive.google.com/uc?export=view&id=1wqra0vhcwvK_Ajm-Ogocer1hbS9XRKBM',
    ],
    cost: 320,
    description: "40W - ₹320 ,63W - ₹400, 100W - ₹560" ,
    category: mcb,
    productType: 'Isolator',
  ),
  Product(
    name: "Changeover",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1j7evZIjtUCcaeDJORSQLG_sFtkMAjWzg',
    ],
    cost: 540,
    description: "25W - ₹540 ,40W - ₹725 ,63W - ₹1000",
    category: mcb,
    productType: 'Changeover',
  ),
  Product(
    name: "Fuse",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1-wf0lFVI46bBpigF2sU9q24R-q9X70p5',
    ],
    cost: 77,
    description: "16A-240V - ₹77 ,16A-415V - ₹131 ,32A-415V - ₹240 ,63A-415V - ₹600, 100A-415V - ₹1060",
    category: mcb,
    productType: 'Fuse',
  ),
  Product(
    name: "Distribution Board",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=14HIGM422hwNtW-FU_ojEUFIPi18EgIVb',
      'https://drive.google.com/uc?export=view&id=1z8IynqPkGpi2TDn_R7tRDgujDrIRYd8F',
      'https://drive.google.com/uc?export=view&id=1ZBGu6UCVrhLJXfKDsfNAO_KC3g4S0Zyr',
      'https://drive.google.com/uc?export=view&id=1snMHoLVgyDLq9LoHBfI9bE--GPrBUnxa',
    ],
    cost: 1100,
    description: "4way - ₹1100 ,6way - ₹1250 ,8way - ₹1400 ,12way - ₹1800",
    category: mcb,
    productType: 'Distribution Box',
  ),
    Product(
    name: "Havells 35L Oven",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1oucESAbZ0nhdo4T32yJdZRw37ScX2ZTj',
    ],
    cost: 0,
    category: applince,
    productType: 'Oven',
  ),
  Product(
    name: "Havells 28L Oven",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1rPF6QSUcWKuAxAh3Jm58XgPHrwaNjeMJ',
    ],
    cost: 0,
    category: applince,
    productType: 'Oven',
  ),
  Product(
    name: "Havells 66L Oven",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=18ka09XqlsTibdG-mnMwb4eW27AKC4GFE',
    ],
    cost: 0,
    category: applince,
    productType: 'Oven',
  ),
  Product(
    name: "Havells 48L Oven",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1DbZujJ-fOK44kS6-9egpm_8pj9e2P6wm',
    ],
    cost: 0,
    category: applince,
    productType: 'Oven',
  ),
  Product(
    name: "Havells 36L Oven",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1guJNqya4BjJHo8uqWsi62khzw-E_A4-N',
    ],
    cost: 0,
    category: applince,
    productType: 'Oven',
  ),
  Product(
    name: "Havells 24L Oven",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1A5_6AieNjtLWrheQ5xik1oA_aXh8nFNR',
    ],
    cost: 0,
    category: applince,
    productType: 'Oven',
  ),
  Product(
    name: "Havells 16L Oven",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1leZSVnt3wGADyhJt5apEBaF-s72U2Cwf',
    ],
    cost: 0,
    category: applince,
    productType: 'Oven',
  ),
  Product(
    name: "Havells 9L Oven",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1gKK6uVOLBXOgxGWthjN128kTBVtFEAtW',
    ],
    cost: 0,
    category: applince,
    productType: 'Oven',
  ),
  Product(
    name: "Havells Prolife Grande Air Fryer",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1d_c03k4O8hMeAOtFvBZP0dUZg8ugMdaA',
    ],
    cost: 0,
    category: applince,
    productType: 'Air Fryer',
  ),
  Product(
    name: "Havells Digi Grande Air Fryer",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1xExDlheAuM0Ra26lFmUag-Ru0gYOtRrx',
    ],
    cost: 0,
    category: applince,
    productType: 'Air Fryer',
  ),
  Product(
    name: "Havells Air Oven Digi",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1C4e_LEUsL9NWnvSG26Vyd6YEtjveSTyV',
      'https://drive.google.com/uc?export=view&id=1xI2OYvQ6_mtUE_yW8Bj2vcRNa2l7AV9o',
    ],
    cost: 0,
    category: applince,
    productType: 'Air Fryer',
  ),
  Product(
    name: "Havells Feasto Pop-up Toaster",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1Gsgjg_FUi2sowiJ6yoOfbh_V_m0qYIxN',
      'https://drive.google.com/uc?export=view&id=1bL3ZWPd3fmE9_VXKynW0sW3sNrHsD9lC',
    ],
    cost: 0,
    category: applince,
    productType: 'Toaster',
  ),
  Product(
    name: "Havells Chrisp Pop-up Toaster",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1s1VHTMOSKEbwVGGOZ88swbdFIwHTPq2M',
      'https://drive.google.com/uc?export=view&id=1smHjnSs0ZPA1C-8cu3iBKPQS3NrRRAza',
    ],
    cost: 0,
    category: applince,
    productType: 'Toaster',
  ),
  Product(
    name: "Havells Grill & BBQ Toaster",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1Fy_7tS3gSlCtPYrvnXYuOUUnTReD24RD',
    ],
    cost: 0,
    category: applince,
    productType: 'Toaster',
  ),
  Product(
    name: "Havells Sandwich Maker",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1IVOnE_OUK9AgHwtRgcipmUsiFXszUYJM',
      'https://drive.google.com/uc?export=view&id=1vUVtyP2xRm2wPoHAFs7Oov_8aU7M-yLF',
    ],
    cost: 0,
    category: applince,
    productType: 'Toaster',
  ),
  Product(
    name: "Havells Mini Sandwich Maker",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1QrrXUoSxAA8mfVjrPY3rvWCobbw_7JC6',
      'https://drive.google.com/uc?export=view&id=184Uh_3zQoTgv9GiypY-liTDfCk-JvgqU',
    ],
    cost: 0,
    category: applince,
    productType: 'Toaster',
  ),
  Product(
    name: "Havells TC20 Induction",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1A90QyRL6VON4Nqovvmvqc_FJlHnqV-2h',
    ],
    cost: 0,
    category: applince,
    productType: 'Induction',
  ),
  Product(
    name: "Havells TC18 Induction",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1lf5tPMqAAFR9FVMgU6qt8uv8gTy5_8pL',
    ],
    cost: 0,
    category: applince,
    productType: 'Induction',
  ),
  Product(
    name: "Havells TC16 Induction",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1Y6xlvtCPUzKPYgDqEqGIGUJkZlqtI_fJ',
    ],
    cost: 0,
    category: applince,
    productType: 'Induction',
  ),
  Product(
    name: "Havells ET-X Induction",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1zcV1iG8GYSmR8w2h_I2mn9NI9ggi7AvA',
    ],
    cost: 0,
    category: applince,
    productType: 'Induction',
  ),
  Product(
    name: "Havells QT Induction",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1ONpE-AySwebF1smiS-S4ESaKNpumIh1C',
    ],
    cost: 0,
    category: applince,
    productType: 'Induction',
  ),
  Product(
    name: "Havells 2.8L Rice Cooker",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1iSCs07HT0anDhHLOxGWJ7Gq9yyHqs4uk',
    ],
    cost: 0,
    category: applince,
    productType: 'Rice Cooker',
  ),
  Product(
    name: "Havells 1.8L Rice Cooker",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1onVAab-HCGjageHEMgPIaHloR7AmYcgC',
    ],
    cost: 0,
    category: applince,
    productType: 'Rice Cooker',
  ),
  Product(
    name: "Polar Mixo 500W Mixer Grinder",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1bIAIaGUww58j3gxzk_E10TJqjjMYVcvW',
    ],
    cost: 1200,
    description: '500W - ₹1200 | 750W - ₹1500 ',
    category: applince,
    productType: 'Mixer Grinder',
  ),
  Product(
    name: "Polar Puma 500W Mixer Grinder",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1vZ8mtGqTOKDjNpRysD-ow1HUa7LRWacM',
    ],
    cost: 900,
    category: applince,
    productType: 'Mixer Grinder',
  ),
  Product(
    name: "Havells Hexo 1000W Mixer Grinder",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1KbwSf9aAfgGa5R8VlGbQx197ZhAlLqBS',
      'https://drive.google.com/uc?export=view&id=1tg9TdjcO_Sr1DfWyOAe2jFzmDi09_58f',
    ],
    cost: 0,
    category: applince,
    productType: 'Mixer Grinder',
  ),
  Product(
    name: "Havells Silencio 500W Mixer Grinder",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1BF84G9WOj0GIE2aEJvhhWgX0DTqi9Vid',
      'https://drive.google.com/uc?export=view&id=1HC8qGWWbyF0bEaZIpY25oR0iiLDmZde4',
    ],
    cost: 1200,
    category: applince,
    productType: 'Mixer Grinder',
  ),
  Product(
    name: "Havells Hunk 800W Mixer Grinder",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1YlL8PtCOojAxjby2TzqfZMkZ3Qb32bDp',
      'https://drive.google.com/uc?export=view&id=10-NpL27XDST5Wlte0ngWABBiL_xhqHp1',
    ],
    cost: 0,
    category: applince,
    productType: 'Mixer Grinder',
  ),
  Product(
    name: "Havells Tuff 750W Mixer Grinder",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1Ig1Kv-2yzB7xB1PojQVEClDnENGghYGV',
      'https://drive.google.com/uc?export=view&id=1pmtw6k_HQUuYsKx2qt0TqBb8FwXlyd75',
    ],
    cost: 1500,
    category: applince,
    productType: 'Mixer Grinder',
  ),
  Product(
    name: "Havells Aspro 600W Mixer Grinder",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=13hZskWAUQtxsLgh5ZtS-INQm77692HFX',
    ],
    cost: 0,
    category: applince,
    productType: 'Mixer Grinder',
  ),
  Product(
    name: "Polar Refresha-pro 3L",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1uQ6QVaAlMaWOmZFojiWykY84_qHQF8x5',
    ],
    cost: 1500,
    category: applince,
    productType: 'Water Heater',
  ),
  Product(
    name: "Polar Aquahot 6L",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1swlhcogSIV5768QrYbb3soiFZvJ6E3OX',
    ],
    cost: 2200,
    description: '6L - ₹2200 | 10L - ₹3100 | 15L - ₹3900 ',
    category: applince,
    productType: 'Water Heater',
  ),
  Product(
    name: "Havells Hexo 1000W Juicer",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1fiDRB9jwai0buh8V0WWvhcyobYvE6rja',
      'https://drive.google.com/uc?export=view&id=1ZcDenmLmy5oUgStvDVs72tG3aL5zGkbB'
    ],
    cost: 0,
    category: applince,
    productType: 'Juicer',
  ),
  Product(
    name: "Havells Stilus 500W Juicer",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1NQV4y8B29qM8PJVQP4YMx_y_Ia5xzv0-',
      'https://drive.google.com/uc?export=view&id=1xX85F6c-0dgxXe1v8mmO5y9f-Jh94IOt'
    ],
    cost: 0,
    category: applince,
    productType: 'Juicer',
  ),
  Product(
    name: "Havells Nutri-Art 200W Juicer",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1sPDDv4G1GuPEFBx5UJcmTxtoQ3P_z73h',
    ],
    cost: 0,
    category: applince,
    productType: 'Juicer',
  ),
  Product(
    name: "Havells Press 30W Juicer",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1D0LvrnU3Aemzi-SAtakTvASGEpl7FLaX',
    ],
    cost: 0,
    category: applince,
    productType: 'Juicer',
  ),
  Product(
    name: "Polar D1000M6 Iron",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1WLS9uWABqh2sf2aSjQlYbmF7b_TUii6g',
    ],
    cost: 500,
    category: applince,
    productType: 'Iron',
  ),
  Product(
    name: "Polar 1000P4 Iron",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1fDcU5Ekvn6196jdH82tAhqR7fxJWrES-',
    ],
    cost: 500,
    category: applince,
    productType: 'Iron',
  ),
  Product(
    name: "Polar 1000P5 Iron",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=10Jycj3oN2gh6-VLHFXORUCnoflmmsZYI',
    ],
    cost: 550,
    category: applince,
    productType: 'Iron',
  ),
  Product(
    name: "Polar 1000MH3 Iron",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1M-_b1PCZLAwmaRHcP5OQOpKRKQpn-4sr',
    ],
    cost: 500,
    category: applince,
    productType: 'Iron',
  ),
  Product(
    name: "Havells Husky Steam Iron",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1qBDoTZQzzWhEknAik1ro1GX7TBM2oWrb',
      'https://drive.google.com/uc?export=view&id=14cUb-OOSQ6hqj5bdHEKHiYWsNspMkpcx'
    ],
    cost: 0,
    category: applince,
    productType: 'Iron',
  ),
  Product(
    name: "Havells Plush Steam Iron",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1y2OHHQnXxa0r5mHhzEZPzFLQG7O4mpCH',
      'https://drive.google.com/uc?export=view&id=1G8BrMHZf_nJyAIISw6BTm7J4wT8KQWv5'
    ],
    cost: 0,
    category: applince,
    productType: 'Iron',
  ),
  Product(
    name: "Havells Stealth Dry Iron",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1aA9-yA6Y4JhiNaZlyw687zo70I5z3ait',
    ],
    cost: 0,
    category: applince,
    productType: 'Iron',
  ),
  Product(
    name: "Havells Insta Dry Iron",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1D9ansqV232lqz8qDzDTuiQ50vuN_YPgu',
    ],
    cost: 0,
    category: applince,
    productType: 'Iron',
  ),
  Product(
    name: "Havells Hand Blender",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1yO8wx_2kwCZLAspqEfhcl9SqeGKo_EwB',
      'https://drive.google.com/uc?export=view&id=1Lw-qQqJX3XpefcOO0impG3rybf2QNd44',
      'https://drive.google.com/uc?export=view&id=1Tk80izj0fOHhkUOf44-nHWmdT3DOu9P7',
    ],
    cost: 0,
    category: applince,
    productType: 'Miscellaneous',
  ),
  Product(
    name: "Havells Hand Mixer",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1oihBBJ4zUDHqQ_q2hwGEx_y7JjYshPH4',
      'https://drive.google.com/uc?export=view&id=1-0XwZBoKpckIVn08hQJdTtXDKeIekDYT',
    ],
    cost: 0,
    category: applince,
    productType: 'Miscellaneous',
  ),
  Product(
    name: "Havells 1.5L Electric Kettle",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=16wYV5hr4pP-blomTZzH5KzBE-bElKNmH',
      'https://drive.google.com/uc?export=view&id=1IeXbXpwlGnegPKZxlpoSV_wZ7so1PkTX',
    ],
    cost: 0,
    category: applince,
    productType: 'Miscellaneous',
  ),
  Product(
    name: "Havells 1.5L Garment Steamer",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1cE221M9ZywtE9Sd_fScWvIOi3cZohZca',
      'https://drive.google.com/uc?export=view&id=1W-yhrkV3wQsOf-D242GmznKW_HJ---Qs',
    ],
    cost: 0,
    category: applince,
    productType: 'Miscellaneous',
  ),
  Product(
    name: "Havells 150ml Hand Garment Steamer",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1fntIV90HpK7xgvIp-H1Zu3TLFggOJ9nA',
      'https://drive.google.com/uc?export=view&id=1nAUkxlnHt3WuG7_LiGRYm7VSSHoj-bCp',
    ],
    cost: 0,
    category: applince,
    productType: 'Miscellaneous',
  ),
  Product(
    name: "Havells 1000W Room Heater",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1QQTuVPDm3O3OcK4j_hkGUPSi0WTTykC9',
    ],
    cost: 0,
    category: applince,
    productType: 'Miscellaneous',
  ),
  Product(
    name: "Havells 800W Room Heater",
    imageUrls: [
      'https://drive.google.com/uc?export=view&id=1taUeFov2D67ILzkD7W8fUg4Se3hddpD8',
    ],
    cost: 0,
    category: applince,
    productType: 'Miscellaneous',
  ),
];
