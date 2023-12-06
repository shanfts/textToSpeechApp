import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:texttospeechapp/boxes/boxes.dart';
import 'package:texttospeechapp/colors/colors.dart';
import 'package:texttospeechapp/models/speech_models.dart';
import 'package:texttospeechapp/models/switch_model.dart';
import 'package:texttospeechapp/views/common_widgets/colorProvider.dart';
import 'package:texttospeechapp/views/common_widgets/commonWidgets.dart';

class historyScreenWidget extends StatelessWidget {
  const historyScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var fontSizeProvider = Provider.of<FontSizeProvider>(context);
    var fontColorProvider = Provider.of<FontColorProvider>(context);
    var viewMode = Provider.of<ViewMode>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.history,
                size: 30,
                color: Colors.white,
              ))
        ],
        toolbarHeight: 80,
        backgroundColor: primaryBackground,
        title: const Text(
          'History',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    viewMode.toggleView();
                  },
                  child: Consumer<ViewMode>(builder: (context, value, child) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            value.isGridView ? 'Grid View' : 'List View',
                            style: const TextStyle(
                                color: primaryBackground,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Icon(
                          value.isGridView ? Icons.grid_view : Icons.view_list,
                        )
                      ],
                    );
                  }),
                ),
                const Row(
                  children: [
                    Text(
                      'Sort By',
                      style: TextStyle(
                          color: primaryBackground,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.sort),
                    )
                  ],
                )
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            Expanded(
                child: Container(
              child: viewMode.isGridView
                  ? Scrollbar(
                      trackVisibility: true,
                      radius: const Radius.circular(15),
                      child: ValueListenableBuilder<Box<speechModel>>(
                        valueListenable: Boxes.getData().listenable(),
                        builder: (context, box, _) {
                          var data = box.values.toList().cast<speechModel>();
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: box.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(2, 5),
                                            spreadRadius: 0.1,
                                            blurRadius: 8)
                                      ]),
                                  child: ListTile(
                                      isThreeLine: true,
                                      subtitle: const Text('Date 12/03/2023 '),
                                      trailing: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.more_vert)),
                                      title: Text(
                                        data[index]
                                            .recognizedSpeeches
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: fontSizeProvider.fontSize,
                                            color: fontColorProvider
                                                .selectedColor),
                                        maxLines:
                                            4, // Limit the number of lines to prevent overflow
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  : Scrollbar(
                      trackVisibility: true,
                      radius: const Radius.circular(15),
                      child: ValueListenableBuilder<Box<speechModel>>(
                        valueListenable: Boxes.getData().listenable(),
                        builder: (context, box, _) {
                          var data = box.values.toList().cast<speechModel>();
                          return ListView.builder(
                            itemCount: box.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(2, 5),
                                            spreadRadius: 0.1,
                                            blurRadius: 8)
                                      ]),
                                  child: ListTile(
                                      trailing: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.more_vert)),
                                      title: Text(
                                        data[index]
                                            .recognizedSpeeches
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: fontSizeProvider.fontSize,
                                            color: fontColorProvider
                                                .selectedColor),
                                      )),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
            ))
          ],
        ),
      ),
    ));
  }
}
