import 'package:flutter/material.dart';
import 'package:texttospeechapp/colors/colors.dart';

class historyScreenWidget extends StatelessWidget {
  const historyScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Grid View',
                        style: TextStyle(
                            color: primaryBackground,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Icon(Icons.grid_view),
                  ],
                ),
                Row(
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
            )
          ],
        ),
      ),
    ));
  }
}
