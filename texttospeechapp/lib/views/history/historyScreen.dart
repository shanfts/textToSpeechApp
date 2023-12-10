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
                        builder: (context, SortOptionNotifier, _) => Center(
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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

                          var sortedData = <speechModel>[];
                          switch (sortOptionNotifier.selectedOption) {
                            case 'Ascending':
                              sortedData = box.values
                                  .toList()
                                  .cast<speechModel>()
                                ..sort((a, b) => a.recognizedSpeeches
                                    .compareTo(b.recognizedSpeeches));
                              break;
                            case 'Descending':
                              sortedData =
                                  box.values.toList().cast<speechModel>();
                              sortedData.sort((a, b) => b.recognizedSpeeches
                                  .compareTo(a.recognizedSpeeches));
                              break;
                            case 'By Date':
                              sortedData =
                                  box.values.toList().cast<speechModel>();
                              break;
                            default:
                              sortedData =
                                  box.values.toList().cast<speechModel>();
                              break;
                          }
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              mainAxisExtent: 180,
                            ),
                            itemCount: sortedData.length,
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
                                      subtitle: Text(
                                        sortedData[index]
                                            .recognizedSpeeches
                                            .toString(),
                                        maxLines: 3,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color:
                                              fontColorProvider.selectedColor,
                                          fontSize: fontSizeProvider.fontSize,
                                        ),
                                      ),
                                      title: Text(
                                        sortedData[index]
                                            .dateAndTime
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
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

                          var sortedData = <speechModel>[];
                          switch (sortOptionNotifier.selectedOption) {
                            case 'Ascending':
                              sortedData = box.values
                                  .toList()
                                  .cast<speechModel>()
                                ..sort((a, b) => a.recognizedSpeeches
                                    .compareTo(b.recognizedSpeeches));
                              break;
                            case 'Descending':
                              sortedData =
                                  box.values.toList().cast<speechModel>();
                              sortedData.sort((a, b) => b.recognizedSpeeches
                                  .compareTo(a.recognizedSpeeches));
                              break;
                            case 'By Date':
                              sortedData = box.values.toList().cast<
                                  speechModel>(); // Assuming initial order is by date
                              break;
                            default:
                              sortedData =
                                  box.values.toList().cast<speechModel>();
                              break;
                          }
                          return ListView.builder(
                            itemCount: sortedData.length,
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
                                      subtitle: Text(
                                        sortedData[index]
                                            .recognizedSpeeches
                                            .toString(),
                                        maxLines: 3,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color:
                                              fontColorProvider.selectedColor,
                                          fontSize: fontSizeProvider.fontSize,
                                        ),
                                      ),
                                      title: Text(
                                        sortedData[index]
                                            .dateAndTime
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
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
