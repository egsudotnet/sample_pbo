import 'package:sample_pbo/cart.dart';
import 'package:sample_pbo/home.dart';
import 'package:sample_pbo/model/daftarMenu.dart';
import 'package:flutter/material.dart';

var informationTextStyle = const TextStyle(fontFamily: 'Oxygen');

class DetailPage extends StatelessWidget {
  final DaftarMenu menu;

  const DetailPage({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menu.name),
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
      body:  LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 800) {
            return _DetailWebPage(menu: menu);
          } else {
            return _DetailMobilePage(menu: menu);
          }
        },
      )
    );
     
  }
}


class _DetailMobilePage extends StatefulWidget {
  final DaftarMenu menu;

  const _DetailMobilePage({Key? key, required this.menu}) : super(key: key);

  @override
  State<_DetailMobilePage> createState() => _DetailMobilePageState();
}

class _DetailMobilePageState extends State<_DetailMobilePage> {
  int gambarTerpilih = 0; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
            tag: widget.menu.name,
            child: Image.network(widget.menu.imageUrls[gambarTerpilih],fit: BoxFit.cover,height: 300,)
            ),
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.menu.imageUrls.map((url) {
                  int idx = widget.menu.imageUrls.indexOf(url); 
                  return Container(
                    decoration: BoxDecoration( 
                          border: Border.all(width: 3,color: (gambarTerpilih==idx?Colors.red:Colors.white)),
                        ),
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () { 
                          int idx = widget.menu.imageUrls.indexOf(url); 
                          setState(() { 
                            gambarTerpilih = idx < 0 ? 0: idx;
                          }); 
                        },
                        child: Image.network(url,fit: BoxFit.cover,height: 50,width: 50,)
                        ),
                    ),
                  );
                }).toList(),
              ),
            ), 
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      widget.menu.isMakanan? const Icon((Icons.rice_bowl)) : const Icon((Icons.water_drop)),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.menu.isMakanan?'Makanan':'Minuman',
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Icon(Icons.fireplace),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.menu.kalori,
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Icon(Icons.monetization_on),
                      const SizedBox(height: 8.0),
                      Text(
                        "Rp. ${widget.menu.harga}",
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ), 
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Bahan-bahan :", style: TextStyle(fontWeight: FontWeight.bold),),
              ), 
            Container(
              padding: const EdgeInsets.only(left: 30,bottom: 30), 
              child: Column( 
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widget.menu.bahan.map((value) {
                  return Text(value);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  
  @override
  void dispose() { 
    super.dispose();
  }
}

class _DetailWebPage extends StatefulWidget {
  final DaftarMenu menu;

  const _DetailWebPage({Key? key, required this.menu}) : super(key: key);

  @override
  _DetailWebPageState createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<_DetailWebPage> {
  int gambarTerpilih = 0; 
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      //appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 64,
        ),
        child: Center(
          child: SizedBox(
            width: screenWidth <= 1200 ? 800 : 1200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.menu.name,
                  style: const TextStyle(
                    fontFamily: 'Staatliches',
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Hero(
                              tag: widget.menu.name,
                              child: Image.network(widget.menu.imageUrls[gambarTerpilih],fit: BoxFit.cover,height: 300,)),
                          ),
                          const SizedBox(height: 16),
                          Scrollbar( 
                            controller: _scrollController,
                            child: Container(
                              height: 100,
                              padding: const EdgeInsets.only(bottom: 16),
                              child: ListView(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                children: widget.menu.imageUrls.map((url) {
                                  int idx = widget.menu.imageUrls.indexOf(url); 
                                  return Container(
                                  decoration: BoxDecoration( 
                                        border: Border.all(width: 3,color: (gambarTerpilih==idx?Colors.red:Colors.white)),
                                      ),
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10), 
                                      child: InkWell(
                                        onTap: () {
                                          int idxTerpilih = widget.menu.imageUrls.indexOf(url); 
                                          setState(() { 
                                            gambarTerpilih = idxTerpilih < 0 ? 0: idxTerpilih;
                                          }); 
                                        }, 
                                        child: Image.network(url,fit: BoxFit.cover,width: 100,)
                                        ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: <Widget>[
                                       widget.menu.isMakanan? const Icon((Icons.rice_bowl)) : const Icon((Icons.water_drop)),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        widget.menu.isMakanan?'Makanan':'Minuman',
                                        style: informationTextStyle,
                                      ),
                                    ],
                                  ) 
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  const Icon(Icons.fireplace),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    widget.menu.kalori,
                                    style: informationTextStyle,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: <Widget>[
                                  const Icon(Icons.monetization_on),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    "Rp. ${widget.menu.harga}",
                                    style: informationTextStyle,
                                  ),
                                ],
                              ), 
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text("Bahan-bahan :", style: TextStyle(fontWeight: FontWeight.bold),),
                                ), 
                              Container(
                                padding: const EdgeInsets.only(left: 30), 
                                child: Column( 
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: widget.menu.bahan.map((value) {
                                    return Text(value);
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}


class CartButton extends StatelessWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
            padding: const EdgeInsets.all(20.0),
            icon: const Icon(Icons.shopping_cart_checkout, color: Colors.red, size: 30.0,),
            onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Cart();
              }));
            }
    );
  }
} 