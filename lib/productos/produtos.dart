import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/Provider/user_provider.dart';
import 'package:login/model/user_model.dart';
import 'package:login/productos/product_cart.dart';
import 'package:login/productos/product_screen.dart';
import 'package:provider/provider.dart';

class Productos extends StatefulWidget {
  const Productos({super.key});

  @override
  State<Productos> createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  @override
  Widget build(BuildContext context) {

    final userProvider  = Provider.of<RecursosProvider>(context, listen: true);
    final  List<User> users  = userProvider.recursoList;

    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index){
          return InkWell(
            onTap: () {
              userProvider.selectedUser= userProvider.recursoList[index].copy();
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>ProductScreen()));
            },
            child:  ProductCard(
              user: users[index],
            ));
        },
        

        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          // final picker =new ImagePicker();
          // final PickedFile? pickerFile = await picker.getImage(
          //               source: ImageSource.gallery,
          //               imageQuality: 100//calidad de la imagen
          //               );
        userProvider.selectedUser = 
            User(
              calification: 0, 
              dni: 973378223,
              direccion: 'Av. Nuevo Mirador', 
              nombreCompleto: '', 
              estatus: false, 
              image:'https://i.pinimg.com/564x/34/cc/de/34ccde761b4737df092c6efec66d035e.jpg', //7pickerFile!.path, 
              password: '1234', 
              role: 'cliente', 
              telefono: 973378223
              );
              
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductScreen()));
              setState(() {
              
                  });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}