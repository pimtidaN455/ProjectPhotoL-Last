import 'package:flutter/material.dart';
import 'package:project_photo_learn/my_style.dart';

class SelectImageCloud extends StatefulWidget {
  var imageList;
  SelectImageCloud({required this.imageList});
  @override
  _SelectImageCloudState createState() =>
      _SelectImageCloudState(imageList: imageList);
}

class _SelectImageCloudState extends State<SelectImageCloud> {
  var imageList;
  _SelectImageCloudState({required this.imageList});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Cloud",
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
        itemCount: imageList.length,
        itemBuilder: (builder, index) {
          return InkWell(
              onTap: () {
                setState(() {
                  imageList[index].isSelected = !imageList[index].isSelected;
                });
              },
              child: Stack(
                children: [
                  _getImage(imageList[index].imageURL),
                  Opacity(
                    opacity: imageList[index].isSelected ? 1 : 0,
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

  _getImage(url) => Image.network(
        url,
        height: 500,
        fit: BoxFit.fitHeight,
      );

  @override
  void dispose() {
    super.dispose();
  }
}
