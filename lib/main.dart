import 'package:flutter/material.dart';

void main() { runApp(const HairBySomilaSN()); }

const Color pink = Color(0xFFE91E63); const Color lightPink = Color(0xFFFFF5F8);

class HairBySomilaSN extends StatelessWidget { const HairBySomilaSN({super.key});

@override Widget build(BuildContext context) { return MaterialApp( debugShowCheckedModeBanner: false, title: 'Hair by Somila SN', theme: ThemeData( scaffoldBackgroundColor: lightPink, colorScheme: ColorScheme.fromSeed(seedColor: pink), useMaterial3: true, ), home: const StorePage(), ); } }

class Product { final String name; final String description; final double price; final IconData icon;

const Product({ required this.name, required this.description, required this.price, required this.icon, }); }

class StorePage extends StatefulWidget { const StorePage({super.key});

@override State<StorePage> createState() => _StorePageState(); }

class _StorePageState extends State<StorePage> { int selectedPage = 0;

final List<Product> products = const [ Product( name: 'Straight Hair', description: 'Smooth and silky hair', price: 350, icon: Icons.face_3, ), Product( name: 'Curly Hair', description: 'Beautiful natural curls', price: 400, icon: Icons.spa, ), Product( name: 'Body Wave', description: 'Soft and elegant waves', price: 380, icon: Icons.waves, ), Product( name: 'Lace Front Wig', description: 'A beautiful ready-to-wear wig', price: 850, icon: Icons.face, ), ];

final Map<String, int> cart = {};

void addToCart(Product product) { setState(() { cart[product.name] = (cart[product.name] ?? 0) + 1; });

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('${product.name} added to cart!'),
    duration: const Duration(seconds: 1),
  ),
);


}

void changeQuantity(String name, int amount) { setState(() { final newQuantity = (cart[name] ?? 0) + amount;

  if (newQuantity <= 0) {
    cart.remove(name);
  } else {
    cart[name] = newQuantity;
  }
});


}

double get totalPrice { double total = 0;

for (final product in products) {
  total += product.price * (cart[product.name] ?? 0);
}

return total;


}

int get totalItems { return cart.values.fold(0, (sum, quantity) => sum + quantity); }

@override Widget build(BuildContext context) { return Scaffold( appBar: AppBar( backgroundColor: Colors.white, title: const Text( 'Hair by Somila SN', style: TextStyle( color: pink, fontWeight: FontWeight.bold, ), ), actions: [ navButton('Home', 0), navButton('Products', 1), navButton('Cart ($totalItems)', 2), const SizedBox(width: 12), ], ), body: selectedPage == 0 ? buildHomePage() : selectedPage == 1 ? buildProductsPage() : buildCartPage(), ); }

Widget navButton(String label, int page) { return TextButton( onPressed: () { setState(() { selectedPage = page; }); }, child: Text( label, style: TextStyle( color: selectedPage == page ? pink : Colors.black87, ), ), ); }

Widget buildHomePage() { return Center( child: Padding( padding: const EdgeInsets.all(24), child: Column( mainAxisAlignment: MainAxisAlignment.center, children: [ const Icon(Icons.spa, size: 75, color: pink), const SizedBox(height: 20), const Text( 'WELCOME TO', style: TextStyle( letterSpacing: 4, color: Colors.black54, ), ), const SizedBox(height: 12), const Text( 'Hair by Somila SN', textAlign: TextAlign.center, style: TextStyle( fontSize: 38, fontWeight: FontWeight.bold, color: pink, ), ), const SizedBox(height: 16), const Text( 'Your beauty, your style, your confidence.', textAlign: TextAlign.center, style: TextStyle(fontSize: 18), ), const SizedBox(height: 28), ElevatedButton( onPressed: () { setState(() { selectedPage = 1; }); }, style: ElevatedButton.styleFrom( backgroundColor: pink, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric( horizontal: 32, vertical: 16, ), ), child: const Text('Shop Now'), ), const SizedBox(height: 30), const Text( 'Beautiful Hair. Beautiful You.', style: TextStyle( fontStyle: FontStyle.italic, color: Colors.black54, ), ), ], ), ), ); }

Widget buildProductsPage() { return SingleChildScrollView( padding: const EdgeInsets.all(24), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ const Text( 'Our Hair Collection', style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold, color: pink, ), ), const SizedBox(height: 8), const Text( 'Find the perfect hair for your style.', style: TextStyle(fontSize: 16), ), const SizedBox(height: 24), LayoutBuilder( builder: (context, constraints) { final columns = constraints.maxWidth > 750 ? 4 : 2;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final product = products[index];

              return Card(
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: lightPink,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            product.icon,
                            size: 65,
                            color: pink,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        product.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'R${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => addToCart(product),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: pink,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                          ),
                          child: const Text('Add to Cart'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    ],
  ),
);


}

Widget buildCartPage() { final selectedProducts = products .where((product) => (cart[product.name] ?? 0) > 0) .toList();

return Padding(
  padding: const EdgeInsets.all(24),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'My Shopping Cart',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: pink,
        ),
      ),
      const SizedBox(height: 20),
      if (selectedProducts.isEmpty)
        const Expanded(
          child: Center(
            child: Text(
              'Your cart is empty. Start shopping!',
              style: TextStyle(fontSize: 18),
            ),
          ),
        )
      else
        Expanded(
          child: ListView(
            children: selectedProducts.map((product) {
              final quantity = cart[product.name] ?? 0;

              return Card(
                color: Colors.white,
                child: ListTile(
                  title: Text(product.name),
                  subtitle: Text(
                    'R${product.price.toStringAsFixed(2)} each',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          changeQuantity(product.name, -1);
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text('$quantity'),
                      IconButton(
                        onPressed: () {
                          changeQuantity(product.name, 1);
                        },
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      const SizedBox(height: 20),
      Text(
        'Total: R${totalPrice.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: pink,
        ),
      ),
      const SizedBox(height: 16),
      if (selectedProducts.isNotEmpty)
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Thank you! Checkout is a demo for this project.',
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: pink,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
            ),
            child: const Text('Proceed to Checkout'),
          ),
        ),
    ],
  ),
);


} }