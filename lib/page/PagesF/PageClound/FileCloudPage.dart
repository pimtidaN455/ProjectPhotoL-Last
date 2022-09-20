import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/OpenFilepick.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/Use_Api.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'dart:typed_data';
import 'dart:convert';

import '../first.dart';

class FilePic extends StatefulWidget {
  var ListImgCloud;
  FilePic({required this.ListImgCloud});
  @override
  _MyAppState5 createState() => new _MyAppState5(ListImgCloud: ListImgCloud);
}

class _MyAppState5 extends State<FilePic> {
  var ListImgCloud;
  _MyAppState5({required this.ListImgCloud});

  List<Asset> images = <Asset>[];

  late File newFileNoCash;
  var listimage;
  @override
  void initState() {
    super.initState();
  }

  void selectImages() async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    //allowedExtensions: ['jpg', 'jpeg']);

    if (result == null) return;
    for (int i = 0; i < result.files.length; i++) {
      newFileNoCash = await saveFilePermanently(result.files[i]);
      print('To path : ');
      print(newFileNoCash.path);
      print(result.files[i].name);

      File file = await File(newFileNoCash.path);
      Uint8List bytes = await file.readAsBytesSync();
      String base64Image = await base64Encode(bytes);
      print(await base64Image);
      use_API use_Api = await new use_API();
      //ส่งรูปไปที่ sever
      var addimg_cloud = await use_Api.Addimage_clound(
        await result.files[i].name,
        await newFileNoCash.path,
        await base64Image,
      );

      /*Photo pt = new Photo(i.toString(), result.files[i].name,
          newFileNoCash.path, "keyword", "class");
      print("pt.toStringggggggg");
      print(pt.toString());
      print("******************************");*/

      /*DBHelper db = await DBHelper();
      await db.checkDatabase();
      print("เซฟฟฟฟฟฟฟฟฟฟฟฟโฟโค้วววว");
      await db.savePhoto(await pt);
      openFiles(result.files);
      print("result files หลังจากเลือกรูปแล้ว");
      print(result.files); 
      */
    }

    //openFile(newFile.path);
    /*print('From path : ');
    print(file.path);
    print('To path: ');
    print(newFile);
    print(newFile.path);

    
    print(newFile.uri);*/
  }

  void openFiles(List<PlatformFile> files) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              FilesPage(files: files, onOpenedFile: openFile)));

  void openFile(PlatformFile newFile) {
    OpenFile.open(newFile.path!);
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    print('saveFilePermanently :');
    print(appStorage.path);
    print('saveFilePermanently Name :');
    print(file.name);
    return File(file.path!).copy(newFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          appBar: new AppBar(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            title: Text(
              "Clound",
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
                //fontStyle: FontStyle.normal,
                fontFamily: 'Rajdhani',
              ),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.add_photo_alternate_outlined,
                    color: MyStyle().blackColor,
                  ),
                  onPressed: () async {
                    _MyAppState5 st =
                        new _MyAppState5(ListImgCloud: ListImgCloud);
                    st.selectImages();
                    user_file user = await new user_file();
                    await user.getdata_user_file();
                    var user0 = await user;
                    var ListImgCloud0;
                    var listimageshow;

                    //

                    if (await user.Login) {
                      list_album la = new list_album();
                      var ListImageDevice = await la.getimagefrom_api();
                      print(
                          'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
                      print(await la.listimageshow);
                      listimagecloud listimgC = new listimagecloud();
                      ListImgCloud0 = await listimgC.getimagefrom_api();
                      print('\\\\\\\\\\\\\\\\\List\\\\\\\\\\\\\\\\');
                      for (int i = 0; i < ListImgCloud0.length; i++) {
                        print(await ListImgCloud0[i].geturlimage());
                      }
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FirstState(
                                page: 2,
                                user: user,
                                listimageshow: listimageshow,
                                ListImgCloud: ListImgCloud0)));
                  }),
              IconButton(
                icon: Icon(
                  Icons.delete_outlined,
                  color: MyStyle().deleteColor,
                ),
                onPressed: () {},
              ),
            ],
            automaticallyImplyLeading: false,
          ),
          body: CachedNetworkImage(
            imageUrl:
                "https://firebasestorage.googleapis.com/v0/b/photolearn-439fc.appspot.com/o/rE0aqrXdnQMzX5eKSWPWFTmBvkY2%2F-NCKoMXD9yVnuNyx-3hM.png?alt=media&token=rE0aqrXdnQMzX5eKSWPWFTmBvkY2",
            placeholder: (context, url) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                  strokeWidth: 2,
                ),
              );
            },
            errorWidget: (context, url, error) {
              // This was the reason for exception being triggered and rendered!
              debugPrint(error); // TODO: Remove this line!
              return Center(
                child: Text(
                  'Error',
                  style: TextStyle(color: Colors.red),
                ),
              );
            },
          )
