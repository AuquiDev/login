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
    // final users = userProvider.recursoList;

    return ChangeNotifierProvider(
      create: (_) => UserFormProvider(userProvider.selectedUser),
      child: _ProductScreenBody(userProvider: userProvider),
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
    double width =  MediaQuery.of(context).size.width;
    return Scaffold(
       backgroundColor:width>500 ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
               ProductImage(
                  image: widget.userProvider.selectedUser.image,
                ),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                        onPressed: () {
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
                    child: IconButton(
                        onPressed: () async {
                          final picker = new ImagePicker();

                          final PickedFile? pickerFile = await picker.getImage(
                            source: ImageSource.camera,
                            // imageQuality: 100//calidad de la imagen
                          );

                          if (pickerFile == null) {
                            print('No selecciono nada');
                            return;
                          }
                          print('Tenemos Imagen ${pickerFile.path}');
                          widget.userProvider.updateSelectedUserImage(
                              pickerFile.path); //reemplazamos la imagen
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                          color: Colors.white,
                        ))),
                Positioned(
                    top: 100,
                    right: 20,
                    child: IconButton(
                        onPressed: () async {
                          final picker = new ImagePicker();

                          final PickedFile? pickerFile = await picker.getImage(
                            source: ImageSource.gallery,
                            // imageQuality: 100//calidad de la imagen
                          );

                          if (pickerFile == null) {
                            print('No selecciono nada');
                            return;
                          }
                          print('Tenemos Imagen ${pickerFile.path}');
                          widget.userProvider.updateSelectedUserImage(
                              pickerFile.path); //reemplazamos la imagen
                        },
                        icon: const Icon(
                          Icons.image,
                          size: 30,
                          color: Colors.white,
                        )))
              ],
            ),
            
            SingleChildScrollView(child: _ProductFOrm())
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: widget.userProvider.isaving
            ? null
            : () async {
                //GUARDAR CMABIOS
                if (!uForm.isValidation()) return;
                final String? imageUrl =
                    await widget.userProvider.uploadImage();
                if (imageUrl != null) uForm.userform.image = imageUrl;
                await widget.userProvider.saveOrCreateProduct(uForm.userform);

                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
        child: widget.userProvider.isaving
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(Icons.save_outlined),
      ),
    );
  }
}

class _ProductFOrm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uForm = Provider.of<UserFormProvider>(context);
    final users = uForm.userform;

    double width = MediaQuery.of(context).size.width;

    return Container(
       
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        margin: width<500 ?   const EdgeInsets.only(left: 10, right: 10, bottom: 100) : 
        EdgeInsets.only(left: width*.25, right: width*.25, bottom: 100),
        decoration: _decoration(),
        child: Form(
            key: uForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: users.nombreCompleto,
                  onChanged: (value) {
                    users.nombreCompleto = value;
                  },
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return 'el nombre es obligatorio';
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Nombre del producto', labelText: 'Nombre'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: users.apellido,
                  onChanged: (value) {
                    users.apellido = value;
                  },
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return 'el nombre es obligatorio';
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: 'apellidos'),
                ),
                users.role == 'admin'
                    ? TextFormField(
                        initialValue: users.genero,
                        onChanged: (value) {
                          users.genero = value;
                        },
                        validator: (value) {
                          if (value == null || value.length < 1) {
                            return 'el nombre es obligatorio';
                          }
                        },
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(labelText: 'genero'),
                      )
                    : const Text(''),
                users.role == 'admin'
                    ? TextFormField(
                        initialValue: users.role,
                        onChanged: (value) {
                          users.role = value;
                        },
                        validator: (value) {
                          if (value == null || value.length < 1) {
                            return 'el nombre es obligatorio';
                          }
                        },
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(labelText: 'rol'),
                      )
                    : const Text(''),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue:users.id == null ? '${users.dni}'.substring(1,) :users.dni.toString(),
                  onChanged: (value) {
                    users.dni = int.parse(value);
                  },
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return 'el nombre es obligatorio';
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'DNI'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: users.password,
                  onChanged: (value) {
                    users.password = value;
                  },
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return 'el nombre es obligatorio';
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: '', labelText: 'contraseña'),
                ),
                const SizedBox(
                  height: 10,
                ),
                users.role == 'admin' ? TextFormField(
                  initialValue: users.cargo,
                  onChanged: (value) {
                    users.cargo = value;
                  },
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return 'el nombre es obligatorio';
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: '', labelText: 'cargo/puesto'),
                ): const Text(''),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: users.direccion,
                  onChanged: (value) {
                    users.direccion = value;
                  },
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return 'el nombre es obligatorio';
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: '', labelText: 'direccion'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: users.id == null ? users.telefono.toString().substring(1,) : users.telefono.toString(),
                  onChanged: (value) {
                    users.telefono = int.parse(value);
                  },
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return 'el nombre es obligatorio';
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: '', labelText: 'Telefono'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: users.correo,
                  onChanged: (value) {
                    users.correo = value;
                  },
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return 'el nombre es obligatorio';
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: '\$250', labelText: 'correo'),
                ),
                users.role == 'admin'
                    ? SwitchListTile.adaptive(
                        value: users.estatus,
                        title: users.estatus == true
                            ? const Text(
                                'Disponible',
                                style: TextStyle(color: Colors.green),
                              )
                            : const Text(
                                'No Disponible',
                                style: TextStyle(color: Colors.red),
                              ),
                        activeColor: Colors.amber,
                        onChanged: uForm.updateAvailability,
                      )
                    : const SizedBox(
                        height: 40,
                      ),
              ],
            )));
  }

  BoxDecoration _decoration() {
    return const BoxDecoration(
        color: Colors.white,
       
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(offset: Offset(0, 7), blurRadius: 10, color: Colors.black26)
        ]);
  }
}
