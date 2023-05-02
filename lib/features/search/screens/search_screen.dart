import 'package:event_updates_tif/common/widgets/loader.dart';
import 'package:event_updates_tif/constants/global_variables.dart';
import 'package:event_updates_tif/features/event_details/screens/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';

  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Map mapResponse;
  List? listResponse;

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse(
        'https://sde-007.api.assignment.theinternetfolks.works/v1/event'));

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

  void navigateToSearchScreen(String query) async {
    if (query.isEmpty) {
      setState(() {
        listResponse = mapResponse['content']['data'];
      });
    } else {
      final filteredList = mapResponse['content']['data']
          .where((event) => event['title']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      setState(() {
        listResponse = filteredList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 42,
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            alignment: Alignment.topCenter,
            child: Material(
              child: Row(
                children: [
                  Container(
                    color: GlobalVariables.backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.search,
                          color: GlobalVariables.secondaryColor,
                          size: 31,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 32,
                    width: 1,
                    color: GlobalVariables.secondaryColor,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: navigateToSearchScreen,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: GlobalVariables.backgroundColor,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 5,
                        ),
                        hintText: 'Type Event Name',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: GlobalVariables.hintColor),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: listResponse == null
                ? const Loader()
                : ListView.builder(
                    itemCount: listResponse == null ? 0 : listResponse!.length,
                    itemBuilder: (context, index) {
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
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    listResponse![index]['organiser_icon']
                                            .endsWith('.svg')
                                        ? 'https://www.docker.com/wp-content/uploads/2022/03/vertical-logo-monochromatic.png'
                                        : listResponse![index]
                                            ['organiser_icon'],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 235,
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Text(
                                            DateFormat('d MMM - EEE - h:mm a ')
                                                .format(
                                              DateTime.parse(
                                                listResponse![index]
                                                    ['date_time'],
                                              ),
                                            ),
                                            style: const TextStyle(
                                              color: GlobalVariables
                                                  .secondaryColor,
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
                                            listResponse![index]['title']
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 1,
                                        ),
                                        Container(
                                          width: 235,
                                          padding: const EdgeInsets.only(
                                            left: 7,
                                          ),
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 5.0),
                                                child: Icon(
                                                  Icons.location_on,
                                                  size: 18,
                                                  color:
                                                      GlobalVariables.hintColor,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${listResponse![index]['venue_name'].toString()} • ${listResponse![index]['venue_city']}, ${listResponse![index]['venue_country']}',
                                                  style: const TextStyle(
                                                    color: GlobalVariables
                                                        .hintColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
          ),
        ],
      ),
    );
  }
}
