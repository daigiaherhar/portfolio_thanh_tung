import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../models/tabbar_custom_model.dart';

class MyProjectWidget extends StatelessWidget {
  const MyProjectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bloc = BlocProvider.of<DashboardBloc>(context);
    return BlocConsumer<DashboardBloc, DashboardState>(
      bloc: bloc,
      listener: (BuildContext context, DashboardState state) {
        print("state.toString()");
        print(state.toString());
      },
      builder: (context, state) {
        return Container(
          // height: height,
          width: width,
          padding: ConstStyles.padding_25,
          child: Column(
            children: [
              Text(
                "My Project",
                style: TextStyle(
                  color: ConstColors.white,
                  fontSize: ConstStyles.fontTitle(width),
                ),
              ),
              _TabBarCustom(),
              _TabView(),
            ],
          ),
        );
      },
    );
  }
}

class _TabBarCustom extends StatelessWidget {
  const _TabBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bloc = BlocProvider.of<DashboardBloc>(context);
    return Container(
      width: width,
      // height: height,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: width,
            color: Colors.transparent,
            height: height * 0.04,
          ),
          ..._listTab(
            context,
            list: bloc.state.listProject,
            onTap:
                (int position) =>
                    bloc.add(ChangeTabBarEvent(position: position)),
          ),
          AnimatedPositioned(
            curve: Curves.fastOutSlowIn,
            left:
                bloc.state.indexTab == 0
                    ? 0
                    : (width * .9 / bloc.state.listProject.length) *
                        bloc.state.indexTab,
            right:
                bloc.state.indexTab == bloc.state.listProject.length - 1
                    ? 0
                    : null,
            duration: Duration(milliseconds: 800),
            child: Container(
              width: (width * 1.1) / bloc.state.listProject.length,
              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 0),
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: ConstColors.orange,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  bloc.state.listProject[bloc.state.indexTab].title ?? "",
                  style: TextStyle(color: ConstColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _listTab(
    context, {
    required List<TabBarCustomModel> list,
    required Function(int position) onTap,
  }) {
    final width = MediaQuery.of(context).size.width;
    return List.generate(list.length, (index) {
      TabBarCustomModel data = list[index];
      double? dLeft() {
        double? left;
        int length = list.length;

        if (length >= 4) {
          index > 0 ? left = ((width * 0.9) / length) * index : left = 0;
          return left;
        }
        //less count 3
        length > 1
            ? index >= 1
                ? left = null
                : left = 0
            : left = 0;
        return left;
      }

      double? dRight() {
        double? right;
        int length = list.length;
        if (length >= 4) {
          // index > 0 ? right = ((width * 0.9) / length) * index : left = 0;
          return null;
        }
        length - 1 == index ? right = 0 : right = null;

        return right;
      }

      return Positioned(
        key: data.key,
        left: dLeft(),
        right: dRight(),

        // left: 0,
        child: InkWell(
          onTap: () => onTap(data.id),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 4, color: ConstColors.white),
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              width: width / list.length,
              decoration: BoxDecoration(
                color: ConstColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  data.title ?? "",
                  style: TextStyle(color: ConstColors.white),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _TabView extends StatelessWidget {
  const _TabView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bloc = BlocProvider.of<DashboardBloc>(context);
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 15),
      color: Colors.amberAccent,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(

              child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9SRRmhH4X5N2e4QalcoxVbzYsD44C-sQv-w&s",
             fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(children: [
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
              ],),
            )
          ],
        ),
      ),
    );
  }
}
