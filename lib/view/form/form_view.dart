import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kuliner_app/_widgets/button_widget.dart';
import 'package:flutter_kuliner_app/_widgets/tfbutton_widget.dart';
import 'package:flutter_kuliner_app/_widgets/tfprefix_widget.dart';
import 'package:flutter_kuliner_app/controller/kuliner_controller.dart';
import 'package:flutter_kuliner_app/model/kuliner_model.dart';
import 'package:flutter_kuliner_app/view/home/home_view.dart';
import 'package:flutter_kuliner_app/view/maps/maps_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

class FormView extends StatefulWidget {
  const FormView({super.key});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final formKey = GlobalKey<FormState>();
  final controller = KulinerController();
  final User? user = FirebaseAuth.instance.currentUser!;

  final namaKuliner = TextEditingController();
  final alamatKuliner = TextEditingController();
  final catatanReview = TextEditingController();

  File? _imageFile;
  final _imagePicker = ImagePicker();

  Future getImage(ImageSource source) async {
    try {
      final XFile? pickedImage = await _imagePicker.pickImage(source: source);

      setState(() {
        if (pickedImage != null) {
          _imageFile = File(pickedImage.path);
        } else {
          _imageFile = null;
        }
      });
    } catch (e) {
      throw Exception("Can't Get Image: $e");
    }
  }

  double rating = 0;
  String? gambar;

  @override
  void initState() {
    super.initState();
    rating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Kuliner"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  _imageFile == null
                      ? GestureDetector(
                          onTap: () {
                            getImage(ImageSource.camera);
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors
                                .grey, // Warna latar belakang avatar ketika kosong
                            radius: 80,
                            child: Icon(
                              Icons
                                  .camera_alt, // Ikon kamera untuk mengunggah gambar
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        )
                      :
                      // Gambar
                      GestureDetector(
                          onTap: () {
                            getImage(ImageSource.camera);
                          },
                          child: CircleAvatar(
                            backgroundImage: FileImage(
                                _imageFile!), // Menggunakan gambar dari _imageFile
                            radius: 80,
                          ),
                        ),

                  const SizedBox(
                    height: 10,
                  ),
                  // Nama Tempat Kuliner
                  TFPrefixIconWidget(
                    controller: namaKuliner,
                    textInputType: TextInputType.text,
                    hintText: "Masukkan Nama Kuliner",
                    labelText: "Nama Kuliner",
                    validator: "Nama Kuliner Tidak boleh kosong",
                    maxLines: 1,
                    prefixIcon: const Icon(Icons.people),
                  ),

                  // Alamat
                  TfButton(
                    controller: alamatKuliner,
                    labelText: "Alamat",
                    validator: "Alamat Tidak Boleh Kosong",
                    maxLines: 3,
                    onTap: () {
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MapsView(onLocationSelected: (selectedAddress) {
                            setState(() {
                              alamatKuliner.text = selectedAddress;
                            });
                          }),
                        ),
                      );
                    },
                  ),

                  // Catata Review
                  TFPrefixIconWidget(
                    controller: catatanReview,
                    textInputType: TextInputType.text,
                    hintText: "Masukkan Review",
                    labelText: "Review",
                    validator: "Catatan Review Tidak Boleh Kosong",
                    maxLines: 4,
                    prefixIcon: const Icon(Icons.note_alt),
                  ),

                  // Rating
                  Container(
                    width: 350,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      children: [
                        Text(
                          'Rating: $rating',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RatingBar.builder(
                          itemSize: 30,
                          itemPadding: const EdgeInsets.all(2),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          updateOnDrag: true,
                          onRatingUpdate: (value) {
                            setState(() {
                              rating = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Simpan
                  ButtonWidget(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          var result = await controller.addPersonData(
                            KulinerModel(
                              uid: user!.uid,
                              namaKuliner: namaKuliner.text,
                              alamatKuliner: alamatKuliner.text,
                              catatanReview: catatanReview.text,
                              rating: rating.toString(),
                              gambar: _imageFile!.path,
                            ),
                            _imageFile,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                result['message'],
                              ),
                            ),
                          );

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeView(),
                              ),
                              (route) => false);
                        }
                      },
                      nameButton: "Simpan")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
