import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Shop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> names = [
    "Water", "Tea", "Ice tea", "Coffee", "Ice coffee", "Smoothie",
    "Hot chocolate", "Espresso", "Lemonade", "Soda", "Latte",
    "Mojito", "Pina colada", "Coconut Water", "Chai tea", "Milkshake"
  ];
  final List<int> price = [1, 5, 4, 6, 8, 6, 19, 12, 35, 24, 11, 15, 22, 5, 17, 31];
  final List<bool> f = List<bool>.filled(16, false); // Adjusted length to match items
  int total = 0;
  final List<String> buy = [];

  List<Color> ll = [
    Colors.indigo, Colors.blueAccent, Colors.purple, Colors.cyan, Colors.teal,
    Colors.indigo, Colors.green, Colors.deepPurple, Colors.redAccent,
    Colors.cyanAccent, Colors.lightGreen, Colors.pinkAccent, Colors.greenAccent,
    Colors.grey, Colors.teal, Colors.blueGrey
  ];

  void _toggleSelection(int index) {
    setState(() {
      f[index] = !f[index];
      total += f[index] ? price[index] : -price[index];
      if (f[index]) {
        buy.add(names[index]);
      } else {
        buy.remove(names[index]);
      }
    });
  }

  void _clearCart() {
    setState(() {
      total = 0;
      buy.clear();
      f.fillRange(0, f.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 40,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart_sharp,
              size: 40,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Second(
                    buy: buy,
                    total: total,
                    clearCart: _clearCart,
                  ),
                ),
              );
            },
            color: Colors.yellow,
          ),
        ],
      ),
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: names.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: ListTile(
                leading: Container(
                  width: 60,
                  color: ll[index % ll.length], // Ensure index is within range
                ),
                title: Text(
                  names[index],
                  style: TextStyle(fontSize: 30),
                ),
                subtitle: Text(
                  "${price[index]}£",
                  style: TextStyle(fontSize: 20, color: Colors.deepOrange),
                ),
                trailing: ElevatedButton(
                  onPressed: () => _toggleSelection(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: f[index] ? Colors.green : Colors.white,
                  ),
                  child: f[index]
                      ? Icon(Icons.check, color: Colors.white)
                      : Text('Add'),
                ),

              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            thickness: 2,
            color: Colors.indigo,
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class Second extends StatelessWidget {
  const Second({
    super.key,
    required this.buy,
    required this.total,
    required this.clearCart,
  });

  final List<String> buy;
  final int total;
  final VoidCallback clearCart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Cart",
          style: TextStyle(
            fontSize: 40,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: buy.isEmpty
            ? Text(
          'Your cart is empty',
          style: TextStyle(fontSize: 24, color: Colors.black87),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: buy.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      ". ${buy[index]}",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(thickness: 5, color: Colors.black87),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$total£",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 70,
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      clearCart();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Buy",
                      style: TextStyle(fontSize: 20, color: Colors.black87),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.yellow,
    );
  }
}
