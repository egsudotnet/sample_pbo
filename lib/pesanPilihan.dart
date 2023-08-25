 
import 'package:flutter/material.dart';

class PesanPilihan extends StatelessWidget {
  const PesanPilihan({Key? key}) : super(key: key);
 
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Proses Pemesanan"),
        actions: null
      ), 
      body: Padding(
        padding:const EdgeInsets.only(top: 150),
        child: Center(
          child: Column(
            children: [
              Image.asset("images/loader.gif"),
              const SizedBox(height:30),
              const Text("Mohon Tunggu"),
              const Text("Pesanan Anda Sedang Disiapkan")
            ],
          ),
        ),
      )
    );
  }
}
