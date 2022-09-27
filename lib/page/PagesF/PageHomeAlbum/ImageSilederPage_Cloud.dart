import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageClound/FileCloudPage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/HomePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

class SlideImageC extends StatelessWidget {
  final String title = 'Interactive Viewer';
  var namealbumS;
  var selectpicS;
  var listimageshow;
  var status;
  SlideImageC(
      {required this.namealbumS,
      required this.selectpicS,
      required this.listimageshow,
      required String status});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        home: SlideImageC2(
            title: title,
            namealbumS: this.namealbumS,
            selectpicS: this.selectpicS,
            listimageshow: this.listimageshow,
            status: this.status),
      );
}

class SlideImageC2 extends StatefulWidget {
  final String title;
  final String namealbumS;
  final String selectpicS;
  final listimageshow;
  final String status;
  const SlideImageC2(
      {required this.title,
      required this.namealbumS,
      required this.selectpicS,
      required this.listimageshow,
      required this.status});
  @override
  SlideImageCloud createState() => SlideImageCloud(
      title: namealbumS,
      selectPic: selectpicS,
      listimageshow: this.listimageshow,
      status: status);
}

class SlideImageCloud extends State<SlideImageC2>
    with TickerProviderStateMixin {
  final controller = TransformationController();
  late AnimationController controllerReset;
  String title;
  String selectPic;
  final listimageshow;
  String status;
  SlideImageCloud(
      {required this.title,
      required this.selectPic,
      required this.listimageshow,
      required this.status});

  @override
  void initState() {
    super.initState();

    controllerReset = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    controller.addListener(() {
      if (controller.value.getMaxScaleOnAxis() >= 3) {
        print('Scale >= 3.0');
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(this.title,
            style: TextStyle(
              color: MyStyle().blackColor,
            )),
        centerTitle: true,
        backgroundColor: MyStyle().whiteColor,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.file_download_outlined,
              color: MyStyle().blackColor,
            ),
            onPressed: () {
              title; //ชื่อรูปคลาว
              selectPic; //ลิ้งค์รูปคาว
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: MyStyle().deleteColor,
            ),
            onPressed: () {
              title; //ชื่อรูปคลาว
              selectPic; //ลิ้งค์รูปคาว
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: MyStyle().blackColor,
            ),
            onPressed: () async {
              user_file user0 = new user_file();

              await user0.getdata_user_file();
              var user = await user0;
              var ListImgCloud;
              var listimageshow;

              //
              if (await user.Login) {
                list_album la = await new list_album();
                await la.getimagefrom_api();
                print(
                    'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
                listimageshow = await la.listimageshow;

                listimagecloud listimgC = await new listimagecloud();
                ListImgCloud = await listimgC.getimagefrom_api();
                print('\\\\\\\\\\\\\\\\\List\\\\\\\\\\\\\\\\');
                /*for (int i = 0; i < ListImgCloud.length; i++) {
                    print(await ListImgCloud[i].geturlimage());
                  }*/
              }

              var Request_page = ShowImage(
                name: title,
                listimageshow: this.listimageshow,
              );

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Request_page));
              print("ส่งชื่ออัลบั้มไปที่ ShowImage" + this.title);
            }),
      ),
      body: Center(
          child: InteractiveViewer(
              clipBehavior: Clip.none,
              minScale: 0.5,
              maxScale: 4,
              onInteractionEnd: (details) {
                print('End interaction');
              },
              transformationController: controller,
              child: CachedNetworkImage(
                imageUrl: selectPic,
              ))));

  void reset() {
    final animationReset = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(controllerReset);

    animationReset.addListener(() {
      setState(() {
        controller.value = animationReset.value;
      });
    });

    controllerReset.reset();
    controllerReset.forward();
  }
}
