import 'package:badges/badges.dart';
import 'package:burger/presentation/themes/app_themes.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String photo;
  final String name;

  const CustomAppBar({
    Key? key,
    required this.name,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 68,
                width: 68,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(photo),
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(
                width: 14,
              ),
              Text(
                "Mr.\n$name",
                style: textTheme.headline6,
              )
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Badge(
              position: const BadgePosition(start: 18, top: 0),
              badgeColor: AppThemes.red,
              child: const Icon(Icons.notifications),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
