import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbapp/ViewProducts.dart';
import 'package:flutter/material.dart';

class Addproducts extends StatelessWidget {
  const Addproducts({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController prodName = TextEditingController();
    TextEditingController prodPrice = TextEditingController();

    CollectionReference products =
        FirebaseFirestore.instance.collection('products');

    Future<void> addProducts() async {
      try {
        await products.add({
          'name': prodName.text,
          'price': double.parse(prodPrice.text),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Product Added")),
        );
      } catch (e) {
        print("Error adding product: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add product: $e")),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Products'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Product Name',
                ),
                controller: prodName,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Product Price',
                ),
                controller: prodPrice,
              ),
              ElevatedButton(
                onPressed: addProducts,
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProducts()));
        },
        child: Icon(Icons.list),
      ),
    );
  }
}
