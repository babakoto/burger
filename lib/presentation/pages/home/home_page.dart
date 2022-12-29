import 'dart:math';

import 'package:burger/core/assets/assets.dart';
import 'package:burger/presentation/blocs/burger/burger_bloc.dart';
import 'package:burger/presentation/blocs/order/order_bloc.dart';
import 'package:burger/presentation/components/errors/server_error.dart';
import 'package:burger/presentation/pages/detail/detail_page.dart';
import 'package:burger/presentation/pages/home/widgets/custom_app_bar.dart';
import 'package:burger/presentation/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  static const path = "/";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late RefreshController _refreshController;
  late final AnimationController _controller;

  bool like = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    _controller = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  _onLike() {
    if (!like) {
      _controller.forward();
      like = !like;
    } else {
      _controller.reverse();
      like = !like;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(
        name: "Tokiniaina Eddy",
        photo: Assets.imagesUser,
      ),
      body: BlocBuilder<BurgerBloc, BurgerState>(builder: (context, state) {
        if (state.burgerStatus.isSuccess) {
          return SmartRefresher(
            enablePullDown: true,
            controller: _refreshController,
            onRefresh: () async {
              context.read<BurgerBloc>().add(OnFindBurgers());
              _refreshController.refreshCompleted();
            },
            header: const WaterDropMaterialHeader(
              backgroundColor: AppThemes.backgroundColor,
            ),
            child: ListView.builder(
                itemCount: state.burgers.length,
                itemBuilder: (context, int index) {
                  final burger = state.burgers[index];
                  return InkWell(
                    onTap: () {
                      context
                          .read<BurgerBloc>()
                          .add(OnFindBurgersByRef(ref: "${burger.ref}"));
                      context
                          .read<OrderBloc>()
                          .add(OnCreateOrder(burger: burger, quantity: 0));
                      Navigator.pushNamed(context, DetailPage.path);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 12),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 120,
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
                                onPressed: _onLike,
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
                      ),
                    ),
                  );
                }),
          );
        }

        if (state.burgerStatus.isFailure) {
          return Center(
              child: Column(
            children: [
              ServerErrorWidget(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppThemes.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    context.read<BurgerBloc>().add(OnFindBurgers());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Retry"),
                  )),
            ],
          ));
        }

        return Center(
          child: Column(
            children: [
              Lottie.asset(Assets.jsonLoading),
              const Text("Loading ...")
            ],
          ),
        );
      }),
    );
  }
}
