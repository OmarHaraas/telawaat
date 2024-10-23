import 'dart:convert';

import 'package:flutter/material.dart';
import '/models/azqaar_model.dart';

class AzqaarPage extends StatelessWidget {
  const AzqaarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AzqaarPageContent();
  }
}

class AzqaarPageContent extends StatefulWidget {
  const AzqaarPageContent({super.key});

  @override
  _AzqaarPageState createState() => _AzqaarPageState();
}

class _AzqaarPageState extends State<AzqaarPageContent> {
  Map<String, List<Azqaar>> azqaarMap = {};
  Map<String, int> countMap = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final String assetData = await DefaultAssetBundle.of(context)
        .loadString('assets/jsons/azkar.json');
    final List<dynamic> jsonData = json.decode(assetData);

    setState(() {
      jsonData.forEach((data) {
        Azqaar azqaar = Azqaar(
          category: data['category'],
          count: data['count'],
          description: data['description'],
          reference: data['reference'],
          zekr: data['zekr'],
        );
        if (azqaarMap.containsKey(azqaar.category)) {
          azqaarMap[azqaar.category]!.add(azqaar);
        } else {
          azqaarMap[azqaar.category] = [azqaar];
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الأذكار',
          textAlign: TextAlign.end,
        ),
      ),
      body: azqaarMap.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: azqaarMap.keys.length,
              itemBuilder: (context, index) {
                String category = azqaarMap.keys.elementAt(index);
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    collapsedShape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    expansionAnimationStyle: AnimationStyle(
                      duration: const Duration(milliseconds: 400),
                    ),
                    leading: const Icon(Icons.keyboard_arrow_down_sharp),
                    title: const Text(''),
                    trailing: Text(
                      category,
                      style: const TextStyle(fontSize: 18),
                    ),
                    children: azqaarMap[category]!
                        .map((azqaar) => Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    azqaar.zekr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                  subtitle: Text(
                                    azqaar.description,
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                                _buildCounterButton(azqaar),
                                const Divider(color: Colors.grey), // Add a divider
                              ],
                            ))
                        .toList(),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildCounterButton(Azqaar azqaar) {
    if (azqaar.count.isEmpty) {
      return Container(); // Return an empty container if count is null or empty
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          heroTag: 'button${azqaar.zekr}', // Unique tag for each button
          onPressed: () {
            if ((countMap[azqaar.zekr] ?? 0) < int.parse(azqaar.count)) {
              setState(() {
                countMap[azqaar.zekr] = (countMap[azqaar.zekr] ?? 0) + 1;
              });
            }
          },
          child: Text('${countMap[azqaar.zekr] ?? 0}/${azqaar.count}'),
        ),
      ],
    );
  }

  // void _showAzqaarContent(Azqaar azqaar) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(azqaar.category),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('Count: ${azqaar.count}'),
  //               Text('Description: ${azqaar.description}'),
  //               Text('Reference: ${azqaar.reference}'),
  //               Text(
  //                 'Zekr: ${azqaar.zekr}',
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Close'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
