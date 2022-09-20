import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

import '../../Backend/User_data.dart';

// ignore: must_be_immutable
class SlideImageC extends StatelessWidget {
  int startImg;
  String namealbumC;

  SlideImageC({required this.namealbumC, required this.startImg});

  Widget build(BuildContext context) {
    print(this.namealbumC);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(this.namealbumC,
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
                      builder: (context) => FirstState(
                          page: 0,
                          user: user,
                          listimageshow: listimageshow,
                          ListImgCloud: ListImgCloud)));
              print("ส่งชื่ออัลบั้มไปที่ ShowImage" + this.namealbumC);
            },
          ),
        ),
        body: Body(startImg: startImg),
      ),
    );
  }
}

// ignore: must_be_immutable
class Body extends StatefulWidget {
  int startImg;
  Body({required this.startImg});

  @override
  State<Body> createState() => _Body(startImg: startImg);
}

class _Body extends State<Body> {
  int startImg;
  _Body({required this.startImg});
  int currentIndex = 0;
  final PageController controller = PageController();
  List<String> imagelistC = [
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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 500,
            width: double.infinity,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index % imagelistC.length;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: Image.asset(
                      //////////////////////////////รับค่า int เปลี่ยนหน้า ////////////////////////////////
                      //imagelistC[this.startImg % imagelistC.length],
                      imagelistC[index % imagelistC.length],
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < imagelistC.length; i++)
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
                    controller.jumpToPage(currentIndex - 1);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () {
                    controller.jumpToPage(currentIndex + 1);
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
