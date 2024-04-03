class ModelBookmark {
  int? id;
  String? number;
  String? name;
  String? transliteration;
  String? meaning;
  String? flag;
  String? keterangan;
  String? amalan;

  ModelBookmark({this.id, this.number, this.name,
    this.transliteration, this.meaning, this.flag,
    this.keterangan, this.amalan});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['number'] = number;
    map['name'] = name;
    map['translate'] = transliteration;
    map['meaning'] = meaning;
    map['flag'] = flag;
    map['keterangan'] = keterangan;
    map['amalan'] = amalan;

    return map;
  }

  ModelBookmark.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    number = map['number'];
    name = map['name'];
    transliteration = map['translate'];
    meaning = map['meaning'];
    flag = map['flag'];
    keterangan = map['keterangan'];
    amalan = map['amalan'];
  }

}
