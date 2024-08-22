import 'package:flutter/material.dart';
import 'package:nanny_fairy_admin/Res/Components/Responsive.dart';
import 'package:nanny_fairy_admin/Res/Components/header.dart';
import 'package:nanny_fairy_admin/Res/Components/keys.dart';
import 'package:nanny_fairy_admin/Res/Components/side_menu.dart';
import 'package:nanny_fairy_admin/views/dashBoard_Screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getScaffoldKey,
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
                  if (Responsive.isDesktop(context))
                    const SizedBox(
                      width: 250,
                      child: SideMenu(),
                    ),
                  const Expanded(
                    // It takes the remaining part of the screen
                    child: DashboardScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
