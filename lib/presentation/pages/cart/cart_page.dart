import 'package:burger/presentation/exports.dart';
import 'package:flutter/material.dart';

part './widgets/cart_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  _onDismissed(Order order) {
    context.read<UserBloc>().add(
          OnRemoveOrder(
            order: order,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                        return CartCard(
                          onDismissed: () {
                            _onDismissed(state.orders[index]);
                          },
                          order: state.orders[index],
                        );
                      }),
                ),
                Expanded(
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      return Visibility(
                        visible: state.total > 0,
                        child: Row(
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
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
