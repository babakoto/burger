import 'package:burger/core/assets/assets.dart';
import 'package:burger/core/extensions/double_extension.dart';
import 'package:burger/domain/entities/order.dart';
import 'package:burger/presentation/blocs/user/user_bloc.dart';
import 'package:burger/presentation/components/quantity_counter.dart';
import 'package:burger/presentation/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        print(
                            "<<< Quantity >>>>>>>>${state.orders[index].quantity}");
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Slidable(
                            key: UniqueKey(),
                            // The start action pane is the one at the left or the top side.
                            startActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              dismissible: DismissiblePane(onDismissed: () {
                                context.read<UserBloc>().add(
                                      OnRemoveOrder(
                                        order: state.orders[index],
                                      ),
                                    );
                              }),

                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: (context) {
                                    context.read<UserBloc>().add(
                                          OnRemoveOrder(
                                            order: state.orders[index],
                                          ),
                                        );
                                  },
                                  backgroundColor: Color(0xFFFE4A49),
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
                                    child: FadeInImage(
                                      placeholder: const AssetImage(
                                        Assets.imagesBurger2,
                                      ),
                                      image: NetworkImage(
                                        "${state.orders[index].burger.thumbnail}",
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${state.orders[index].burger.title}",
                                        style: textTheme.headline6,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${state.orders[index].burger.description}",
                                          style: textTheme.bodyText1
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              QuantityCounter(
                                                onChanged: (value) {
                                                  Order order =
                                                      state.orders[index];
                                                  context.read<UserBloc>().add(
                                                        OnUpdateOrder(
                                                          order: order,
                                                          quantity: value,
                                                        ),
                                                      );
                                                },
                                                initValue: state
                                                    .orders[index].quantity,
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${state.orders[index].total.toEuro()}€",
                                                  style: textTheme.headline1!
                                                      .copyWith(
                                                    color: AppThemes
                                                        .backgroundColor,
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
                      }),
                ),
                Expanded(child:
                    BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: QrImage(
                              data: """ 
                              {
                                "total":${state.total},
                              }
                              """,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "Total: ${state.total.toEuro()}€",
                                style: textTheme.headline1,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }))
              ],
            ),
          );
        },
      ),
    );
  }
}
