// ignore_for_file: use_build_context_synchronously

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanny_fairy_admin/Res/Components/Responsive.dart';
import 'package:nanny_fairy_admin/Res/Components/colors.dart';
import 'package:nanny_fairy_admin/Res/Components/header.dart';
import 'package:nanny_fairy_admin/Res/Components/keys.dart';
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

class ProvidersScreen extends StatefulWidget {
  const ProvidersScreen({super.key});

  @override
  State<ProvidersScreen> createState() => _ProvidersScreenState();
}

class _ProvidersScreenState extends State<ProvidersScreen> {
  String? _btn2SelectedVal;

  static const menuItems = <String>[
    "All",
    'Subscribed',
  ];

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
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
        FirebaseDatabase.instance.ref().child('Providers');

    if (_searchController.text.isNotEmpty) {
      // Search users by first name
      return usersRef
          .orderByChild('firstName')
          .equalTo(_searchController.text.trim())
          .onValue;
    } else if (_btn2SelectedVal == 'Subscribed') {
      // Query users with paymentInfo.status == 'completed'
      return usersRef
          .orderByChild('paymentInfo/status')
          .equalTo('completed')
          .onValue;
    } else {
      // Return all users if no filters are applied
      return usersRef.onValue;
    }
  }

// Filter users manually by payment status if needed
  List _filterUsersByStatus(Map<dynamic, dynamic>? users, String status) {
    if (users == null) return [];

    return users.entries
        .where((entry) {
          final paymentInfo = entry.value['paymentInfo'];
          return paymentInfo != null && paymentInfo['status'] == status;
        })
        .map((entry) => entry.value)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getFinanceScaffoldKey,
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
                                        "Providers",
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
                                        height: 16,
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
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Container(
                                            height: 38,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  8.0), // Adjust border radius as needed
                                              border: Border.all(
                                                color: Colors
                                                    .grey, // Specify border color
                                                width:
                                                    1.0, // Specify border width
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8,
                                              ),
                                              child: DropdownButton(
                                                underline: const SizedBox(),
                                                isExpanded: true,
                                                value: _btn2SelectedVal,
                                                hint: const Text('All'),
                                                onChanged: (String? newValue) {
                                                  setState(() =>
                                                      _btn2SelectedVal =
                                                          newValue);
                                                },
                                                items: _dropDownMenuItems,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 38,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: const Color(0xffF8F8F8),
                                        child: const Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  'No',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Center(
                                                child: Text(
                                                  'Name',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text(
                                                  'Gmail',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Center(
                                                child: Text(
                                                  'Phone Number',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Center(
                                                child: Text(
                                                  'Date of Birth',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  'Status',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  'Phone Number',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      StreamBuilder(
                                        stream:
                                            _getUserStream(), // Correctly invoke the function to get the stream
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}'); // Handle errors
                                          }

                                          if (!snapshot.hasData ||
                                              !snapshot.data!.snapshot.exists) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator()); // Show loading indicator
                                          }

                                          final data = snapshot.data!.snapshot
                                              .value as Map<dynamic, dynamic>?;

                                          if (data == null || data.isEmpty) {
                                            return const Center(
                                                child: Text(
                                                    'No User details found')); // Handle no data scenario
                                          }

                                          // Apply filtering based on the status
                                          List<Map<dynamic, dynamic>>
                                              filteredUsers;
                                          if (_btn2SelectedVal != 'All' &&
                                              _btn2SelectedVal != null) {
                                            filteredUsers =
                                                _filterUsersByStatus(
                                                        data, 'completed')
                                                    .cast<
                                                        Map<dynamic, dynamic>>()
                                                    .toList();
                                          } else {
                                            filteredUsers = data.values
                                                .cast<Map<dynamic, dynamic>>()
                                                .toList();
                                          }

                                          if (filteredUsers.isEmpty) {
                                            return const Center(
                                                child: Text('No users found'));
                                          }

                                          return ListView.separated(
                                            shrinkWrap: true,
                                            itemCount: filteredUsers.length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(height: 12),
                                            itemBuilder: (context, index) {
                                              final bankDetails =
                                                  filteredUsers[index];

                                              final String name = (bankDetails[
                                                          'firstName'] ??
                                                      '') +
                                                  ' ' +
                                                  (bankDetails['lastName'] ??
                                                      '');
                                              final String email =
                                                  bankDetails['email'] ?? 'N/A';
                                              final String phoneNumber =
                                                  bankDetails['phoneNumber'] ??
                                                      'N/A';
                                              final String formattedDate =
                                                  bankDetails['dob'] ?? 'N/A';
                                              final String uid =
                                                  bankDetails['uid'] ?? 'N/A';
                                              final String dob =
                                                  bankDetails['dob'] ?? 'N/A';
                                              final String address =
                                                  bankDetails['address'] ??
                                                      'N/A';
                                              final String profile =
                                                  bankDetails['profile'] ??
                                                      'N/A';
                                              final String idFront =
                                                  bankDetails['IdPics']
                                                          ?['frontPic'] ??
                                                      'N/A';
                                              final String idBack =
                                                  bankDetails['IdPics']
                                                          ?['backPic'] ??
                                                      'N/A';
                                              final String postCode =
                                                  bankDetails['postCode'] ??
                                                      'N/A';
                                              final String houseNumber =
                                                  bankDetails['houseNumber'] ??
                                                      'N/A';
                                              final List familyPassion =
                                                  bankDetails['Passions'] ?? [];

                                              return Container(
                                                height: 38,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.grey[300]!),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Center(
                                                          child: Text(
                                                              (index + 1)
                                                                  .toString())),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Center(
                                                          child: Text(name)),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Center(
                                                          child: Text(email)),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Center(
                                                          child: Text(
                                                              phoneNumber)),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Center(
                                                          child: Text(
                                                              formattedDate)),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: InkWell(
                                                        onTap: () {
                                                          // showCustomDialog(
                                                          //   context,
                                                          //   name,
                                                          //   email,
                                                          //   uid,
                                                          //   phoneNumber,
                                                          //   dob,
                                                          //   address,
                                                          //   profile,
                                                          //   idFront,
                                                          //   idBack,
                                                          //   postCode,
                                                          //   houseNumber,
                                                          //   familyPassion,
                                                          // );
                                                        },
                                                        child: Container(
                                                          height: 28,
                                                          width: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColor
                                                                .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "Verified",
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                "Poppins",
                                                                textStyle:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColor
                                                                      .whiteColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: InkWell(
                                                        onTap: () {
                                                          showCustomDialog(
                                                            context,
                                                            name,
                                                            email,
                                                            uid,
                                                            phoneNumber,
                                                            dob,
                                                            address,
                                                            profile,
                                                            idFront,
                                                            idBack,
                                                            postCode,
                                                            houseNumber,
                                                            familyPassion,
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 28,
                                                          width: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColor
                                                                .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "View",
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                "Poppins",
                                                                textStyle:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColor
                                                                      .whiteColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
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

  void showCustomDialog(
    BuildContext context,
    String name,
    String email,
    String uid,
    String phoneNumber,
    String dob,
    String address,
    String profile,
    String idFront,
    String idBack,
    String postCode,
    String houseNumber,
    List familyPassion,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xffF8F8F8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2.8,
            height: MediaQuery.of(context).size.height / 1.5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Providers Details',
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textColor1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(profile),
                        radius: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UserDetailField(
                          title: "Full Name",
                          data: name,
                        ),
                        UserDetailField(
                          title: "Email",
                          data: email,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UserDetailField(
                          title: "Phone Number",
                          data: phoneNumber,
                        ),
                        UserDetailField(
                          title: "Date of Birth",
                          data: dob,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UserDetailField(
                          title: "Address",
                          data: address,
                        ),
                        UserDetailField(
                          title: "UserId",
                          data: uid,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UserDetailField(
                          title: "Post code",
                          data: postCode,
                        ),
                        UserDetailField(
                          title: "House Number",
                          data: houseNumber,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Family Passions",
                          style: GoogleFonts.getFont(
                            "Poppins",
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColor.textColor1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: familyPassion.map((passion) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    right:
                                        8.0), // Add spacing between containers
                                child: Container(
                                  color: AppColor.primaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      passion,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Id Front Pic",
                          style: GoogleFonts.getFont(
                            "Poppins",
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColor.textColor1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(idFront),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Id Back Pic",
                          style: GoogleFonts.getFont(
                            "Poppins",
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColor.textColor1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(idFront),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
