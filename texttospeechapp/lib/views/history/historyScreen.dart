import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:share_plus/share_plus.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:texttospeechapp/boxes/boxes.dart';
import 'package:texttospeechapp/colors/colors.dart';
import 'package:texttospeechapp/models/sorting_model.dart';
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
    final sortOptionNotifier = Provider.of<SortOptionNotifier>(context);
    var viewMode = Provider.of<ViewMode>(context);
    List items = ['Ascending(A-Z)', 'Descending(Z-A)', 'Date Modified'];
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
                Row(
                  children: [
                    ChangeNotifierProvider(
                      create: (_) => SortOptionNotifier(),
                      child: Consumer<SortOptionNotifier>(
                        builder: (context, sortOptionNotifier, _) => Center(
                          child: Row(
                            children: [
                              const Text(
                                'Sort by: ',
                                style: TextStyle(
                                    color: primaryBackground,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              DropdownButton<String>(
                                value: sortOptionNotifier.selectedOption,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    sortOptionNotifier
                                        .setSelectedOption(newValue);
                                    // Perform actions based on the selected value here
                                    // For instance, you could call a function to sort accordingly
                                  }
                                },
                                items: <String>[
                                  'Ascending',
                                  'Descending',
                                  'By Date'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // TextButton(
                    //     onPressed: () {},
                    //     child: const Row(
                    //       children: [
                    //         Text(
                    //           'Sort By',
                    //           style: TextStyle(
                    //               color: primaryBackground,
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.w500),
                    //         ),
                    //         Padding(
                    //           padding: EdgeInsets.all(8.0),
                    //           child: Icon(
                    //             Icons.sort,
                    //             color: primaryBackground,
                    //           ),
                    //         )
                    //       ],
                    //     )),
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
                              mainAxisExtent: 180,
                            ),
                            itemCount: box.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(5),
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
                                      trailing: PopupMenuButton<String>(
                                        surfaceTintColor: Colors.white,
                                        shape: Border.all(
                                            color: primaryBackground),
                                        onSelected: (String value) {
                                          if (value == 'delete') {
                                            delete(data[index]);
                                          } else if (value == 'share') {
                                            String content = data[index]
                                                .recognizedSpeeches
                                                .toString();

                                            _shareContent(context, content);
                                          }
                                        },
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<String>>[
                                          const PopupMenuItem<String>(
                                            value: 'delete',
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete),
                                                Text('Delete'),
                                              ],
                                            ),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'share',
                                            child: Row(
                                              children: [
                                                Icon(Icons.share),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('Share'),
                                              ],
                                            ),
                                          ),
                                        ],
                                        icon: const Icon(Icons.more_vert),
                                      ),
                                      title: Text(
                                        data[index]
                                            .recognizedSpeeches
                                            .toString(),
                                        maxLines: 5,
                                        style: TextStyle(
                                          fontSize: fontSizeProvider.fontSize,
                                          color:
                                              fontColorProvider.selectedColor,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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
                                      trailing: PopupMenuButton<String>(
                                        surfaceTintColor: Colors.white,
                                        shape: Border.all(
                                            color: primaryBackground),
                                        onSelected: (String value) {
                                          if (value == 'delete') {
                                            delete(data[index]);
                                          } else if (value == 'share') {
                                            String content = data[index]
                                                .recognizedSpeeches
                                                .toString();

                                            _shareContent(context, content);
                                          }
                                        },
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<String>>[
                                          const PopupMenuItem<String>(
                                            value: 'delete',
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete),
                                                Text('Delete'),
                                              ],
                                            ),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'share',
                                            child: Row(
                                              children: [
                                                Icon(Icons.share),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('Share'),
                                              ],
                                            ),
                                          ),
                                        ],
                                        icon: const Icon(Icons.more_vert),
                                      ),
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

void delete(speechModel speechModel) async {
  await speechModel.delete();
}

void _shareContent(BuildContext context, String content) {
  if (content.isNotEmpty) {
    Share.share(content).then((value) {
      // Share completed
      // Add any post-sharing logic here
    }).catchError((error) {
      // Handle sharing error
      // Display error message or perform fallback action
    });
  } else {
    // Handle empty content case
    // Display a message or perform an action if there's no content to share
  }
}

// class DropdownButtonWidget extends StatelessWidget {
//   const DropdownButtonWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final sortOptionNotifier = Provider.of<SortOptionNotifier>(context);

//     return DropdownButton<String>(
//       value: sortOptionNotifier.selectedOption,
//       onChanged: (String? newValue) {
//         if (newValue != null) {
//           sortOptionNotifier.setSelectedOption(newValue);
//           // Perform actions based on the selected value here
//           // For instance, you could call a function to sort accordingly
//         }
//       },
//       items: <String>['Ascending', 'Descending', 'By Date']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
