import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwa_ngajar/shared/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/user_provider.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late Future<List<Map<String, dynamic>>> _tasksFuture;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  Future<void> _refreshTasks() async {
    setState(() {
      _tasksFuture = Supabase.instance.client
          .from('tasks')
          .select()
          .order('created_at', ascending: false);
    });
  }

  Future<void> _addTask() async {
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
      await Supabase.instance.client.from('tasks').insert({
        'title': title,
        'url': url,
      });

      // Clear text fields
      titleController.clear();
      urlController.clear();

      // Refresh the materials list
      await _refreshTasks();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tugas berhasil ditambahkan')),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan tugas: ${e.toString()}')),
      );
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: _tasksFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              color: primaryBlue,
            ));
          }
          final tasks = snapshot.data!;
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
                    "Tugas",
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
                                  "Tambah Tugas",
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
                                                await _addTask();
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
                children: tasks.map(
                  (e) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: InkWell(
                        onTap: () => _launchUrl(e['url']),
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
                                e['title']!,
                                style: paragraph.copyWith(
                                    fontWeight: bold, color: darkColor),
                              ),
                              Text(
                                "Kelas VII",
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
