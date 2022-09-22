import 'package:flutter/material.dart';

class SelectCloud extends StatefulWidget {
  @override
  _SelectCloudState createState() => _SelectCloudState();
}

class _SelectCloudState extends State<SelectCloud> {
  late List<ImageData> imageList;

  @override
  void initState() {
    super.initState();
    imageList = ImageData.getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.5,
            crossAxisCount: 5,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0),
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
                            backgroundColor: Color.fromARGB(255, 190, 42, 42),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
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

class ImageData {
  String imageURL;
  bool isSelected;
  int id;

  ImageData(this.imageURL, this.isSelected, this.id);

  static List<ImageData> getImage() {
    return [
      ImageData('https://picsum.photos/200', false, 1),
      ImageData('https://picsum.photos/100', false, 2),
      ImageData('https://picsum.photos/300', false, 3),
      ImageData('https://picsum.photos/400', false, 4),
      ImageData('https://picsum.photos/500', false, 5),
      ImageData('https://picsum.photos/600', false, 6),
      ImageData('https://picsum.photos/700', false, 7),
      ImageData('https://picsum.photos/800', false, 8),
      ImageData('https://picsum.photos/900', false, 9),
    ];
  }
}
