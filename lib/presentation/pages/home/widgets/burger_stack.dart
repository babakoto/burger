part of "../home_page.dart";

class BurgerStack extends StatelessWidget {
  final Burger burger;
  const BurgerStack({
    Key? key,
    required this.burger,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: size.height * .2,
            width: size.width * .8,
            decoration: BoxDecoration(
              color: AppThemes.cardColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                const SizedBox(width: 120),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${burger.title}",
                        textAlign: TextAlign.center,
                        style: textTheme.headline2,
                      ),
                      Text(
                        "${burger.price}€",
                        style: textTheme.headline2?.copyWith(
                          color: const Color(0xff5E2C2F),
                          shadows: AppThemes.textShadow,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: size.height * .2,
            width: size.width * .5,
            child: Transform.rotate(
              angle: -12 * pi / 180,
              child: FadeInImage(
                placeholder: const AssetImage(Assets.imagesBurger2),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    Assets.imagesBurger1,
                    fit: BoxFit.fitWidth,
                  );
                },
                image: NetworkImage("${burger.thumbnail}"),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: SizedBox(
            height: 45,
            width: 45,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                foregroundColor: AppThemes.red,
                backgroundColor: AppThemes.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
