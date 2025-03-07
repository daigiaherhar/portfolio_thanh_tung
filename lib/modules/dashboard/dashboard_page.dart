import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:portfolio_thanh_tung/constants/const_color.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/widgets/index.dart';

import '../../constants/const_images.dart';
import '../../constants/constants.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_event.dart';
import 'bloc/dashboard_state.dart';
import 'widgets/my_project_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => DashboardBloc()..add(InitDashBoardEvent()),
      child: _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // final bloc = BlocProvider.of<DashboardBloc>(context);

    return Scaffold(
      backgroundColor: ConstColors.background,
      body: BlocConsumer<DashboardBloc, DashboardState>(
        // bloc: bloc,
        listener: (BuildContext context, state) {  },
        builder: (context,state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * .9,
                  child: BannerWidget(
                    title: FlutterI18n.translate(context, "dashboard.name"),
                    description:
                        "tôi la doan thanh tung, toi đến từ tuong laitôi la doan thanh tung, toi đến từ tuong laitôi la doan thanh tung, toi đến từ tuong laitôi la doan thanh tung, toi đến từ tuong lai",
                  ),
                ),
                Container(
                  // height: height,
                  width: width,
                  child: MyProjectWidget(),
                ),
                // BannerWidget(
                //   title: FlutterI18n.translate(context, "dashboard.name"),
                //   description:
                //       "tôi la doan thanh tung, toi đến từ tuong laitôi la doan thanh tung, toi đến từ tuong laitôi la doan thanh tung, toi đến từ tuong laitôi la doan thanh tung, toi đến từ tuong lai",
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
