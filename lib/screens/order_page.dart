// screens/order_page.dart
import 'package:flutter/material.dart';
import '../models/food_item.dart';

class OrderPage extends StatefulWidget {
  final FoodItem item;

  const OrderPage({Key? key, required this.item}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final TextEditingController _quantityController = TextEditingController();
  int _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _quantityController.text = '0';
    _calculateTotal();
  }

  void _calculateTotal() {
    int quantity = int.tryParse(_quantityController.text) ?? 0;
    setState(() {
      _totalPrice = widget.item.price * quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Order'),
        backgroundColor: Colors.blue, // Set app bar color to blue
        foregroundColor: Colors.white, // Set text/icon color to white
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gambar makanan
            const CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey,
              child: Icon(Icons.restaurant, size: 70, color: Colors.white),
            ),
            const SizedBox(height: 20),
            // Nama makanan
            Text(
              widget.item.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Harga: Rp ${widget.item.price}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            // Input jumlah
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Masukkan Jumlah',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _calculateTotal();
              },
            ),
            const SizedBox(height: 20),
            // Total harga
            Text(
              'Total Harga: Rp $_totalPrice',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            // Submit button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Simpan order dan kembali
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Set button color to blue
                  foregroundColor: Colors.white, // Set text color to white
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 2, // Add a slight shadow
                ),
                child: const Text('Submit', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
