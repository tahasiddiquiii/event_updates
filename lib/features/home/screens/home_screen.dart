import 'dart:convert';
import 'dart:developer';
import 'package:event_updates_tif/common/widgets/loader.dart';
import 'package:event_updates_tif/constants/global_variables.dart';
import 'package:event_updates_tif/features/event_details/screens/event_details_screen.dart';
import 'package:event_updates_tif/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map mapResponse;
  List? listResponse;

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse(
        'https://sde-007.api.assignment.theinternetfolks.works/v1/event'));

    if (response.statusCode == 200) {
      log('home response: $response');

      setState(() {
        mapResponse = jsonDecode(response.body);
        listResponse = mapResponse['content']['data'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Events',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                ),
                Row(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.search),
                    ),
                  ),
                  const Icon(Icons.more_vert),
                ])
              ],
            ),
          ),
        ),
      ),
      body: listResponse == null
          ? const Loader()
          : ListView.builder(
              itemCount: listResponse == null ? 0 : listResponse!.length,
              itemBuilder: (context, index) {
                // String formattedDate = dateFormatter.format(eventTimes![index]);
                // String formattedTime = timeFormatter.format(eventTimes![index]);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailScreen(
                          id: listResponse![index]['id'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    height: 106,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: GlobalVariables.backgroundColor,
                      boxShadow: const [
                        BoxShadow(
                          color: GlobalVariables.shadowcolorColor,
                          spreadRadius: 10,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              listResponse![index]['organiser_icon']
                                      .endsWith('.svg')
                                  ? 'https://www.docker.com/wp-content/uploads/2022/03/vertical-logo-monochromatic.png'
                                  : listResponse![index]['organiser_icon'],
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 235,
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      DateFormat('EEE, MMM d • h:mm a').format(
                                        DateTime.parse(
                                          listResponse![index]['date_time'],
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: GlobalVariables.secondaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    width: 235,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 7,
                                    ),
                                    child: Text(
                                      listResponse![index]['title'].toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  Container(
                                    width: 235,
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: Icon(
                                            Icons.location_on,
                                            size: 18,
                                            color: GlobalVariables.hintColor,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${listResponse![index]['venue_name'].toString()} • ${listResponse![index]['venue_city']}, ${listResponse![index]['venue_country']}',
                                            style: const TextStyle(
                                              color: GlobalVariables.hintColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
