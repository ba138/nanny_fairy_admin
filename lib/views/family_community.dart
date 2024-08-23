// ignore_for_file: use_build_context_synchronously

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanny_fairy_admin/Res/Components/Responsive.dart';
import 'package:nanny_fairy_admin/Res/Components/colors.dart';
import 'package:nanny_fairy_admin/Res/Components/header.dart';
import 'package:nanny_fairy_admin/Res/Components/keys.dart';
import 'package:nanny_fairy_admin/Res/Components/post_widget.dart';
import 'package:nanny_fairy_admin/Res/Components/side_menu.dart';
import 'package:nanny_fairy_admin/Res/Components/user_detail_field.dart';
// import 'package:wallet_admin/Utils/utils.dart';
// import 'package:wallet_admin/res/components/colors.dart';
// import 'package:wallet_admin/res/components/header.dart';
// import 'package:wallet_admin/res/keys.dart';
// import 'package:wallet_admin/res/responsive.dart';
// import 'package:wallet_admin/view/slide_menu.dart';
// import 'package:wallet_admin/view/widgets/user_detai_field.dart';
// import 'package:intl/intl.dart';

class FamilyCommunityScreen extends StatefulWidget {
  const FamilyCommunityScreen({super.key});

  @override
  State<FamilyCommunityScreen> createState() => _FamilyCommunityScreenState();
}

class _FamilyCommunityScreenState extends State<FamilyCommunityScreen> {
  // String? _btn2SelectedVal;

  // static const menuItems = <String>[
  //   "All",
  //   'Subscribed',
  // ];

  // final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
  //     .map(
  //       (String value) => DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
  //       ),
  //     )
  //     .toList();
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
        FirebaseDatabase.instance.ref().child('Family');

    if (_searchController.text.isNotEmpty) {
      return usersRef
          .orderByChild('name')
          .equalTo(_searchController.text)
          .onValue; // Query users by name if searchController is not empty
    } else {
      return usersRef.onValue; // Get all users if searchController is empty
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
                                        "Familys community",
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
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: ListView.builder(
                                          itemCount:
                                              10, // Set the number of times you want to repeat the container
                                          itemBuilder: (context, index) {
                                            return Container(
                                              width: 400,
                                              color: Colors.transparent,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              AppColor
                                                                  .primaryColor,
                                                        ),
                                                        SizedBox(
                                                          width: 12,
                                                        ),
                                                        Text(
                                                          'Name',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      width: 400,
                                                      color: Colors.transparent,
                                                      child: const Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Title',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Text(
                                                            'I am Basit, a cross-platform developer for Flutter, developing many apps like Emos, RJ Fruits, Citta, Emos, K Cabs, K Driver, and many more.',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Container(
                                                        height: 400,
                                                        width: 400,
                                                        decoration:
                                                            const BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                              "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                                                            ),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
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
