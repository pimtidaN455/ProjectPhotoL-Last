import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/Backend/User_data.dart';
import 'package:project_photo_learn/page/PagesF/PageClound/FileCloudPage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';

class SlideImageC extends StatelessWidget {
  final String title = 'Interactive Viewer';
  var namealbumC;
  var selectpicC;
  SlideImageC({required this.namealbumC, required this.selectpicC});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        home: SlideImageC2(
            title: title,
            namealbumC: this.namealbumC,
            selectpicC: this.selectpicC),
      );
}

class SlideImageC2 extends StatefulWidget {
  final String title;
  final String namealbumC;
  final String selectpicC;
  const SlideImageC2(
      {required this.title,
      required this.namealbumC,
      required this.selectpicC});

  @override
  _MainPageState createState() =>
      _MainPageState(namealbumC: namealbumC, selectpicC: selectpicC);
}

class _MainPageState extends State<SlideImageC2> with TickerProviderStateMixin {
  final controller = TransformationController();
  late AnimationController controllerReset;
  final String namealbumC;
  final String selectpicC;

  _MainPageState({required this.namealbumC, required this.selectpicC});

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
          title: Text("Cloud",
              style: TextStyle(
                color: MyStyle().blackColor,
              )),
          centerTitle: false,
          backgroundColor: MyStyle().whiteColor,
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.file_download_outlined,
                color: MyStyle().blackColor,
              ),
              onPressed: () {
                namealbumC; //ชื่อรูปคลาว
                selectpicC; //ลิ้งค์รูปคาว
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: MyStyle().deleteColor,
              ),
              onPressed: () {
                namealbumC; //ชื่อรูปคลาว
                selectpicC; //ลิ้งค์รูปคาว
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
                  list_album la = new list_album();
                  var ListImageDevice = await la.getimagefrom_api();
                  print(
                      'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
                  print(await la.listimageshow);
                  listimagecloud listimgC = new listimagecloud();
                  ListImgCloud = await listimgC.getimagefrom_api();
                  print('\\\\\\\\\\\\\\\\\List\\\\\\\\\\\\\\\\');
                  for (int i = 0; i < ListImgCloud.length; i++) {
                    print(await ListImgCloud[i].gettoString());
                  }
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FilePic(
                              ListImgCloud: ListImgCloud,
                            )));
                print("ส่งชื่ออัลบั้มไปที่ ShowImage" + this.namealbumC);
              })),
      body: Center(
        child: InteractiveViewer(
          clipBehavior: Clip.none,
          //boundaryMargin: EdgeInsets.all(0),
          minScale: 0.5,
          maxScale: 4,
          //scaleEnabled: false,
          //constrained: false,
          //onInteractionStart: (details) => print('Start interaction'),
          //onInteractionUpdate: (details) => print('Update interaction'),
          onInteractionEnd: (details) {
            print('End interaction');
            //reset();
          },
          transformationController: controller,

          child: CachedNetworkImage(
            imageUrl: selectpicC,
          ),
        ),
      ));

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

    /*setState(() {
      controller.value = Matrix4.identity();
    });
  }*/
  }
}
