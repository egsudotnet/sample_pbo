import 'package:sample_pbo/model/daftarMenu.dart';
import 'package:flutter/material.dart';

class PesanButton extends StatefulWidget {
  DaftarMenu menuTerpilih;

  PesanButton({Key? key,required this.menuTerpilih}) : super(key: key);

  @override
  _PesanButtonState createState() => _PesanButtonState();
}

class _PesanButtonState extends State<PesanButton> {
  bool isCart = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration( 
            border: Border.all(width: 3,color: (widget.menuTerpilih.jumlahPesan>0?Colors.red:Colors.white)),
          ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() { 
                if(widget.menuTerpilih.jumlahPesan >0) {
                  widget.menuTerpilih.jumlahPesan --;
                }
              });
            },
          ),
          const SizedBox(
            width: 5,
          ),
          Text(widget.menuTerpilih.jumlahPesan.toString()),
          IconButton(
            icon: const Icon(
              Icons.add_shopping_cart,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() { 
                widget.menuTerpilih.jumlahPesan ++; 
              });
            },
          ),
        ],
      ),
    );
  }
} 
