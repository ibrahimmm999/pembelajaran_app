import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwa_ngajar/provider/user_provider.dart';
import 'package:pwa_ngajar/shared/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MateriPage extends StatefulWidget {
  const MateriPage({super.key});

  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  late Future<List<Map<String, dynamic>>> _materialsFuture;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshMaterials();
  }

  Future<void> _refreshMaterials() async {
    setState(() {
      _materialsFuture = Supabase.instance.client
          .from('materials')
          .select()
          .order('created_at', ascending: false);
    });
  }

  Future<void> _addMaterial() async {
    final title = titleController.text.trim();
    final url = urlController.text.trim();

    // Validate inputs
    if (title.isEmpty || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Judul dan Link PDF harus diisi')),
      );
      return;
    }

    try {
      // Insert into Supabase
      await Supabase.instance.client.from('materials').insert({
        'title': title,
        'url': url,
      });

      // Clear text fields
      titleController.clear();
      urlController.clear();

      // Refresh the materials list
      await _refreshMaterials();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Materi berhasil ditambahkan')),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan materi: ${e.toString()}')),
      );
    }
  }

  Future<void> _launchMaterialUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _materialsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              color: primaryBlue,
            ));
          }
          final materials = snapshot.data!;
          return ListView(
            padding: EdgeInsets.only(left: 64, right: 80, bottom: 40),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: userProvider.isGuru
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                children: [
                  Text(
                    "Materi",
                    style: heading1.copyWith(
                      fontWeight: bold,
                      color: darkColor,
                    ),
                  ),
                  Visibility(
                    visible: userProvider.isGuru,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            backgroundColor: primaryBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: whiteColor,
                                title: Text(
                                  "Tambah Materi",
                                  style: heading3.copyWith(
                                      color: darkColor, fontWeight: bold),
                                ),
                                content: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  width: MediaQuery.sizeOf(context).width / 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Judul",
                                        style:
                                            heading4.copyWith(color: darkColor),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 12),
                                        decoration: BoxDecoration(
                                            color: whiteColor,
                                            border:
                                                Border.all(color: darkColor),
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: TextFormField(
                                          controller: titleController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Link PDF",
                                        style:
                                            heading4.copyWith(color: darkColor),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 12),
                                        decoration: BoxDecoration(
                                            color: whiteColor,
                                            border:
                                                Border.all(color: darkColor),
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: TextFormField(
                                          controller: urlController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 20),
                                                  backgroundColor:
                                                      Color(0xffEE6055)),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Batal",
                                                style: paragraph.copyWith(
                                                    color: whiteColor,
                                                    fontWeight: bold),
                                              )),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 20),
                                                  backgroundColor: primaryBlue),
                                              onPressed: () async {
                                                await _addMaterial();
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Tambah",
                                                style: paragraph.copyWith(
                                                    color: whiteColor,
                                                    fontWeight: bold),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          "Tambah +",
                          style: heading3.copyWith(
                              color: whiteColor, fontWeight: bold),
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 32,
              ),
              Column(
                children: materials.map(
                  (e) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: InkWell(
                        onTap: () => _launchMaterialUrl(e['url'] ?? ''),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: darkColor),
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e['title'] ?? '',
                                style: paragraph.copyWith(
                                    fontWeight: bold, color: darkColor),
                              ),
                              Text(
                                e['class'] ?? 'Kelas VII',
                                style: small.copyWith(color: greyColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              )
            ],
          );
        },
      ),
    );
  }
}
