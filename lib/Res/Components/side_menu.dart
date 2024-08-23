import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanny_fairy_admin/Res/Components/colors.dart';
import 'package:nanny_fairy_admin/views/Family_community.dart';
import 'package:nanny_fairy_admin/views/family_screen.dart';
import 'package:nanny_fairy_admin/views/main_Screen.dart';
import 'package:nanny_fairy_admin/views/provider_community.dart';
import 'package:nanny_fairy_admin/views/providers_screen.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    super.key,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: ListView(
        children: [
          DrawerListTile(
            title: "Dashboard",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            },
            icon: Icons.home_outlined,
          ),
          DrawerListTile(
            title: "Familys",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const FamilyScreen(),
                ),
              );
            },
            icon: Icons.group_outlined,
          ),
          DrawerListTile(
            title: "Providers",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ProvidersScreen(),
                ),
              );
            },
            icon: Icons.person_2_outlined,
          ),
          DrawerListTile(
            title: "Familys Community",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const FamilyCommunityScreen(),
                ),
              );
            },
            icon: Icons.data_exploration_outlined,
          ),
          DrawerListTile(
            title: "Providers Community",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ProviderCommunityScreen(),
                ),
              );
            },
            icon: Icons.data_exploration_outlined,
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {super.key,
      // For selecting those three line once press "Command+D"
      required this.title,
      required this.press,
      this.imageIcon,
      this.icon});

  final String title;
  final VoidCallback press;
  final String? imageIcon;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: imageIcon != null
          ? ImageIcon(
              AssetImage(
                imageIcon!,
              ),
              color: AppColor.textColor2,
              size: 20,
            )
          : Icon(
              icon,
              color: AppColor.textColor2,
              size: 20,
            ),
      minLeadingWidth: 40,
      title: Text(
        title,
        style: GoogleFonts.getFont(
          "Poppins",
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.textColor2,
          ),
        ),
      ),
    );
  }
}
