import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwa_ngajar/provider/user_provider.dart';
import 'package:pwa_ngajar/shared/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late Future<List<Map<String, dynamic>>> _videosFuture;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshVideos();
  }

  Future<void> _refreshVideos() async {
    setState(() {
      _videosFuture = Supabase.instance.client
          .from('videos')
          .select()
          .order('created_at', ascending: false);
    });
  }

  Future<void> _addVideo() async {
    final title = titleController.text.trim();
    final url = urlController.text.trim();

    // Validate inputs
    if (title.isEmpty || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Judul dan Link Video harus diisi')),
      );
      return;
    }

    try {
      // Insert into Supabase
      await Supabase.instance.client.from('videos').insert({
        'title': title,
        'url': url,
      });

      // Clear text fields
      titleController.clear();
      urlController.clear();

      // Refresh the materials list
      await _refreshVideos();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Video berhasil ditambahkan')),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan video: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: _videosFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              color: primaryBlue,
            ));
          }
          final videos = snapshot.data!;
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
                    "Video",
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
                                  "Tambah Video",
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
                                        "Link Video",
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
                                                await _addVideo();
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
              const SizedBox(height: 24),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: videos.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 32),
                itemBuilder: (context, index) {
                  return VideoCard(
                    title: videos[index]['title'] ?? '',
                    kelas: "Kelas VII",
                    youtubeUrl: videos[index]['url'] ?? '',
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String title;
  final String kelas;
  final String youtubeUrl;

  const VideoCard({
    super.key,
    required this.title,
    required this.kelas,
    required this.youtubeUrl,
  });

  String getYoutubeVideoId(String url) {
    RegExp regExp = RegExp(
      r'^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*',
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp.firstMatch(url);
    return (match != null && match.groupCount >= 7) ? match.group(7)! : '';
  }

  String getYoutubeThumbnailUrl(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final String videoId = getYoutubeVideoId(youtubeUrl);
    final String thumbnailUrl = getYoutubeThumbnailUrl(videoId);

    return InkWell(
      onTap: () => _launchUrl(youtubeUrl),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: Image.network(
                thumbnailUrl,
                width: 200,
                height: 150,
                fit: BoxFit.cover,
                // Show a loading placeholder
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 150,
                    height: 120,
                    color: Colors.grey[300],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                // Show an error placeholder if the image fails to load
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 150,
                    height: 120,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
            // Right content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      kelas,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
