import 'package:burger/core/assets/assets.dart';
import 'package:burger/presentation/blocs/burger/burger_bloc.dart';
import 'package:burger/presentation/blocs/order/order_bloc.dart';
import 'package:burger/presentation/components/errors/server_error.dart';
import 'package:burger/presentation/pages/detail/detail_page.dart';
import 'package:burger/presentation/pages/home/widgets/burger_stack.dart';
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

  @override
  Widget build(BuildContext context) {
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
                      child: BurgerStack(
                        burger: burger,
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
              const ServerErrorWidget(),
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
