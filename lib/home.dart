import 'package:sample_pbo/cart.dart';
import 'package:sample_pbo/detail.dart';
import 'package:sample_pbo/pesanButton.dart';
import 'package:flutter/material.dart'; 
import 'package:sample_pbo/model/daftarMenu.dart';
 
class Home extends StatelessWidget { 
  const Home({Key? key, required this.useraname}) : super(key: key);
  final String useraname;

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi $useraname, pilih pesanan anda!'),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.all(20.0),
            icon: const Icon(Icons.shopping_cart_checkout, color: Colors.white, size: 30.0,),
            onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Cart();
              }));
            },
          )
        ], 
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 650) {
            return const DaftarMenuList();
          } else if (constraints.maxWidth <= 1200) {
            return DaftarMenuGrid(gridCount: 4);
          } else {
            return DaftarMenuGrid(gridCount: 6);
          }
        },
      ),
    );
  }
}

class DaftarMenuGrid extends StatelessWidget {
  final int gridCount; 
  DaftarMenuGrid({required this.gridCount});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GridView.count(
          crossAxisCount: gridCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: DaftarMenus.map((menu) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailPage(menu: menu);
                }));
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Hero(
                          tag: menu.name,
                          child: Image.network(
                            menu.imageUrls[0],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [ 
                        Expanded(
                          flex: 1,
                          child: 
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    menu.name,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                                  child: Text(
                                    "Rp. " + menu.harga.toString()
                                  ),
                                ),
                              ],
                            ),
                        ), 
                        PesanButton(menuTerpilih: menu,)  
                      ],
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DaftarMenuList  extends StatelessWidget {
  const DaftarMenuList ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          final DaftarMenu menu = DaftarMenus[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailPage(menu: menu,);
              }));
            },
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Hero(
                      tag: menu.name,
                      child: Image.network(menu.imageUrls[0])),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            menu.name,
                            style: const TextStyle(
                              fontSize: 16.0,   
                              ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Rp. ${menu.harga}"),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: PesanButton(menuTerpilih: menu,) 
                      ),
                  )

                ],
              ),
            ),
          );
        },
        itemCount: DaftarMenus.length,
      );
  }
} 
