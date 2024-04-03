class ModelHome {
  int? number;
  String? name;
  String? transliteration;
  String? meaning;
  String? keterangan;
  String? amalan;

  ModelHome(this.number, this.name, this.transliteration, this.meaning,
      this.keterangan, this.amalan);

  ModelHome.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    transliteration = json['transliteration'];
    meaning = json['meaning'];
    keterangan = json['keterangan'];
    amalan = json['amalan'];
  }
}
