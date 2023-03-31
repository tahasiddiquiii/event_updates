import 'dart:convert';
import 'package:event_updates_tif/common/widgets/custom_button.dart';
import 'package:event_updates_tif/common/widgets/loader.dart';
import 'package:event_updates_tif/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EventDetailScreen extends StatefulWidget {
  static const String routeName = '/event-details';

  EventDetailScreen({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  late Map mapResponse;
  // ignore: prefer_typing_uninitialized_variables
  var listResponse;

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse(
        'https://sde-007.api.assignment.theinternetfolks.works/v1/event/${widget.id}'));

    if (response.statusCode == 200) {
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
    return listResponse == null
        ? const Loader()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(180),
              child: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: GlobalVariables.backgroundColor,
                    size: 30,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('${listResponse['banner_image']}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Event Details',
                        style: TextStyle(
                          color: GlobalVariables.backgroundColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: GlobalVariables.greyBackgroundCOlor
                            .withOpacity(0.3),
                      ),
                      height: 45,
                      width: 45,
                      child: const Icon(
                        Icons.bookmark,
                        color: GlobalVariables.backgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 24, right: 38, top: 21, bottom: 21),
                    child: Text(
                      listResponse['title'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: GlobalVariables.backgroundColor,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset('assets/images/tif.png'),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 235,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 7,
                                ),
                                child: Text(
                                  listResponse['organiser_name'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                width: 235,
                                padding:
                                    const EdgeInsets.only(left: 10, top: 1),
                                child: const Text(
                                  'Organizer',
                                  style: TextStyle(
                                    color: GlobalVariables.subHeadingColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: GlobalVariables.backgroundColor,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: GlobalVariables.secondaryColor
                                  .withOpacity(0.08),
                            ),
                            height: 55,
                            width: 55,
                            child: const Icon(
                              Icons.calendar_today_rounded,
                              color: GlobalVariables.secondaryColor,
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 235,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 7,
                                ),
                                child: Text(
                                  listResponse['date_time'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                width: 235,
                                padding:
                                    const EdgeInsets.only(left: 10, top: 1),
                                child: Text(
                                  listResponse['date_time'],
                                  style: const TextStyle(
                                    color: GlobalVariables.subHeadingColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: GlobalVariables.backgroundColor,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: GlobalVariables.secondaryColor
                                  .withOpacity(0.08),
                            ),
                            height: 55,
                            width: 55,
                            child: const Icon(
                              Icons.location_on_rounded,
                              color: GlobalVariables.secondaryColor,
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 235,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 7,
                                ),
                                child: Text(
                                  listResponse['venue_name'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                width: 235,
                                padding:
                                    const EdgeInsets.only(left: 10, top: 1),
                                child: Text(
                                  '${listResponse['venue_city']}, ${listResponse['venue_country']}',
                                  style: const TextStyle(
                                    color: GlobalVariables.subHeadingColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 34, right: 38, top: 35, bottom: 21),
                    child: const Text(
                      'About Event',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 34, right: 38, top: 1, bottom: 21),
                    child: Text(
                      listResponse['description'],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      // maxLines: 5,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: CustomButton(
                      text: 'Book Now',
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
  }
}
