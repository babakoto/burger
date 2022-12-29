import 'dart:math';

import 'package:burger/core/assets/assets.dart';
import 'package:burger/core/constants/fake_data.dart';
import 'package:burger/core/extensions/double_extension.dart';
import 'package:burger/presentation/blocs/burger/burger_bloc.dart';
import 'package:burger/presentation/blocs/order/order_bloc.dart';
import 'package:burger/presentation/blocs/user/user_bloc.dart';
import 'package:burger/presentation/components/quantity_counter.dart';
import 'package:burger/presentation/cubits/navigation_cubit.dart';
import 'package:burger/presentation/pages/detail/widgets/confirm_order.dart';
import 'package:burger/presentation/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_text/styled_text.dart';

class DetailPage extends StatefulWidget {
  static const path = "/detail";
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
  }

  _onAddOrder() {
    final order = context.read<OrderBloc>().state.order;
    context.read<UserBloc>().add(OnAddOrder(order: order!));
    Navigator.pop(context);
    context.read<NavigationCubit>().onChanged(1);
  }

  _onChangedQuantity(int value) {
    final selected = context.read<BurgerBloc>().state.selected;
    context.read<OrderBloc>().add(
          OnCreateOrder(
            burger: selected!,
            quantity: value,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              BlocBuilder<BurgerBloc, BurgerState>(
                builder: (context, state) {
                  return SizedBox(
                    height: size.height * .2,
                    width: double.maxFinite,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(Assets.imagesEllipse),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 150,
                            width: 200,
                            child: Transform.rotate(
                              angle: -12 * pi / 180,
                              child: FadeInImage(
                                placeholder:
                                    const AssetImage(Assets.imagesBurger2),
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    Assets.imagesBurger1,
                                    fit: BoxFit.fitWidth,
                                  );
                                },
                                image: NetworkImage(
                                  "${state.selected?.thumbnail}",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Toping", style: textTheme.headline6)),
              Expanded(
                flex: 2,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topings.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Ink(
                                  height: 86,
                                  width: 97,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff3F3F3F),
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              topings[index].image))),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    splashColor: AppThemes.red,
                                    onTap: () {},
                                  ),
                                ),
                              ),
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: AppThemes.red,
                                  child: Icon(Icons.add),
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Text(
                              topings[index].name,
                              style: textTheme.headline6,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Expanded(
                child: BlocBuilder<BurgerBloc, BurgerState>(
                  builder: (context, state) {
                    return Align(
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: StyledText(
                              maxLines: 2,
                              text:
                                  "${state.selected?.title} \n<price>${state.selected?.price}€</price>",
                              style:
                                  textTheme.headline1?.copyWith(fontSize: 25),
                              tags: {
                                "price": StyledTextTag(
                                    style: textTheme.headline1?.copyWith(
                                  color: AppThemes.red,
                                  shadows: const [
                                    Shadow(
                                        // bottomLeft
                                        offset: Offset(-1.5, -1.5),
                                        color: Colors.white),
                                    Shadow(
                                        // bottomRight
                                        offset: Offset(1.5, -1.5),
                                        color: Colors.white),
                                    Shadow(
                                        // topRight
                                        offset: Offset(1.5, 1.5),
                                        color: Colors.white),
                                    Shadow(
                                        // topLeft
                                        offset: Offset(-1.5, 1.5),
                                        color: Colors.white),
                                  ],
                                ))
                              },
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _controller.forward();
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Image.asset(
                                      Assets.imagesStar,
                                      width: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "5.0",
                                      style: textTheme.headline6,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                  flex: 2,
                  child: BlocBuilder<BurgerBloc, BurgerState>(
                      builder: (context, state) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        child: Text(
                          "${state.selected?.description}\n Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                          style: textTheme.bodyText1
                              ?.copyWith(color: Color(0xff898181)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    );
                  })),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        child: QuantityCounter(
                          onChanged: _onChangedQuantity,
                          initValue: 0,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<OrderBloc, OrderState>(
                                builder: (context, state) {
                              return Text(
                                "Total ${state.total.toEuro()}€",
                                style: textTheme.headline6,
                              );
                            }),
                            BlocBuilder<OrderBloc, OrderState>(
                                builder: (context, state) {
                              return SizedBox(
                                height: 50,
                                child: ConfirmOrder(
                                  onPressed: _onAddOrder,
                                  total: state.total,
                                ),
                              );
                            })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
