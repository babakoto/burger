part of '../cart_page.dart';

class CartCard extends StatelessWidget {
  final VoidCallback onDismissed;
  final Order order;
  const CartCard({
    Key? key,
    required this.onDismissed,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: onDismissed),
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: AppThemes.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppThemes.cardColor,
          ),
          child: Row(children: [
            Expanded(
              child: CircleAvatar(
                radius: 30,
                backgroundColor: AppThemes.cardColor,
                child: FadeInImage(
                  placeholder: const AssetImage(
                    Assets.imagesBurger2,
                  ),
                  imageErrorBuilder: (context, _, __) {
                    return const Image(
                      fit: BoxFit.fill,
                      width: 150,
                      height: 180,
                      image: AssetImage(
                        Assets.imagesBurger2,
                      ),
                    );
                  },
                  image: NetworkImage(
                    "${order.burger.thumbnail}",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${order.burger.title}",
                    style: textTheme.headline6,
                  ),
                  Expanded(
                    child: Text(
                      "${order.burger.description}",
                      style: textTheme.bodyText1?.copyWith(color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          QuantityCounter(
                            onChanged: (value) {
                              context.read<UserBloc>().add(
                                    OnUpdateOrder(
                                      order: order,
                                      quantity: value,
                                    ),
                                  );
                            },
                            initValue: order.quantity,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Text(
                              "${order.total.toEuro()}€",
                              style: textTheme.headline1!.copyWith(
                                color: AppThemes.backgroundColor,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
