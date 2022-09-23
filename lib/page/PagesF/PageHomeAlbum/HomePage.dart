// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/AddAlbumPage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ManageHomePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

class Homepage extends StatefulWidget {
  var user;
  var listimageshow;
  Homepage({required this.user, required this.listimageshow});
  @override
  AlbumScreenWidget createState() =>
      AlbumScreenWidget(user: user, listimageshow: this.listimageshow);
}

class AlbumScreenWidget extends State<Homepage> {
  var user;
  var listimageshow;
  AlbumScreenWidget({required this.user, required this.listimageshow});
  int optionSelected = 0;
  late int selectbum;
  void checkOption(int index) {
    setState(() {
      optionSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyStyle().whiteColor,
          title: Text(
            "Album",
            style: TextStyle(
              fontSize: 30,
              color: MyStyle().blackColor,
              fontWeight: FontWeight.bold,
              //fontStyle: FontStyle.normal,
              fontFamily: 'Rajdhani',
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add_photo_alternate_outlined,
                //Icons.add_a_photo_outlined,
                color: MyStyle().blackColor,
              ),
              onPressed: () async {
                Manage_Homepage mnhome = new Manage_Homepage();
                mnhome.selectImages();
                user_file user = await new user_file();
                await user.getdata_user_file();
                var user0 = await user;
                var ListImgCloud;
                var listimageshow;

                //

                if (await user.Login) {
                  list_album la = new list_album();
                  var ListImageDevice = await la.getimagefrom_api();
                  print(
                      'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
                  print(await la.listimageshow_device);
                  listimagecloud listimgC = new listimagecloud();
                  ListImgCloud = await listimgC.getimagefrom_api();
                  print('\\\\\\\\\\\\\\\\\List\\\\\\\\\\\\\\\\');
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirstState(
                            page: 0,
                            user: user,
                            listimageshow: listimageshow,
                            ListImgCloud: ListImgCloud)));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.create_new_folder_outlined,
                color: MyStyle().addColor,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Add_Album_Page()));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.folder_delete_outlined,
                color: MyStyle().deleteColor,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Add_Album_Page()));
              },
            ),
            /*TextButton(
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
                ))*/
          ],
          automaticallyImplyLeading: false,
        ),
        body: GridView.extent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: EdgeInsets.all(8),
          childAspectRatio: 1 / 1.2,
          children: <Widget>[
            /*if (this.listimageshow["device"] != null)
              for (int i = 0; i < this.listimageshow["device"].length; i++)
                _GridItem_Devoce(
                  this.listimageshow["device"][i]['Namebum'] as String,
                  img: this.listimageshow["device"][i]['img'] as String,
                  onTap: () => checkOption(i + 1),
                  selected: i + 1 == optionSelected,
                  selectbum: i + 1,
                ),
            for (int i = 0; i < this.listimageshow["cloud"].length; i++)
              _GridItem_Cloud(
                this.listimageshow["cloud"][i]['Namebum'] as String,
                img: this.listimageshow["cloud"][i]['img'] as String,
                onTap: () => checkOption(i + 1),
                selected: i + 1 == optionSelected,
                selectbum: i + 1,
              ),*/
          ],
        ));
  }
}

class _GridItem_Devoce extends StatelessWidget {
  const _GridItem_Devoce(
    this.title, {
    Key? key,
    required this.img,
    required this.selectbum,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  final String title;
  final String img;
  final int selectbum;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    print("อิมเมจจจจจจจจจจ");
    print(title);
    print(img);
    return Ink.image(
      fit: BoxFit.cover,
      image: AssetImage(img),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      //ShowImage(name: title, selectbum: selectbum)
                      ShowImage(
                        name: title,
                        selectbum: selectbum,
                      )));
          print("เลือกอัลบั้มที่ : ");
          print(selectbum);
          print("///////////////////////////////////////////////////////");
        },
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            /*decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: selected ?? false ? Colors.red : Colors.transparent,
                  width: selected ?? false ? 5 : 0,
                ),
              ),
            ),*/
            padding: const EdgeInsets.all(8.0),
            child: Row(children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _GridItem_Cloud extends StatelessWidget {
  const _GridItem_Cloud(
    this.title, {
    Key? key,
    required this.img,
    required this.selectbum,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  final String title;
  final String img;
  final int selectbum;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    print("อิมเมจจจจจจจจจจ");
    print(title);
    print(img);
    return Ink.image(
      fit: BoxFit.cover,
      image: AssetImage(img),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      //ShowImage(name: title, selectbum: selectbum)
                      ShowImage(
                        name: title,
                        selectbum: selectbum,
                      )));
          print("เลือกอัลบั้มที่ : ");
          print(selectbum);
          print("///////////////////////////////////////////////////////");
        },
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            /*decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: selected ?? false ? Colors.red : Colors.transparent,
                  width: selected ?? false ? 5 : 0,
                ),
              ),
            ),*/
            padding: const EdgeInsets.all(8.0),
            child: Row(children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
