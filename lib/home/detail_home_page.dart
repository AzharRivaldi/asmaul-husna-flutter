import 'package:asmaul_husna/bookmark/model_bookmark.dart';
import 'package:asmaul_husna/database/database_helper.dart';
import 'package:asmaul_husna/main.dart';
import 'package:flutter/material.dart';

class DetailHomePage extends StatefulWidget {
  final String strNo, strMeaning, strName, strTranslate, strKeterangan, strAmalan;

  const DetailHomePage(
      {super.key, required this.strNo, required this.strMeaning,
        required this.strName, required this.strTranslate, required this.strKeterangan,
        required this.strAmalan});

  @override
  State<DetailHomePage> createState() => _DetailHomePageState();
}

class _DetailHomePageState extends State<DetailHomePage> {
  List<ModelBookmark> listBookmark = [];
  DatabaseHelper databaseHelper = DatabaseHelper();
  String? strNo, strMeaning, strName, strTranslate, strKeterangan, strAmalan;

  @override
  initState() {
    super.initState();
    strNo = widget.strNo;
    strMeaning = widget.strMeaning;
    strName = widget.strName;
    strTranslate = widget.strTranslate;
    strKeterangan = widget.strKeterangan;
    strAmalan = widget.strAmalan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: const Color(0xff8ac6d1),
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  strTranslate!,
                  style: const TextStyle(
                      fontSize: 20
                  ),
                ),
                background: Image.asset(
                  'assets/images/banner.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    strName!,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    strTranslate!,
                    style: const TextStyle(
                        fontSize: 18, color: Colors.black
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  strKeterangan!,
                  style: const TextStyle(
                      fontSize: 16, color: Colors.black
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  strAmalan!,
                  style: const TextStyle(
                      fontSize: 16, color: Colors.black
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool isTapped = false;
          setState(() async {
            if (!isTapped) {
              isTapped = true;
              await Future.delayed(const Duration(milliseconds: 3000));

              databaseHelper.saveData(ModelBookmark(
                number: strNo,
                name: strName,
                transliteration: strTranslate,
                meaning: strMeaning,
                keterangan: strKeterangan,
                amalan: strAmalan,
                flag: 'Y',
              ));

              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));

              isTapped = false;
            }
          });
        },
        child: const Icon(
          Icons.favorite,
          color: Colors.white,
        ),
      ),
    );
  }
}
