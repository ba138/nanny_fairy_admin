import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nanny_fairy_admin/Res/Components/Responsive.dart';
import 'package:nanny_fairy_admin/Res/Components/colors.dart';
import 'package:nanny_fairy_admin/Res/Components/header.dart';
import 'package:nanny_fairy_admin/Res/Components/keys.dart';
import 'package:nanny_fairy_admin/Res/Components/side_menu.dart';
import 'package:nanny_fairy_admin/Res/Components/user_detail_field.dart';

class ProviderCommunityScreen extends StatefulWidget {
  const ProviderCommunityScreen({super.key});

  @override
  State<ProviderCommunityScreen> createState() =>
      _ProviderCommunityScreenState();
}

class _ProviderCommunityScreenState extends State<ProviderCommunityScreen> {
  String searchTerm = '';
  String selectedCategory = 'All'; // Default to show all users
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      searchTerm = _searchController.text;
    });
  }

  Stream<DatabaseEvent> _getUserStream() {
    DatabaseReference usersRef =
        FirebaseDatabase.instance.ref().child('ProviderCommunityPosts');

    if (_searchController.text.isNotEmpty) {
      return usersRef
          .orderByChild('providerName')
          .equalTo(_searchController.text.trim())
          .onValue;
    } else {
      return usersRef.onValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getAddProductscaffoldKey,
      // key: context.read<MenuController>().getScaffoldKey,
      // drawer: const SideMenu(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 64,
              child: Header(fct: () {}),
            ),
            const SizedBox(height: 12.0),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // We want this side menu only for large screen
                  if (Responsive.isDesktop(context))
                    const SizedBox(
                      width: 250, // Set the width of the side menu
                      child: SideMenu(),
                    ),
                  Expanded(
                      flex: 5,
                      // It takes the remaining part of the screen
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, right: 16),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                //     ? 650
                                //     : MediaQuery.of(context).size.width,
                                color: AppColor.whiteColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Providers community",
                                        style: GoogleFonts.getFont(
                                          "Poppins",
                                          textStyle: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.blackColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 38,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                  color: AppColor.borderColor,
                                                  width:
                                                      1.0, // Adjust the width as needed
                                                ),
                                                top: BorderSide(
                                                  color: AppColor.borderColor,
                                                  width:
                                                      1.0, // Adjust the width as needed
                                                ),
                                                bottom: BorderSide(
                                                  color: AppColor.borderColor,
                                                  width:
                                                      1.0, // Adjust the width as needed
                                                ),
                                                // No border on the right side
                                                right: BorderSide.none,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomLeft: Radius.circular(8),
                                              ),
                                            ),
                                            child: TextField(
                                              controller: _searchController,
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                hintText: 'Search here',
                                                hintStyle: TextStyle(
                                                    color: Colors.black),
                                                border: InputBorder.none,
                                                prefixIcon: Icon(Icons.search,
                                                    color: Colors.black),
                                              ),
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              searchTerm =
                                                  _searchController.text;
                                            },
                                            child: Container(
                                              height: 38,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  13,
                                              decoration: const BoxDecoration(
                                                color: AppColor.primaryColor,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Search",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: StreamBuilder(
                                            stream:
                                                _getUserStream(), // Stream fetching data from Firebase
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              }

                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }

                                              final data =
                                                  snapshot.data!.snapshot.value
                                                      as Map<dynamic, dynamic>?;

                                              if (data == null ||
                                                  data.isEmpty) {
                                                return const Center(
                                                    child:
                                                        Text('No posts found'));
                                              }

                                              // Convert the data to a list for easy iteration in the ListView
                                              final posts =
                                                  data.values.toList();

                                              return SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                child: ListView.builder(
                                                  itemCount: posts
                                                      .length, // Number of posts
                                                  itemBuilder:
                                                      (context, index) {
                                                    final post = posts[index];
                                                    final Map<dynamic, dynamic>
                                                        commentsMap =
                                                        post['comments'] != null
                                                            ? post['comments']
                                                                as Map<dynamic,
                                                                    dynamic>
                                                            : {};
                                                    return Container(
                                                      width: 400,
                                                      color: Colors.transparent,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundColor:
                                                                      AppColor
                                                                          .primaryColor,
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          post[
                                                                              'providerProfile']),
                                                                ),
                                                                const SizedBox(
                                                                    width: 12),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      post[
                                                                          'providerName'],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      DateFormat(
                                                                              'yyyy-MM-dd – kk:mm')
                                                                          .format(
                                                                        DateTime.parse(post['timePost'])
                                                                            .toLocal(),
                                                                      ), // Custom date format
                                                                      style:
                                                                          const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            Container(
                                                              width: 400,
                                                              color: Colors
                                                                  .transparent,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        post[
                                                                            'title'],
                                                                        style:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      post['status'] ==
                                                                              false
                                                                          ? const Text(
                                                                              "(UnVerified)",
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w400,
                                                                                color: Colors.grey,
                                                                              ),
                                                                            )
                                                                          : const Text(
                                                                              "(Verified)",
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w400,
                                                                                color: AppColor.primaryColor,
                                                                              ),
                                                                            )
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          8),
                                                                  Text(
                                                                    post[
                                                                        'content'],
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Card(
                                                                child:
                                                                    Container(
                                                                  height: 400,
                                                                  width: 400,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        post[
                                                                            'post'],
                                                                      ),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Icon(Icons
                                                                    .comment_outlined),
                                                                Text(
                                                                  commentsMap
                                                                      .length
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 30,
                                                                ),
                                                                post['status'] ==
                                                                        false
                                                                    ? ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          if (post['status'] ==
                                                                              true) {
                                                                            Fluttertoast.showToast(msg: "post already verified");
                                                                          } else {
                                                                            FirebaseDatabase.instance.ref().child("ProviderCommunityPosts").child(post['postId']).update({
                                                                              "status": true
                                                                            });
                                                                            Fluttertoast.showToast(msg: "post is verified");
                                                                          }
                                                                        },
                                                                        child: const Text(
                                                                            "Approve"))
                                                                    : SizedBox()
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
