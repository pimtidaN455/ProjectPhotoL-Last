/*import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';

var suggestTag = ["Pizza", "Pasta", "Spagetti"];

class Addbum22 extends StatelessWidget {
  final controller = Get.put(TagStateController());
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "Search",
          style: TextStyle(
            fontSize: 30,
            color: MyStyle().whiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rajdhani',
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "\n   ใส่คำค้นหาได้ไม่เกิน 6 ครั้ง",
          style: TextStyle(
            fontSize: 20,
            color: MyStyle().blackColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rajdhani',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: textController,
              onEditingComplete: () {
                controller.listTags.add(textController.text);
                textController.clear();
              },
              autofocus: false,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tag',
                contentPadding: EdgeInsets.symmetric(vertical: 2),
                prefixIcon: Icon(Icons.tag),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (textController.text != "") {
                      controller.listTags.add(textController.text);
                    }
                    textController.clear();
                  },
                  icon: const Icon(Icons.add),
                ),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
            suggestionsCallback: (String pattern) {
              return suggestTag.where(
                  (e) => e.toLowerCase().contains(pattern.toLowerCase()));
            },
            onSuggestionSelected: (String suggestion) =>
                controller.listTags.add(suggestion),
            itemBuilder: (BuildContext context, Object? itemData) {
              return ListTile(
                leading: Icon(Icons.tag),
                title: Text(itemData.toString()),
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "   # ที่คุณต้องการค้นหา ",
          style: TextStyle(
            fontSize: 20,
            color: MyStyle().blackColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rajdhani',
          ),
        ),
        Obx(() => controller.listTags.length == 0
            ? Center(
                child: Text('\n No tag'),
              )
            : Wrap(
                children: controller.listTags
                    .map((element) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Chip(
                            label: Text(element),
                            deleteIcon: Icon(Icons.clear),
                            onDeleted: () =>
                                controller.listTags.remove(element),
                          ),
                        ))
                    .toList(),
              ))
      ]),
    ));
  }
}
*/