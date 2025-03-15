import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:portfolio_thanh_tung/constants/const_color.dart';
import 'package:portfolio_thanh_tung/data/repository/api_service_repository.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/widgets/chart_widget.dart';
import 'package:portfolio_thanh_tung/modules/dashboard/widgets/index.dart';

import '../../constants/const_images.dart';
import '../../constants/constants.dart';
import '../../global_widgets/sphere_animation.dart';
import '../../utils/alert.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_event.dart';
import 'bloc/dashboard_state.dart';
import 'models/index.dart';
import 'widgets/my_project_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create:
          (context) =>
              DashboardBloc(ApiServiceRepository())..add(InitDashBoardEvent()),
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
        listener: (BuildContext context, state) {
          switch (state.status) {
            case DashboardStatus.init:
              // TODO: Handle this case.
              break;
            case DashboardStatus.loaded:
              // TODO: Handle this case.
              break;
            case DashboardStatus.error:
              // TODO: Handle this case.
              // print("DashboardStatus.error");
              Alert.showLoading(
                context,
                message: state.dashboardModel?.errorMessage ?? "",
              );
              break;
          }
        },
        builder: (context, state) {
          return state.status == DashboardStatus.init
              ? SphereAnimation()
              : SingleChildScrollView(
                controller: _scrollController,
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

                    _SkillWidget(scrollController: _scrollController),
                    _MyProject(scrollController: _scrollController),
                    // Container(
                    //   // height: height,
                    //   width: width,
                    //   child: MyProjectWidget(),
                    // ),
                  ],
                ),
              );
        },
      ),
    );
  }
}

class _SkillWidget extends StatelessWidget {
  _SkillWidget({super.key, required this.scrollController});

  ScrollController scrollController;

  // final ChartSkillModel chartSkillModel;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bloc = BlocProvider.of<DashboardBloc>(context);
    return Container(
      // height: height,
      width: width,
      padding: ConstStyles.padding_25,
      child: Column(
        children: [
          Text(
            "Skill",
            style: TextStyle(
              color: ConstColors.white,
              fontSize: ConstStyles.fontTitle(width),
            ),
          ),
          Wrap(
            children: List.generate(bloc.state.listSkill.length, (index) {
              ChartSkillModel data = bloc.state.listSkill[index];
              return Container(
                width: width / 2.3,
                padding: EdgeInsets.all(15),
                child: ChartWidget(
                  chartSkillModel: data,
                  scrollController: scrollController,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _MyProject extends StatelessWidget {
  _MyProject({super.key, required this.scrollController});

  ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bloc = BlocProvider.of<DashboardBloc>(context);
    return Container(
      padding: ConstStyles.paddingWeb(width),

      child: Column(
        children: [
          Text(
            "My Project",
            style: TextStyle(
              color: ConstColors.white,
              fontSize: ConstStyles.fontTitle(width),
            ),
          ),
          ...List.generate(bloc.state.listProject.length, (index) {
            ProjectModel data = bloc.state.listProject[index];
            return _ProjectWidget(
              projectModel: data,
              scrollController: scrollController,
            );
          }),
        ],
      ),
    );
  }
}

class _ProjectWidget extends StatefulWidget {
  const _ProjectWidget({
    super.key,
    required this.projectModel,
    required this.scrollController,
  });

  final ProjectModel projectModel;
  final ScrollController scrollController;

  @override
  State<_ProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<_ProjectWidget> {
  bool isAnimate = false;
  double? _previousWidth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollListener();
  }

  scrollListener() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    widget.scrollController.addListener(() => _scrollListener());
    // });
  }

  _scrollListener() {
    RenderBox renderBox =
        widget.projectModel.key.currentContext!.findRenderObject()!
            as RenderBox;
    final tapLocationOffset = renderBox.localToGlobal(Offset.zero);
    _handeAnimate(
      dWidget: tapLocationOffset.dy,
      dScroll: widget.scrollController.offset,
    );
  }

  _handeAnimate({double dWidget = 0, double dScroll = 0}) {
    setState(() {
      if (dScroll >= dWidget) {
        // dAnimate = 1;
        print("true ${widget.projectModel.name}");
        isAnimate = true;
      } else {
        isAnimate = false;
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    double currentWidth = MediaQuery.of(context).size.width;
    if (_previousWidth != currentWidth) {
      _previousWidth = currentWidth;
      scrollListener();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: ConstStyles.paddingWebVertical(width),
      child: IntrinsicHeight(
        key: widget.projectModel.key,

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.topCenter,
                    // height: width * .01,
                    // width: width * .01,
                    // color: Colors.white,
                    decoration: BoxDecoration(),
                    child: Image.network(
                      widget.projectModel.logo,
                      fit: BoxFit.cover,
                      height: width * .1,
                      width: width * .1,
                      errorBuilder: (context, error, stackTrace) {
                        return Text(
                          'Error image',
                          style: TextStyle(color: ConstColors.red),
                        );
                      },
                    ),
                  ),
                )
                .animate(target: isAnimate ? 1 : 0)
                .moveX(begin: -width * .25, end: 0, duration: 1000.ms),
            Flexible(
              child: Container(
                margin: ConstStyles.paddingWebHorizontal(width),
                decoration: BoxDecoration(
                  color: ConstColors.orange,

                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                width: 10,
                // child: Text("4"),
              ),
            ),
            Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.projectModel.name ?? "",
                        style: TextStyle(
                          color: ConstColors.white,
                          fontSize: ConstStyles.fontTitle(width),
                        ),
                      ),
                      HtmlWidget(
                        widget.projectModel.html![FlutterI18n.currentLocale(
                                  context,
                                )?.languageCode ??
                                "en"] ??
                            "",
                        // style: TextStyle(color: ConstColors.white),
                      ),
                    ],
                  ),
                )
                .animate(target: isAnimate ? 1 : 0)
                .moveX(begin: width * .25, end: 0, duration: 1000.ms),
          ],
        ),
      ),
    );
  }
}
