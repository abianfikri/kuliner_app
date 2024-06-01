import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_kuliner_app/controller/auth_controller.dart';
import 'package:flutter_kuliner_app/controller/kuliner_controller.dart';
import 'package:flutter_kuliner_app/main.dart';
import 'package:flutter_kuliner_app/model/kuliner_model.dart';
import 'package:flutter_kuliner_app/view/form/form_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = KulinerController();
  final authController = AuthController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getDataKuliner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Utama"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Kuliner App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () async {
                authController.signOut();
                setState(() {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyApp(),
                      ),
                      (route) => false);
                });
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<List<KulinerModel>>(
              future: controller.getDataKuliner(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      KulinerModel kuliner = snapshot.data![index];

                      // Convert rating from string to integer
                      int rating = 0;
                      try {
                        rating =
                            double.parse(kuliner.rating.replaceAll(',', '.'))
                                .toInt();
                      } catch (e) {
                        throw ('Error parsing rating: $e');
                      }

                      if (kuliner.uid.toString() == user.uid) {
                        return Card(
                          elevation: 4,
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Gambar
                                Container(
                                  margin: const EdgeInsets.all(3),
                                  width: 100,
                                  height: 100,
                                  child: Image.network(
                                    kuliner.gambar!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 50,
                                      );
                                    },
                                  ),
                                ),

                                // Title and Address
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          kuliner.namaKuliner,
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          kuliner.alamatKuliner,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade200),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: List.generate(
                                          rating,
                                          (index) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Container(),
                        );
                      }
                    },
                  );
                }
              },
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FormView(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
