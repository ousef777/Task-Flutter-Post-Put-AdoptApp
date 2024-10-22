import 'dart:typed_data';

import 'package:adopt_app/models/pet.dart';
import 'package:adopt_app/providers/pets_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddForm extends StatefulWidget {
  @override
  AddPetFormState createState() {
    return AddPetFormState();
  }
  AddForm({Key? key}) : super(key: key);

}

class AddPetFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name; 
  String _gender = "";
  late int _age;
  XFile? _image;
  final _picker = ImagePicker();
  Uint8List? imageData;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Fill in the blank";
              }
              else {
                return null;
              }
            },
            onSaved: (newValue) => _name = newValue as String,
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Age',
            ),
            maxLines: null,
            validator: (value) {
              if (value!.isEmpty) {
                return "Fill in the blank";
              }
              else if (int.tryParse(value) == null) {
                return "Age should be of type int.";
              }
              else {
                return null;
              }
            },
            onSaved: (newValue) => _age = int.parse(newValue!),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Gender',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Fill in the blank";
              }
              else if (value != 'male' && value != 'female') {
                return "Gender should be either female or male";
              }
              else {
                return null;
              }
            },
            onSaved: (newValue) => _gender = newValue as String,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                    // not null
                    
                    setState(() {
                        _image = XFile(image!.path);
                      }
                    );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(color: Colors.blue[200]),
                  child: _image != null ?
                    Image.network(
                      _image!.path,
                      width: 200,
                      height: 200,
                      fit: BoxFit.fitHeight,
                    )
                    : Container(
                          decoration: BoxDecoration(color: Colors.blue[200]),
                          width: 200,
                          height: 200,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                    ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Image"),
              )
            ],
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Provider.of<PetsProvider>(context, listen: false).createPet(
                    Pet(
                      name: _name, 
                      image: _image!.path, 
                      age: _age, 
                      gender: _gender
                    )
                  );
                  GoRouter.of(context).pop();
                }
              },
              child: const Text("Add Pet"),
            ),
          )
        ],
      ),
    );
  }
}