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

class SlideImageD extends StatelessWidget {
  final String title = 'Interactive Viewer';
  var namealbumS;
  var selectpicS;
  var listimageshow;
  var status;
  SlideImageD(
      {required this.namealbumS,
      required this.selectpicS,
      required this.listimageshow,
      required String status});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        home: SlideImageD2(
            title: title,
            namealbumS: this.namealbumS,
            selectpicS: this.selectpicS,
            listimageshow: this.listimageshow,
            status: this.status),
      );
}

class SlideImageD2 extends StatefulWidget {
  final String title;
  final String namealbumS;
  final String selectpicS;
  final listimageshow;
  final String status;
  const SlideImageD2(
      {required this.title,
      required this.namealbumS,
      required this.selectpicS,
      required this.listimageshow,
      required this.status});
  @override
  SlideImageDevice createState() => SlideImageDevice(
      title: namealbumS,
      selectPic: selectpicS,
      listimageshow: this.listimageshow,
      status: status);
}

class SlideImageDevice extends State<SlideImageD2>
    with TickerProviderStateMixin {
  final controller = TransformationController();
  late AnimationController controllerReset;
  String title;
  String selectPic;
  final listimageshow;
  String status;
  SlideImageDevice(
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
              child: Ink.image(
                  //fit: BoxFit.cover,
                  image: FileImage(File(selectPic))))));

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





/*import 'package:flutter/material.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';

// ignore: must_be_immutable
class SlideImage extends StatelessWidget {
  String title;
  int selectPic;
  SlideImage({required this.title, required this.selectPic});

  Widget build(BuildContext context) {
    print("selecpic ที่รับมาจาก Imageplace");
    print(this.selectPic);
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(this.title,
            style: TextStyle(
              color: MyStyle().blackColor,
            )),
        centerTitle: true,
        backgroundColor: MyStyle().whiteColor,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: MyStyle().blackColor,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowImage(name: this.title)));
            print("ส่งชื่ออัลบั้มไปที่ ShowImage" + this.title);
          },
        ),
      ),
      body: Body(selectPic: selectPic),
    ));
  }
}

// ignore: must_be_immutable
class Body extends StatefulWidget {
  int selectPic;
  Body({required this.selectPic});
  @override
  State<Body> createState() => _Body(currentIndex: selectPic);
}

class _Body extends State<Body> {
  int currentIndex;
  _Body({required this.currentIndex});
  //int selectPic1 = 0;
  PageController controller = PageController();
  List<String> imagelist = [
    './images/sangcom1.png',
    './images/sangcom2.png',
    './images/sangcom3.jpg',
    './images/sangcom4.jpg',
    './images/sangcom5.jpg',
    './images/sangcom6.png',
    './images/sangcom7.png',
    './images/sangcom8.png',
    './images/sangcom9.png',
    './images/sangcom10.png'
  ];

  @override
  Widget build(BuildContext context) {
    print("+++++++++++++++++++++++++++++++++++++++++++++++++");
    print(currentIndex);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 500,
            width: double.infinity,
            child: PageView.builder(
              controller: controller,
              //////////////////////////////////////////////
              onPageChanged: (index) {
                print("index : ");
                print(index);
                setState(() {
                  ////////////////////////////////////////////
                  currentIndex = index % imagelist.length;
                });
              },
              //////////////////////////////////////
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: Image.asset(
                      ///////////////////////////////////////////////////////////////
                      imagelist[currentIndex % imagelist.length],
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              for (var i = 0; i < imagelist.length; i++)
                buildIndicator(currentIndex == i)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    print("ค่าเปลี่ยนนหน้า ก่อน ถอยหลัง = ");
                    print(currentIndex);
                    controller.jumpToPage(currentIndex - 1);
                    print("ค่าเปลี่ยนนหน้า หลัง ถอยหลัง = ");
                    print(currentIndex);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () {
                    print("ค่าเปลี่ยนนหน้า ก่อน เดินหน้า = ");
                    print(currentIndex);
                    controller.jumpToPage(currentIndex + 1);
                    print("ค่าเปลี่ยนนหน้า หลัง เดินหน้า = ");
                    print(currentIndex);
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 12 : 10,
        width: isSelected ? 12 : 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
 */
