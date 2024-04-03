import 'dart:convert';

import 'package:asmaul_husna/home/detail_home_page.dart';
import 'package:asmaul_husna/home/model_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //method get data assets
  Future<List<ModelHome>> readJsonData() async {
    final jsonData = await rootBundle.rootBundle.loadString('assets/data/asmaul_husna.json');
    final listJson = json.decode(jsonData) as List<dynamic>;
    return listJson.map((e) => ModelHome.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: readJsonData(),
              builder: (context, data) {
                if (data.hasError) {
                  return Center(
                      child: Text('${data.error}')
                  );
                } else if (data.hasData) {
                  var items = data.data as List<ModelHome>;
                  return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            String strNo = items[index].number.toString();
                            String strMeaning = items[index].meaning.toString();
                            String strName = items[index].name.toString();
                            String strTranslate = items[index].transliteration.toString();
                            String strKeterangan = items[index].keterangan.toString();
                            String strAmalan = items[index].amalan.toString();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailHomePage(
                                        strNo: strNo,
                                        strMeaning: strMeaning,
                                        strName: strName,
                                        strTranslate: strTranslate,
                                        strKeterangan: strKeterangan,
                                        strAmalan: strAmalan),
                                ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
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
                                            items[index].number.toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold
                                            ),
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
                                          items[index].transliteration.toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        subtitle: Text(
                                          items[index].meaning.toString(),
                                          style: const TextStyle(
                                              fontSize: 12
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    items[index].name.toString(),
                                    style: const TextStyle(
                                        fontSize: 24
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xffffb6b9)),
                      ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
