import 'package:sample_pbo/detail.dart';
import 'package:sample_pbo/model/daftarMenu.dart';
import 'package:sample_pbo/pesanPilihan.dart';
import 'package:flutter/material.dart';
 
class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);
 
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total: Rp. ${getTotalHarga()}" ),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.all(20.0),
            icon: const Icon(Icons.send_outlined, color: Colors.white, size: 30.0,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const PesanPilihan();
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
          children: getMenuTerpilih().map((menu) {
            return InkWell( onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailPage(menu: menu);
                }));
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: menu.name,
                        child: Image.network(
                          menu.imageUrls[0],
                          fit: BoxFit.cover,
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
                                    "Rp. ${menu.harga} x ${menu.jumlahPesan}",
                                  ),
                                ),
                              ],
                            ),
                        ) 
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
          final DaftarMenu menu = getMenuTerpilih()[index];
          return InkWell(
             onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                 return DetailPage(menu: menu);
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
                      child: Image.network(menu.imageUrls[0])
                      ),
                   ),
                   Expanded(
                     flex: 2,
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
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
                           Text(
                                 "Rp. ${menu.harga} x ${menu.jumlahPesan}",
                               ),
                         ],
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child:Text(
                                 "Rp. ${menu.harga * menu.jumlahPesan}",
                               ),
                     )
          
                 ],
               ),
             ),
          );
        },
        itemCount: getMenuTerpilih().length,
      );
  }
}
  
List<DaftarMenu> getMenuTerpilih(){
  List<DaftarMenu>  data = [];
  for (int i = 0; i <= DaftarMenus.length-1; i++) {
      if(DaftarMenus[i].jumlahPesan>0){
        data.add(DaftarMenus[i]);
      }
    }
  return data;
}

int getTotalHarga(){
  var data = getMenuTerpilih(); 
  int totalHarga = 0;
  for (int i = 0; i <= data.length-1; i++) {        
      totalHarga += DaftarMenus[i].jumlahPesan * DaftarMenus[i].harga;
    } 
  return totalHarga;
}