import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shop/admin_component/admin_drawer_menu.dart';
import 'package:online_shop/models/clothes.dart';
import 'package:online_shop/admin_pages/admin_page.dart';
import 'package:uuid/uuid.dart';


class AddClothesPage extends StatefulWidget {
  final String userId;
  const AddClothesPage({super.key, required this.userId});

  @override
  State<AddClothesPage> createState() => _AddClothesPageState();
}

class _AddClothesPageState extends State<AddClothesPage> {
  // Controller
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _sizeInputController = TextEditingController();

  final List<String> _sizes = [];

  final List<File> _imageFile = [];

  final Map<String, String> _characteristics = {};

  //
  // Controllers for characteristics
  final TextEditingController _modelInputController = TextEditingController();
  final TextEditingController _tipSilInputController = TextEditingController();
  final TextEditingController _carmanInputController = TextEditingController();
  final TextEditingController _rucabaInputController = TextEditingController();
  final TextEditingController _sostavInputController = TextEditingController();
  final TextEditingController _sezonInputController = TextEditingController();
  final TextEditingController _zastejkaInputController = TextEditingController();
  final TextEditingController _stranaInputController = TextEditingController();
  //

  Future<void> _addClothes() async {
    if (_formKey.currentState?.validate() ?? false) {
      final box = Hive.box<Clothes>('clothesBox');
      var uuid = Uuid();
      String clothesId = uuid.v4();

      final clothes = Clothes(
        clothesId: clothesId,
        name: _nameController.text,
        price: _priceController.text,
        imagePaths: _imageFile.map((file) => file.path).toList(),
        description: _descriptionController.text,
        size: _sizes,
        characteristics: _characteristics
      );

      await box.add(clothes);

      // Show AlertDialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Успех'),
            content: const Text('Товар успешно добавлен!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AdminPage(userId: widget.userId)),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void removeImage(int index) {
    setState(() {
      _imageFile.removeAt(index);
    });
  }

  Future<void> _pickImage() async{
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile.add(File(pickedFile.path));
      });
    }
  }

  void _addSize() {
    if (_sizeInputController.text.isNotEmpty) {
      setState(() {
        _sizes.add(_sizeInputController.text.toUpperCase());
        _sizeInputController.clear();
      });
    }
  }

  void removeSize(int index) {
    setState(() {
      _sizes.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(top: 15, left: 10),
              child: Icon(Icons.menu),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const Padding(
          padding:  EdgeInsets.only(top: 15, left: 18),
          child: Text(
            'Добавить новый товар',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      drawer: AdminDrawerMenu(userId: widget.userId),

      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Column(
              children: [
                 SizedBox(height: 15),
                 Align(
                  alignment: Alignment.topLeft,
                  child:  Text(
                    'Загрузите от 1 до 10 фото',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22
                    ),
                  ),
                ),
                  Align(
                  alignment: Alignment.topLeft,
                  child:  Text(
                    'Бла бла бла',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: screenHeight * 0.11,
            padding: const EdgeInsets.only(left: 10),
            child: // image add
            Row(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add_a_photo,
                          ),
                        ),
                      ),
                    )
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _imageFile.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey),
                                  image: DecorationImage(
                                    image: FileImage(_imageFile[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 10,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () => removeImage(index),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  )
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: screenHeight * 1.3,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Divider(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // name
                      TextFormField(
                        controller: _nameController,
                        decoration:  InputDecoration(
                          labelText: 'Название товара',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),

                          enabledBorder:  OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(16)
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // description
                      TextFormField(
                        controller: _descriptionController,
                        decoration:  InputDecoration(
                          labelText: 'Описание товара',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),

                          enabledBorder:  OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(16)
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Price
                      TextFormField(
                        controller: _priceController,
                        decoration:  InputDecoration(
                          labelText: 'Цена',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),

                          enabledBorder:  OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(16)
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Size
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _sizeInputController,
                              decoration:  InputDecoration(
                                labelText: 'Размер',
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black
                                    ),
                                    borderRadius: BorderRadius.circular(15)
                                ),

                                enabledBorder:  OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black
                                    ),
                                    borderRadius: BorderRadius.circular(16)
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: _addSize,
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Display sizes
                      if (_sizes.isNotEmpty)
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _sizes.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 15),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _sizes[index],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                      right: 4,
                                      child: GestureDetector(
                                        onTap: () => removeSize(index),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.black,
                                          size: 14,
                                        ),
                                      )
                                  )
                                ],
                              );
                            },
                          ),
                        ),

                      // characteristics
                      const SizedBox(height: 10),

                      // characteristics
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Характеристики',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Model
                      TextFormField(
                        controller: _modelInputController,
                        decoration:  InputDecoration(
                          labelText: 'Модель',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),

                          enabledBorder:  OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(16)
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _characteristics['Модель'] = value;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      // Тип силуэта
                      TextFormField(
                        controller: _tipSilInputController,
                        decoration:  InputDecoration(
                          labelText: 'Тип силуэта',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),

                          enabledBorder:  OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(16)
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _characteristics['Тип силуэта'] = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Карманы
                      TextFormField(
                        controller: _carmanInputController,
                        decoration:  InputDecoration(
                          labelText: 'Карманы',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),

                          enabledBorder:  OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(16)
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _characteristics['Карманы'] = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Рукава
                      TextFormField(
                        controller: _rucabaInputController,
                        decoration:  InputDecoration(
                          labelText: 'Рукава',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),

                          enabledBorder:  OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(16)
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _characteristics['Рукава'] = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Состав
                      TextFormField(
                        controller: _sostavInputController,
                        decoration:  InputDecoration(
                          labelText: 'Состав',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),

                          enabledBorder:  OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(16)
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _characteristics['Состав'] = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Сезон
                      TextFormField(
                        controller: _sezonInputController,
                        decoration:  InputDecoration(
                          labelText: 'Сезон',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),

                          enabledBorder:  OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(16)
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _characteristics['Сезон'] = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Застежка
                      TextFormField(
                        controller: _zastejkaInputController,
                        decoration:  InputDecoration(
                          labelText: 'Застежка',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),

                          enabledBorder:  OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(16)
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _characteristics['Застежка'] = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Страна производства
                      TextFormField(
                        controller: _stranaInputController,
                        decoration:  InputDecoration(
                          labelText: 'Страна производства',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),

                          enabledBorder:  OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(16)
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _characteristics['Страна производства'] = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                // add button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GestureDetector(
                    onTap: _addClothes,

                    child: Container(
                      height: screenHeight * 0.06,
                      width: screenWidth * 1,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: const Center(
                        child: Text(
                          'Добавить одежду',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  )
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}

