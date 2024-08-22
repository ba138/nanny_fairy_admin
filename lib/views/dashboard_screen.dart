import 'package:flutter/material.dart';
import 'package:nanny_fairy_admin/Res/Components/colors.dart';
import 'package:nanny_fairy_admin/Res/Components/dashboard_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _totalUserCount = 0;
  int _blockedUserCount = 0;
  double _totalFunds = 0.0;
  double _totalwithdraw = 0.0;

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchData();
  // }

  // Future<void> _fetchData() async {
  //   try {
  //     QuerySnapshot totalUsersSnapshot =
  //         await FirebaseFirestore.instance.collection('users').get();
  //     QuerySnapshot blockedUsersSnapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .where('isBlock', isEqualTo: true)
  //         .get();

  //     double totalFunds = 0.0;
  //     double totalWithdraw = 0.0; // Changed variable name to camelCase
  //     for (var doc in totalUsersSnapshot.docs) {
  //       // Ensure the balance and withdrawalAmount are treated as numbers
  //       totalFunds += (doc['balance'] as num).toDouble();

  //       // Check if the user has a withdrawalAmount field and add it to totalWithdraw
  //       var userData = doc.data() as Map<String, dynamic>?; // Explicit cast
  //       if (userData != null && userData.containsKey('withdrawamount')) {
  //         totalWithdraw += (userData['withdrawamount'] as num).toDouble();
  //       }
  //     }

  //     setState(() {
  //       _totalUserCount = totalUsersSnapshot.docs.length;
  //       _blockedUserCount = blockedUsersSnapshot.docs.length;
  //       _totalFunds = totalFunds;
  //       _totalwithdraw = totalWithdraw;
  //     });
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    String addEllipsis(String text, int maxLength) {
      if (text.length <= maxLength) {
        return text;
      } else {
        return '${text.substring(0, maxLength)}...';
      }
    }

    return SafeArea(
        child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 232,
        color: AppColor.whiteColor,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DashboardWidget(
                  icon: Icons.people_outline_outlined,
                  iconColor: AppColor.textColor1,
                  title: _totalUserCount.toString(),
                  subtitle: 'Total Familys'),
              DashboardWidget(
                  icon: Icons.people_outline_outlined,
                  iconColor: AppColor.textColor1,
                  title: _blockedUserCount.toString(),
                  subtitle: 'Total Providers'),
              DashboardWidget(
                  icon: Icons.payment_outlined,
                  iconColor: AppColor.primaryColor,
                  title: addEllipsis(
                    "0",
                    6, // Maximum length before adding ellipsis
                  ),
                  subtitle: 'Sub Familys'),
              DashboardWidget(
                  icon: Icons.payment_outlined,
                  iconColor: AppColor.primaryColor,
                  title: addEllipsis(
                    "0",
                    6, // Maximum length before adding ellipsis
                  ),
                  subtitle: 'Sub Providers'),
            ],
          ),
        ),
      ),
    ));
  }
}
