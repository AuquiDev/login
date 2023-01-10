import 'package:flutter/material.dart';

import 'package:login/Provider/user_provider.dart';
import 'package:login/model/model.dart';
import 'package:login/pages/modulos/usuarios.dart';
import 'package:login/productos/product_cart.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Productos extends StatefulWidget {
   Productos({super.key,required this.users});
  User users;
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
                builder: (context)=>const UsuarioModule()));//ProductImage()));
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
              nombreCompleto: '', 
              apellido: '', 
              dni: 0,
              password: '****', 
              direccion: 'Av. Ejemplo',
              telefono: 0, 
              image:'https://i.pinimg.com/564x/34/cc/de/34ccde761b4737df092c6efec66d035e.jpg', //7pickerFile!.path, 
              role: 'cliente', 
              cargo: 'cliente', 
              correo: 'example@gmail.com', 
              genero: 'masculino',  
              estatus: true,
              calification: 11, 
              );
              
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const UsuarioModule()));
              setState(() {
              
                  });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}