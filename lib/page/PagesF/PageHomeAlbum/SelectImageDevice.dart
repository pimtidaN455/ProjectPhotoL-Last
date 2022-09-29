import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_photo_learn/my_style.dart';

class SelectImageHomePage extends StatefulWidget {
  var imageListD;
  var imageListC;
  var iconselect;
  SelectImageHomePage(
      {required this.imageListD,
      required this.imageListC,
      required this.iconselect});

  @override
  _SelectImageDeviceState createState() => _SelectImageDeviceState(
      imageListD: this.imageListD,
      imageListC: this.imageListC,
      iconselect: this.iconselect);
}

class _SelectImageDeviceState extends State<SelectImageHomePage> {
  var imageListD;
  var imageListC;
  var iconselect;
  _SelectImageDeviceState(
      {required this.imageListD,
      required this.imageListC,
      required this.iconselect});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("หน้าเลือกแล้วจ้า");
    print(this.imageListD);
    print(this.imageListC);
    print(this.iconselect);
    print("ค่าาาาาา");

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Device",
            style: TextStyle(
              color: MyStyle().whiteColor,
            )),
        centerTitle: false,
        backgroundColor: MyStyle().blackColor,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.file_download_outlined,
              color: MyStyle().addColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outlined,
              color: MyStyle().deleteColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0),
        itemCount: imageListD.length + imageListC.length,
        itemBuilder: (builder, index) {
          return InkWell(
              onTap: () {
                setState(() {
                  imageListD[index].isSelected = !imageListD[index].isSelected;
                });
              },
              child: Stack(
                children: [
                  _getImage(imageListD[index].imageURL),
                  Opacity(
                    opacity: imageListD[index].isSelected ? 1 : 0,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.black38,
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            child: Icon(
                              Icons.check,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }

  _getImage(url) => Ink.image(
        fit: BoxFit.cover,
        image: FileImage(File(url)),
      );
  _getImageC(url) => Image.network(
        url,
        height: 500,
        fit: BoxFit.fitHeight,
      );

  @override
  void dispose() {
    super.dispose();
  }
}