/*Container(
            width: double.infinity,
            height: double.infinity,
            //color: Colors.yellow,
            child: Image.network(
              "https://images.unsplash.com/photo-1547721064-da6cfb341d50",
              fit: BoxFit.cover,
            ),
          ),*/

          /*  Column(
          children: <Widget>[
            Expanded(
              child: GridView.count(
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                padding: EdgeInsets.all(8),
                childAspectRatio: 1 / 1.2,
                crossAxisCount: 3,
                children: List.generate(images.length, (index) {
                  Asset asset = images[index];
                  //print("ชื่อรูปภาพที่ : ");
                  //print(index);
                  print(images[index].name);
                  //print("///////////////////////////");
                  return Ink.image(
                      //fit: BoxFit.fitWidth,
                      image: CachedNetworkImageProvider(
                          'https://www.poder360.com.br/internacional/grupo-de-k-pop-bts-fala-de-diversidade-em-visita-a-casa-branca/'));
                }).toList(),
              ),
            )
          ],
        ),*/
          ),
    );
  }

  ImageStream createStream(ImageConfiguration configuration) {
    return ImageStream();
  }
}

//// /sdcard/Download/member-rm.jpg  /////


/*import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/Sqfl/OpenFilepick.dart';
import 'package:project_photo_learn/Sqfl/Photo.dart';
import 'package:project_photo_learn/my_style.dart';

class FilePic extends StatefulWidget {
  @override
  _MyAppState5 createState() => new _MyAppState5();
}

class _MyAppState5 extends State<FilePic> {
  List<Asset> images = <Asset>[];
  late File newFileNoCash;
  @override
  void initState() {
    super.initState();
  }

  void selectImages() async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    //allowedExtensions: ['jpg', 'jpeg']);

    if (result == null) return;

    for (int i = 0; i < result.files.length; i++) {
      newFileNoCash = await saveFilePermanently(result.files[i]);
      print('To path : ');
      print(newFileNoCash.path);
      print(result.files[i].name);

      Photo pt = new Photo(i.toString(), result.files[i].name,
          newFileNoCash.path, "keyword", "class");

      DBHelper db = new DBHelper();
      //db.savePhoto(pt);
    }
    openFiles(result.files);
    print("result files หลังจากเลือกรูปแล้ว");
    print(result.files);
    //openFile(newFile.path);
    /*print('From path : ');
    print(file.path);
    print('To path: ');
    print(newFile);
    print(newFile.path);
    print(newFile.uri);*/
  }

  void openFiles(List<PlatformFile> files) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              FilesPage(files: files, onOpenedFile: openFile)));

  void openFile(PlatformFile newFile) {
    OpenFile.open(newFile.path!);
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    print('saveFilePermanently :');
    print(appStorage.path);
    print('saveFilePermanently Name :');
    print(file.name);
    return File(file.path!).copy(newFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            "Clound",
            style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              //fontStyle: FontStyle.normal,
              fontFamily: 'Rajdhani',
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: MyStyle().blackColor,
                ),
                onPressed: selectImages),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Edit ",
                  style: TextStyle(
                    fontSize: 20,
                    color: MyStyle().blackColor,
                    fontWeight: FontWeight.bold,
                    //fontStyle: FontStyle.normal,
                    fontFamily: 'Rajdhani',
                  ),
                ))
          ],
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: GridView.count(
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                padding: EdgeInsets.all(8),
                childAspectRatio: 1 / 1.2,
                crossAxisCount: 3,
                children: List.generate(images.length, (index) {
                  Asset asset = images[index];
                  //print("ชื่อรูปภาพที่ : ");
                  //print(index);
                  print(images[index].name);
                  //print("///////////////////////////");
                  return Ink.image(
                      fit: BoxFit.cover,
                      image: AssetImage(asset.toString()),
                      child: InkWell(onTap: () {}));
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}*/
