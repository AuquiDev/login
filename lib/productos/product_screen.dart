import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/Provider/form_provider.dart';
import 'package:login/Provider/user_provider.dart';
import 'package:login/productos/product_image.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<RecursosProvider>(context);
    final users = userProvider.recursoList;
    
    return ChangeNotifierProvider(
      create: (_) => UserFormProvider(userProvider.selectedUser),
      child:  _ProductScreenBody(userProvider: userProvider),
      );
  }
}

class _ProductScreenBody extends StatefulWidget {
  const _ProductScreenBody({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final RecursosProvider userProvider;

  @override
  State<_ProductScreenBody> createState() => _ProductScreenBodyState();
}

class _ProductScreenBodyState extends State<_ProductScreenBody> {
  @override
  Widget build(BuildContext context) {
    final uForm = Provider.of<UserFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        
        child: Column(
          children: [
            Stack(
              children: [
                 ProductImage(image: widget.userProvider.selectedUser.image,),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, 
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 30,
                      color: Colors.white,
                    ))),
                 Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(onPressed: () async{
                      final picker =new ImagePicker();

                      final PickedFile? pickerFile = await picker.getImage(
                        source: ImageSource.camera,
                        // imageQuality: 100//calidad de la imagen
                        );
                      
                      if (pickerFile == null) {
                      print('No selecciono nada');
                      return ;
                      }
                      print('Tenemos Imagen ${pickerFile.path}');
                      widget.userProvider.updateSelectedUserImage(pickerFile.path);//reemplazamos la imagen
                    }, 

                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 30,
                      color: Colors.white,
                    ))),

                  Positioned(
                    top: 100,
                    right: 20,
                    child: IconButton(onPressed: () async{
                      final picker =new ImagePicker();

                      final PickedFile? pickerFile = await picker.getImage(
                        source: ImageSource.gallery,
                        imageQuality: 100//calidad de la imagen
                        );
                      
                      if (pickerFile == null) {
                      print('No selecciono nada');
                      return ;
                      }
                      print('Tenemos Imagen ${pickerFile.path}');
                      widget.userProvider.updateSelectedUserImage(pickerFile.path);//reemplazamos la imagen
                    }, 
                    icon: const Icon(
                      Icons.image,
                      size: 30,
                      color: Colors.white,
                    )))
              ],
            ),
         
           _ProductFOrm()
          ],
        ),
      ),
     floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: widget.userProvider.isaving ? CircularProgressIndicator(color: Colors.white,)
        : Icon(Icons.save_outlined),
        onPressed:
          widget.userProvider.isaving ? null : 

         () async {
          //GUARDAR CMABIOS
          if (!uForm.isValidation()) return ;
          final String? imageUrl = await widget.userProvider.uploadImage();
          if(imageUrl != null) uForm.userform.image = imageUrl;
          await widget.userProvider.saveOrCreateProduct(uForm.userform);


          Navigator.pop(context);
          // setState(() {
            
          // });
        },
      ),
    );
  }
}

class _ProductFOrm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final uForm = Provider.of<UserFormProvider>(context);
    final users = uForm.userform;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      // height:200,
      margin: const EdgeInsets.symmetric(horizontal:10),
      decoration: _decoration(),
      child: Form(
        key: uForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
        children:  [
          const SizedBox(height: 10,),

          TextFormField(
            initialValue: users.nombreCompleto,
            onChanged: (value) {
              users.nombreCompleto = value;
            },
            validator: (value) {
              if (value == null || value.length <1) {
                return 'el nombre es obligatorio';
              }
            } ,
            decoration:const InputDecoration(
              hintText: 'Nombre del producto',
              labelText: 'Nombre'
            ),
          ),
          const SizedBox(height: 10,),
          TextFormField(
            initialValue: users.role,
            onChanged: (value) {
              users.role = value;
            },
            validator: (value) {
              if (value == null || value.length <1) {
                return 'el nombre es obligatorio';
              }
            } ,
            keyboardType: TextInputType.text,
            decoration:const InputDecoration(
              hintText: '\$250',
              labelText: 'rol'
            ),
          ),

          const SizedBox(height: 10,),

          SwitchListTile.adaptive(
            value: users.estatus, 
            title: const Text('Disponible'),
            activeColor: Colors.amber,
            onChanged:  uForm.updateAvailability,
            )

        ],
      ))
    );
  }

  BoxDecoration _decoration() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30)),
      boxShadow: [
      BoxShadow(
        offset: Offset(0, 7),
        blurRadius: 10,
        color: Colors.black26
      )
     ]
    
    );
  }
}
