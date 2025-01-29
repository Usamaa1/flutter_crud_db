import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbapp/AddProducts.dart';
import 'package:flutter/material.dart';

class ViewProducts extends StatefulWidget {
  const ViewProducts({super.key});

  @override
  State<ViewProducts> createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  final Stream products =
      FirebaseFirestore.instance.collection("products").snapshots();
  final favInstance = FirebaseFirestore.instance.collection("favourites");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserFavourite();
  }

  final userFavouriteProducts = [];

  Future<void> fetchUserFavourite() async {
    final favSnapshot = await favInstance.where("userId", isEqualTo: 1).get();
    // print(favSnapshot.docs);
    // userFavouriteProducts = favSnapshot.docs.map((doc) => doc["productId"] as String).toSet();
    // print(userFavouriteProducts);
    favSnapshot.docs
        .forEach((doc) => userFavouriteProducts.add(doc["productId"]));
    print(userFavouriteProducts);
  }

  Future<void> deleteItem(prodId) async {
    try {
      await FirebaseFirestore.instance
          .collection("products")
          .doc(prodId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Item Deleted Successfully")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Item Deletion Failed")));
      print(e);
    }
  }

  // Update Query

  //  Future<void> updateProduct(String productId, String currentName, double currentPrice) async {
  //   TextEditingController nameController = TextEditingController(text: currentName);
  //   TextEditingController priceController = TextEditingController(text: currentPrice.toString());

  //   await showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text("Update Product"),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           TextField(
  //             controller: nameController,
  //             decoration: InputDecoration(labelText: "Name"),
  //           ),
  //           TextField(
  //             controller: priceController,
  //             decoration: InputDecoration(labelText: "Price"),
  //             keyboardType: TextInputType.number,
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: Text("Cancel"),
  //         ),
  //         TextButton(
  //           onPressed: () async {
  //             try {
  //               await FirebaseFirestore.instance.collection("products").doc(productId).update({
  //                 "name": nameController.text,
  //                 "price": double.parse(priceController.text),
  //               });
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 SnackBar(content: Text("Product updated successfully")),
  //               );
  //               Navigator.of(context).pop();
  //             } catch (e) {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 SnackBar(content: Text("Failed to update product: $e")),
  //               );
  //             }
  //           },
  //           child: Text("Update"),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
          child: Column(
        children: [
          ListTile(
            title: Text("Add Products"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Addproducts()));
            },
          ),
        ],
      )),
      body: StreamBuilder(
          stream: products,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text("No Data Found"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final product = snapshot.data!.docs;
            return ListView.builder(
              itemCount: product.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: IconButton(
                    onPressed: () async {
                      if (userFavouriteProducts.contains(product[index].id)) {
                        final singleFavInstance = await favInstance
                            .where("productId", isEqualTo: product[index].id)
                            .where("userId", isEqualTo: 1)
                            .get();

                        print(singleFavInstance);
                        print("hello");
                        print(singleFavInstance.docs.first.id);
                        var id = singleFavInstance.docs.first.id;

                        await favInstance.doc(id).delete();
                        setState(() {
                          userFavouriteProducts.remove(product[index].id);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Item removed from Favorites")));
                      } else {
                        await favInstance.add({
                          "productId": product[index].id,
                          "userId": 1,
                        });
                        setState(() {
                          userFavouriteProducts.add(product[index].id);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Item added to favorites")));
                      }
                    },
                    icon: Icon(Icons.favorite,
                        color: userFavouriteProducts.contains(product[index].id)
                            ? Colors.redAccent
                            : null),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        deleteItem(product[index].id);
                      },
                      icon: Icon(Icons.delete)),
                  title: Text(product[index]["name"]),
                  subtitle: Text(product[index]["price"].toString()),
                );
              },
            );
          }),
    );
  }
}
