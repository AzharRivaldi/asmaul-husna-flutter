import 'package:asmaul_husna/bookmark/model_bookmark.dart';
import 'package:asmaul_husna/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<ModelBookmark> listBookmark = [];
  DatabaseHelper databaseHelper = DatabaseHelper();
  int strCheckDatabase = 0;

  @override
  void initState() {
    super.initState();
    getDatabase();
    getAllData();
  }

  //cek database ada data atau tidak
  Future<void> getDatabase() async {
    var checkDB = await databaseHelper.cekDataBookmark();
    setState(() {
      if (checkDB == 0) {
        strCheckDatabase = 0;
      } else {
        strCheckDatabase = checkDB!;
      }
    });
  }

  //get data untuk menampilkan ke listview
  Future<void> getAllData() async {
    var listData = await databaseHelper.getDataBookmark();
    setState(() {
      listBookmark.clear();
      listData!.forEach((data) {
        listBookmark.add(ModelBookmark.fromMap(data));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            strCheckDatabase == 0
                ? Container(
                    padding: const EdgeInsets.only(top: 250),
                    child: const Center(
                      child: Text("Ups, belum ada bookmark.",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                      ),
                    ))
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listBookmark.length,
                    itemBuilder: (context, index) {
                      ModelBookmark modelbookmark = listBookmark[index];
                      return GestureDetector(
                        onTap: () {
                          AlertDialog alertDialog = AlertDialog(
                            title: const Text("Hapus Data",
                                style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            content: const SizedBox(
                              height: 20,
                              child: Column(
                                children: [
                                  Text("Yakin hapus data ini?",
                                      style: TextStyle(fontSize: 14, color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    deleteData(modelbookmark, index);
                                    Navigator.of(context, rootNavigator: true).pop();
                                  },
                                  child: const Text("Hapus",
                                      style: TextStyle(fontSize: 14, color: Colors.black),
                                  ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true).pop();
                                },
                                child: const Text("Batal",
                                    style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                              ),
                            ],
                          );
                          showDialog(
                              context: context,
                              builder: (context) => alertDialog);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: SvgPicture.asset(
                                        'assets/images/no.svg',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      child: Text(
                                          modelbookmark.number.toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        modelbookmark.transliteration.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        modelbookmark.meaning.toString(),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  modelbookmark.name.toString(),
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
          ],
        ),
      ),
    );
  }

  //untuk hapus data berdasarkan Id
  Future<void> deleteData(ModelBookmark modelBookmark, int position) async {
    await databaseHelper.deleteBookmark(modelBookmark.id!);
    setState(() {
      getDatabase();
      listBookmark.removeAt(position);
    });
  }
}
