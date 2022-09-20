class Photo {
  late String id;
  late String photoName;
  late String photopath;
  late String photokeyword;
  late String photodescriptions;
  late String photoclass;
  late String fixalbum;
  late String statuscloud;
  Photo(
    this.id,
    this.photoName,
    this.photopath,
    this.photokeyword,
    this.photodescriptions,
    this.fixalbum,
    this.statuscloud,
    this.photoclass,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'photoName': photoName,
      'photopath': photopath,
      'photokeyword': photokeyword,
      'photodescriptions': photodescriptions,
      'fixalbum': fixalbum,
      'statuscloud': statuscloud,
      'photoclass': photoclass,
    };
    return map;
  }

  Photo.fromMap(dynamic map, bool bool) {
    id = map['id'];
    photoName = map['photoName'];
    photopath = map['photopath'];
    photokeyword = map['photokeyword'];
    photodescriptions = map['photodescriptions'];
    fixalbum = map['fixalbum'];
    statuscloud = map['statuscloud'];
    photoclass = map['photoclass'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return photopath;
  }
}
